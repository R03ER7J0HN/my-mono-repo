import 'dart:async';

import 'package:authentication/firebase_authentication.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:job_application_tracker/application/cubit/app_state.dart';
import 'package:job_application_tracker/application/notification/local_notification_service.dart';
import 'package:notification/firebase_notification.dart';

class AppCubit extends Cubit<AppState> with SafeEmitMixin<AppState> {
  AppCubit(
    this._notificationRepository,
    this._localNotificationService,
    this._authenticationRepository,
  ) : super(const AppState(status: AppStatus.initial));

  final NotificationRepository _notificationRepository;
  final LocalNotificationService _localNotificationService;
  final AuthenticationRepository _authenticationRepository;

  StreamSubscription<NotificationEntity>? _onMessageSubscription;
  StreamSubscription<NotificationEntity>? _onMessageOpenedAppSubscription;

  Future<void> initialize() async {
    unawaited(_initNotifications());
    await checkAuthStatus();
  }

  void login() => safeEmit(
    const AppState(status: AppStatus.authenticated),
  );

  void logout() => safeEmit(
    const AppState(status: AppStatus.unauthenticated),
  );

  Future<void> checkAuthStatus() async {
    final result = await _authenticationRepository.getSignedInUser();
    result.fold(
      onFailure: (failure) {
        safeEmit(
          const AppState(status: AppStatus.unauthenticated),
        );
      },
      onSuccess: (user) {
        Future.delayed(
          const Duration(seconds: 2),
          () => safeEmit(
            AppState(
              status: user == null
                  ? AppStatus.unauthenticated
                  : AppStatus.authenticated,
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _onMessageSubscription?.cancel();
    await _onMessageOpenedAppSubscription?.cancel();
    return super.close();
  }

  Future<void> _initNotifications() async {
    await _localNotificationService.initialize();

    final permissionResult = await _notificationRepository.requestPermission();
    if (permissionResult.isFailure) {
      debugPrint('Failed to request notification permission');
      return;
    }

    final tokenResult = await _notificationRepository.getToken();
    if (tokenResult.isSuccess) {
      debugPrint('FCM Token: ${tokenResult.getSuccess()}');
    }

    _onMessageSubscription ??= _notificationRepository.onMessage.listen((
      notification,
    ) async {
      final title = notification.title;
      final body = notification.body;

      if (title == null || body == null) {
        return;
      }

      unawaited(
        _localNotificationService.showNotification(
          id: notification.hashCode,
          title: title,
          body: body,
        ),
      );
      safeEmit(state.copyWith(lastNotification: notification));
    });

    _onMessageOpenedAppSubscription ??= _notificationRepository
        .onMessageOpenedApp
        .listen((
          notification,
        ) {
          // Handle notification opened app (e.g. navigation)
          safeEmit(state.copyWith(lastNotification: notification));
        });
  }
}
