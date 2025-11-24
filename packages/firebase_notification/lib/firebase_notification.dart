import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/src/firebase_notification_repository.dart';
import 'package:firebase_notification/src/remote_notification_repository.dart';
import 'package:get_it/get_it.dart';

export 'src/notification.dart';
export 'src/remote_notification_repository.dart';

/// The main class for the Firebase Notification package.
class FirebaseNotification {
  const FirebaseNotification._();

  /// Initializes the notification service and registers it for dependency injection.
  ///
  /// This method should be called once at app startup.
  static void initialize(GetIt di) {
    di..registerLazySingleton<RemoteNotificationRepository>(
      () =>
          FirebaseNotificationRepository(FirebaseMessaging.instance)
            ..initialize(),
    );
  }
}
