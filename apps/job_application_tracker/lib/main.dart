import 'package:firebase_authentication/firebase_authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:job_application_tracker/application/cubit/app_cubit.dart';
import 'package:job_application_tracker/features/auth/l10n/gen/app_localizations.dart';
import 'package:job_application_tracker/features/home/l10n/gen/app_localizations.dart';
import 'package:job_application_tracker/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseAuthentication.initialize(GetIt.I);

  runApp(BlocProvider(create: (_) => AppCubit(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    localizationsDelegates: const [
      AuthLocalizations.delegate,
      HomeLocalizations.delegate,

      // App-specific localization delegate[s] here
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    routerConfig: AppRouter(
      context.read<AppCubit>(),
    ).setup,
    supportedLocales: const [Locale('en')],
    locale: const Locale('en'),
  );
}
