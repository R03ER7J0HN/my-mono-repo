import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:job_application_tracker/application/cubit/app_cubit.dart';
import 'package:job_application_tracker/application/di/injector.dart';
import 'package:job_application_tracker/application/notification/background_notification_handler.dart';
import 'package:job_application_tracker/features/auth/l10n/gen/app_localizations.dart';
import 'package:job_application_tracker/features/home/l10n/gen/app_localizations.dart';
import 'package:job_application_tracker/features/splash/l10n/gen/app_localizations.dart';
import 'package:job_application_tracker/router/app_router.dart';
import 'package:job_application_tracker/theme/app_theme.dart';

void main() async => await initializeMainApp();

// This method is separated from main to allow easier product flavoring soon.
Future<void> initializeMainApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Injector.initialize();

  FirebaseMessaging.onBackgroundMessage(
    BackgroundNotificationHandler.handleFirebaseMessaging,
  );

  final cubit = AppCubit(
    GetIt.I<NotificationRepository>(),
    GetIt.I<LocalNotificationService>(),
    GetIt.I<AuthenticationRepository>(),
  );
  unawaited(cubit.initialize());

  runApp(
    BlocProvider.value(
      value: cubit,
      child: MainApp(AppRouter(cubit).instance),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp(
    this.routerConfig, {
    super.key,
  });

  final RouterConfig<Object> routerConfig;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    theme: AppTheme.lightTheme,
    localizationsDelegates: const [
      AuthLocalizations.delegate,
      HomeLocalizations.delegate,
      SplashLocalizations.delegate,

      // App-specific localization delegate[s] here
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    routerConfig: routerConfig,
    supportedLocales: const [Locale('en')],
    locale: const Locale('en'),
  );
}
