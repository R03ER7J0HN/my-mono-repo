import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:job_application_tracker/router/app_routes.dart';

class AppNavigator {
  const AppNavigator._();

  static void goToHome(BuildContext context) =>
      context.goNamed(AppRoutes.home.name);
}
