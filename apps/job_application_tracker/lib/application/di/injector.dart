import 'package:authentication/firebase_authentication.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/application/notification/local_notification_service.dart';
import 'package:notification/firebase_notification.dart';

export 'package:authentication/firebase_authentication.dart';
export 'package:job_application_tracker/application/notification/local_notification_service.dart';
export 'package:notification/firebase_notification.dart';

class Injector {
  const Injector._();

  static void initialize() {
    GetIt.I.registerLazySingleton(
      () => LocalNotificationService(FlutterLocalNotificationsPlugin()),
    );

    FirebaseAuthentication.initialize(GetIt.I);
    FirebaseNotification.initialize(GetIt.I);
    JobApplication.initialize(GetIt.I);
  }
}
