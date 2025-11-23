import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/src/utils/firebase_exception_handler.dart';
import 'package:firebase_notification/src/notification.dart';
import 'package:firebase_notification/src/notification_service.dart';
import 'package:flutter_core/flutter_core.dart';

/// A concrete implementation of [NotificationService] using Firebase Cloud Messaging.
/// This class is internal to the package.
class NotificationServiceImpl
    with FirebaseExceptionHandler
    implements NotificationService {
  /// Creates an instance of [NotificationServiceImpl].
  NotificationServiceImpl(this._firebaseMessaging);

  final FirebaseMessaging _firebaseMessaging;
  final StreamController<Notification> _onMessageController =
      StreamController.broadcast();
  final StreamController<Notification> _onMessageOpenedAppController =
      StreamController.broadcast();

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

  /// Correctly maps a RemoteMessage to the internal Notification model.
  Notification _mapToNotification(RemoteMessage message) {
    return Notification(
      title: message.notification?.title,
      body: message.notification?.body,
      data: message.data,
    );
  }

  @override
  FutureResult<String?> getToken() {
    return handleFirebaseException(
      _firebaseMessaging.getToken(),
      onSuccess: (token) => token,
    );
  }

  @override
  Stream<Notification> get onMessage => _onMessageController.stream;

  @override
  Stream<Notification> get onMessageOpenedApp =>
      _onMessageOpenedAppController.stream;

  @override
  FutureResult<void> requestPermission() {
    return handleFirebaseException(
      _firebaseMessaging.requestPermission(),
      onSuccess: (_) {},
    );
  }

  /// Closes the stream controllers when the service is disposed.
  void dispose() {
    _onMessageController.close();
    _onMessageOpenedAppController.close();
  }
}
