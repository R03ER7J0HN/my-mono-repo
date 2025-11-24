import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:job_application_tracker/application/cubit/cubit.dart';
import 'package:job_application_tracker/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:job_application_tracker/features/auth/sign_in/sign_in_screen.dart';
import 'package:job_application_tracker/features/auth/sign_up/sign_up_screen.dart';
import 'package:job_application_tracker/features/home/home_screen.dart';
import 'package:job_application_tracker/features/splash/splash_screen.dart';
import 'package:job_application_tracker/router/app_routes.dart';

class AppRouter {
  const AppRouter(this.appCubit);

  final AppCubit appCubit;

  GoRouter get setup => GoRouter(
    initialLocation: AppRoutes.splash.path,
    redirect: _redirectHandler,
    refreshListenable: appCubit,
    routes: [
      GoRoute(
        name: AppRoutes.splash.name,
        path: AppRoutes.splash.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoutes.signIn.name,
        path: AppRoutes.signIn.path,
        builder: (context, state) => const SignInScreen(),
        routes: [
          GoRoute(
            name: AppRoutes.forgotPassword.name,
            path: AppRoutes.forgotPassword.path,
            builder: (context, state) => const ForgotPasswordScreen(),
          ),
        ],
      ),
      GoRoute(
        name: AppRoutes.signUp.name,
        path: AppRoutes.signUp.path,
        builder: (context, state) => const SignUpScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => Scaffold(body: child),
        routes: [
          GoRoute(
            path: AppRoutes.home.path,
            name: AppRoutes.home.name,
            builder: (context, state) => const HomeScreen(),
          ),
        ],
      ),
    ],
  );

  FutureOr<String?> _redirectHandler(
    BuildContext context,
    GoRouterState state,
  ) {
    final status = appCubit.state.status;
    final location = state.uri.toString();

    final isSplashing = location == AppRoutes.splash.path;
    // While the app is determining the auth state, stay on the splash screen.
    if (status == AppStatus.initial) {
      return isSplashing ? null : AppRoutes.splash.path;
    }

    final isAuthenticating =
        location == AppRoutes.signIn.path ||
        location == AppRoutes.signUp.path ||
        location.contains(AppRoutes.forgotPassword.path);
    // If the user is logged out, redirect them to the sign-in screen,
    // unless they are already trying to go there.
    if (status == AppStatus.unauthenticated) {
      return isAuthenticating ? null : AppRoutes.signIn.path;
    }

    // If the user is logged in and tries to go to the sign-in or splash screen,
    // redirect them to the home screen.
    if (status == AppStatus.authenticated &&
        (isAuthenticating || isSplashing)) {
      return AppRoutes.home.path;
    }

    // In all other cases (e.g., a logged-in user accessing a protected route),
    // allow the navigation to proceed.
    return null;
  }
}
