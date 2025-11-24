import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:job_application_tracker/application/notification/local_notification_service.dart';

class BackgroundNotificationHandler {
  const BackgroundNotificationHandler._();

  @pragma('vm:entry-point')
  static Future<void> handleFirebaseMessaging(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();

    // We instantiate the LocalNotificationService here manually because
    // we are in a separate Isolate.
    final localService = LocalNotificationService(
      FlutterLocalNotificationsPlugin(),
    );

    await localService.initialize();

    final hashCode = message.notification?.hashCode;
    final title = message.notification?.title;
    final body = message.notification?.body;

    if (hashCode == null || title == null || body == null) {
      return;
    }

    await localService.showNotification(
      id: hashCode,
      title: title,
      body: body,
    );
  }
}
