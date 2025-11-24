import 'package:firebase_authentication/firebase_authentication.dart';
import 'package:firebase_notification/firebase_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:job_application_tracker/application/notification/local_notification_service.dart';

export 'package:firebase_authentication/firebase_authentication.dart';
export 'package:firebase_notification/firebase_notification.dart';
export 'package:job_application_tracker/application/notification/local_notification_service.dart';

class Injector {
  const Injector._();

  static void initialize() {
    GetIt.I.registerLazySingleton(
      () => LocalNotificationService(FlutterLocalNotificationsPlugin()),
    );

    FirebaseAuthentication.initialize(GetIt.I);
    FirebaseNotification.initialize(GetIt.I);
  }
}
