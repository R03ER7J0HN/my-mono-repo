import 'package:flutter_core/flutter_core.dart';
import 'package:notification/src/notification_entity.dart';

/// Defines the contract for a notification service.
///
/// This abstraction allows the application to depend on a stable interface
/// while hiding the implementation details
/// of the underlying messaging provider.
abstract class NotificationRepository {
  /// A stream of notifications received while the app is in the foreground.
  Stream<NotificationEntity> get onMessage;

  /// A stream that emits a [NotificationEntity
  /// when the user taps on a notification,
  /// opening the app from a terminated or background state.
  Stream<NotificationEntity> get onMessageOpenedApp;

  /// Retrieves the unique FCM token for the device.
  ///
  /// This token can be used to send notifications to this specific device.
  FutureResult<String?> getToken();

  /// Requests user permission for notifications (required for iOS and web).
  ///
  /// Returns a [Result.success] if permission is granted or already granted,
  /// otherwise a [Result.failure].
  FutureResult<void> requestPermission();
}
