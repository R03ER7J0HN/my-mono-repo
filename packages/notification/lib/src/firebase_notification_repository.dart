import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:notification/src/firebase_exception_handler.dart';
import 'package:notification/src/notification_entity.dart';
import 'package:notification/src/notification_repository.dart';

/// A concrete implementation of [NotificationRepository]
/// using Firebase Cloud Messaging.
/// This class is internal to the package.
class FirebaseNotificationRepository
    with FirebaseExceptionHandler
    implements NotificationRepository {
  /// Creates an instance of [FirebaseNotificationRepository].
  FirebaseNotificationRepository(this._firebaseMessaging);
  final FirebaseMessaging _firebaseMessaging;

  final StreamController<NotificationEntity> _onMessageController =
      StreamController.broadcast();
  final StreamController<NotificationEntity> _onMessageOpenedAppController =
      StreamController.broadcast();

  @override
  Stream<NotificationEntity> get onMessage => _onMessageController.stream;

  @override
  Stream<NotificationEntity> get onMessageOpenedApp =>
      _onMessageOpenedAppController.stream;

  /// Closes the stream controllers when the service is disposed.
  Future<void> dispose() async {
    await _onMessageController.close();
    await _onMessageOpenedAppController.close();
  }

  @override
  FutureResult<String?> getToken() {
    return handleFirebaseException(
      _firebaseMessaging.getToken(),
      onSuccess: (token) => token,
    );
  }

  /// Initializes the service, setting up listeners for incoming messages.
  /// This is made public to be called from the main package entry point
  /// and to allow for test stream injection.
  void initialize({
    Stream<RemoteMessage>? onMessageStream,
    Stream<RemoteMessage>? onMessageOpenedAppStream,
  }) {
    (onMessageStream ?? FirebaseMessaging.onMessage).listen((
      RemoteMessage message,
    ) {
      _onMessageController.add(_mapToNotification(message));
    });

    (onMessageOpenedAppStream ?? FirebaseMessaging.onMessageOpenedApp).listen((
      RemoteMessage message,
    ) {
      _onMessageOpenedAppController.add(_mapToNotification(message));
    });
  }

  @override
  FutureResult<void> requestPermission() {
    return handleFirebaseException(
      _firebaseMessaging.requestPermission(),
      onSuccess: (_) {},
    );
  }

  /// Correctly maps a RemoteMessage to the internal Notification model.
  NotificationEntity _mapToNotification(RemoteMessage message) {
    return NotificationEntity(
      title: message.notification?.title,
      body: message.notification?.body,
      data: message.data,
    );
  }
}
