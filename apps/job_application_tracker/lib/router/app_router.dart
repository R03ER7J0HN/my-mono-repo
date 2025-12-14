import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/application/cubit/cubit.dart';
import 'package:job_application_tracker/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:job_application_tracker/features/auth/sign_in/sign_in_screen.dart';
import 'package:job_application_tracker/features/auth/sign_up/sign_up_screen.dart';
import 'package:job_application_tracker/features/home/home_screen.dart';
import 'package:job_application_tracker/features/jobs/job_details/job_entry_screen.dart';
import 'package:job_application_tracker/features/jobs/job_list/job_list_screen.dart';
import 'package:job_application_tracker/features/profile/profile_screen.dart';
import 'package:job_application_tracker/features/splash/splash_screen.dart';
import 'package:job_application_tracker/router/app_routes.dart';
import 'package:job_application_tracker/widgets/scaffold_with_nav_bar.dart';

class AppRouter {
  AppRouter(this.appCubit);

  final AppCubit appCubit;

  late final GoRouter instance = GoRouter(
    initialLocation: AppRoutes.splash.path,
    redirect: _redirectHandler,
    refreshListenable: StreamListenable(appCubit.stream),
    routes: [
      GoRoute(
        name: AppRoutes.splash.name,
        path: AppRoutes.splash.path,
        builder: (_, _) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoutes.signIn.name,
        path: AppRoutes.signIn.path,
        builder: (_, _) => const SignInScreen(),
        routes: [
          GoRoute(
            name: AppRoutes.forgotPassword.name,
            path: AppRoutes.forgotPassword.path,
            builder: (_, _) => const ForgotPasswordScreen(),
          ),
        ],
      ),
      GoRoute(
        name: AppRoutes.signUp.name,
        path: AppRoutes.signUp.path,
        builder: (_, _) => const SignUpScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithNavBar(
            items: [
              NavigationItem(
                routePath: AppRoutes.home.path,
                routeName: AppRoutes.home.name,
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: 'Home',
              ),
              NavigationItem(
                routePath: AppRoutes.jobs.path,
                routeName: AppRoutes.jobs.name,
                icon: Icons.work_outline,
                selectedIcon: Icons.work,
                label: 'Jobs',
              ),
              NavigationItem(
                routePath: AppRoutes.profile.path,
                routeName: AppRoutes.profile.name,
                icon: Icons.person_outline,
                selectedIcon: Icons.person,
                label: 'Profile',
              ),
            ],
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: AppRoutes.home.path,
            name: AppRoutes.home.name,
            builder: (_, _) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.jobs.path,
            name: AppRoutes.jobs.name,
            builder: (_, _) => const JobListScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile.path,
            name: AppRoutes.profile.name,
            builder: (_, _) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        name: AppRoutes.jobEntry.name,
        path: AppRoutes.jobEntry.path,
        builder: (context, state) {
          final job = state.extra as JobApplicationEntity?;
          return JobEntryScreen(job: job);
        },
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
