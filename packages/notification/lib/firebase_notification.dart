import 'package:firebase_messaging/firebase_messaging.dart';
import 'src/firebase_notification_repository.dart';
import 'src/notification_repository.dart';
import 'package:get_it/get_it.dart';

export 'src/notification.dart';
export 'src/notification_repository.dart';

/// The main class for the Firebase Notification package.
class FirebaseNotification {
  const FirebaseNotification._();

  /// Initializes the notification service and registers it for dependency injection.
  ///
  /// This method should be called once at app startup.
  static void initialize(GetIt di) {
    di..registerLazySingleton<NotificationRepository>(
      () =>
          FirebaseNotificationRepository(FirebaseMessaging.instance)
            ..initialize(),
    );
  }
}
