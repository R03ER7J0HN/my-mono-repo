import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/router/app_routes.dart';

class AppNavigator {
  const AppNavigator._();

  static void goToHome(BuildContext context) =>
      context.goNamed(AppRoutes.home.name);

  static void goToSignIn(BuildContext context) =>
      context.goNamed(AppRoutes.signIn.name);

  static void goToSignUp(BuildContext context) =>
      context.goNamed(AppRoutes.signUp.name);

  static void goToForgotPassword(BuildContext context) =>
      context.goNamed(AppRoutes.forgotPassword.name);

  static FutureOr<T?> pushJobEntry<T>(
    BuildContext context, {
    JobApplicationEntity? job,
  }) => context.pushNamed(AppRoutes.jobEntry.name, extra: job);

  static FutureOr<T?> pushInterviewList<T>(
    BuildContext context, {
    required JobApplicationEntity job,
  }) => context.pushNamed(AppRoutes.interviews.name, extra: job);

  static FutureOr<T?> pushInterviewEntry<T>(
    BuildContext context, {
    required JobApplicationEntity job,
    JobInterviewEntity? interview,
  }) => context.pushNamed(
    AppRoutes.interviewEntry.name,
    extra: InterviewEntryArgs(job: job, interview: interview),
  );
}

/// Arguments for the interview entry screen.
class InterviewEntryArgs {
  const InterviewEntryArgs({required this.job, this.interview});

  final JobApplicationEntity job;
  final JobInterviewEntity? interview;
}
