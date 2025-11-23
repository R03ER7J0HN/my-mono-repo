import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/src/notification_service_impl.dart';
import 'package:firebase_notification/src/notification_service.dart';
import 'package:get_it/get_it.dart';

export 'src/notification.dart';
export 'src/notification_service.dart';

/// A top-level function for handling background messages, as required by Firebase.
///
/// This function must be registered in the app's entry point (e.g., `main.dart`).
@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  // Ensure Firebase is initialized for background processing.
  await Firebase.initializeApp();
  // You can process the background message here, e.g., by storing it
  // or triggering a local notification.
}

/// The main class for the Firebase Notification package.
class FirebaseNotification {
  const FirebaseNotification._();

  /// Initializes the notification service and registers it for dependency injection.
  ///
  /// This method should be called once at app startup.
  static void initialize(GetIt di) {
    di
      ..registerLazySingleton<NotificationService>(
        () => NotificationServiceImpl(FirebaseMessaging.instance)..initialize(),
      )
      ..registerLazySingleton<NotificationService>(
        () => di<NotificationServiceImpl>(),
      );
  }
}
