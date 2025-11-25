import 'package:firebase_notification/src/notification.dart';
import 'package:flutter_core/flutter_core.dart';

/// Defines the contract for a notification service.
///
/// This abstraction allows the application to depend on a stable interface
/// while hiding the implementation details of the underlying messaging provider.
abstract class NotificationRepository {
  /// Requests user permission for notifications (required for iOS and web).
  ///
  /// Returns a [Result.success] if permission is granted or already granted,
  /// otherwise a [Result.failure].
  FutureResult<void> requestPermission();

  /// Retrieves the unique FCM token for the device.
  ///
  /// This token can be used to send notifications to this specific device.
  FutureResult<String?> getToken();

  /// A stream of notifications received while the app is in the foreground.
  Stream<Notification> get onMessage;

  /// A stream that emits a [Notification] when the user taps on a notification,
  /// opening the app from a terminated or background state.
  Stream<Notification> get onMessageOpenedApp;
}
