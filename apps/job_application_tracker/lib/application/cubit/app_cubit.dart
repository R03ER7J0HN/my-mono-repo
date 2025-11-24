import 'dart:async';

import 'package:firebase_notification/firebase_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:job_application_tracker/application/cubit/app_state.dart';
import 'package:job_application_tracker/application/notification/local_notification_service.dart';

class AppCubit extends Cubit<AppState>
    with ChangeNotifier, SafeEmitMixin<AppState> {
  AppCubit(this._remoteNotificationRepository, this._localNotificationService)
    : super(const AppState(status: AppStatus.initial)) {
    unawaited(checkAuthStatus());
    unawaited(_initNotifications());
  }

  final RemoteNotificationRepository _remoteNotificationRepository;
  final LocalNotificationService _localNotificationService;

  StreamSubscription<Notification>? _onMessageSubscription;
  StreamSubscription<Notification>? _onMessageOpenedAppSubscription;

  Future<void> checkAuthStatus() async {
    // Simulate some delay for checking auth status
    Future.delayed(const Duration(seconds: 2), () {
      safeEmit(const AppState(status: AppStatus.unauthenticated));
    });
  }

  @override
  Future<void> close() async {
    await _onMessageSubscription?.cancel();
    await _onMessageOpenedAppSubscription?.cancel();
    return super.close();
  }

  @override
  void emit(AppState state) {
    super.emit(state);
    notifyListeners();
  }

  void login() => safeEmit(const AppState(status: AppStatus.authenticated));

  void logout() => safeEmit(const AppState(status: AppStatus.unauthenticated));

  Future<void> _initNotifications() async {
    await _localNotificationService.initialize();

    final permissionResult = await _remoteNotificationRepository
        .requestPermission();
    if (permissionResult.isFailure) {
      debugPrint('Failed to request notification permission');
      return;
    }

    final tokenResult = await _remoteNotificationRepository.getToken();
    if (tokenResult.isSuccess) {
      debugPrint('FCM Token: ${tokenResult.getSuccess()}');
    }

    _onMessageSubscription ??= _remoteNotificationRepository.onMessage.listen((
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

    _onMessageOpenedAppSubscription ??= _remoteNotificationRepository
        .onMessageOpenedApp
        .listen((
          notification,
        ) {
          // Handle notification opened app (e.g. navigation)
          safeEmit(state.copyWith(lastNotification: notification));
        });
  }
}
