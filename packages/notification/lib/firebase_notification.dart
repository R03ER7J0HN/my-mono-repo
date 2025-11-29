import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:notification/src/firebase_notification_repository.dart';
import 'package:notification/src/notification_repository.dart';

export 'src/notification_entity.dart';
export 'src/notification_repository.dart';

/// The main class for the Firebase Notification package.
class FirebaseNotification {
  const FirebaseNotification._();

  /// Initializes the notification service
  /// and registers it for dependency injection.
  ///
  /// This method should be called once at app startup.
  static void initialize(GetIt di) {
    di.registerLazySingleton<NotificationRepository>(
      () =>
          FirebaseNotificationRepository(FirebaseMessaging.instance)
            ..initialize(),
    );
  }
}
