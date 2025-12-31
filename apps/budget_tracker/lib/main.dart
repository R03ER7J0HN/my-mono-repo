import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/router/app_router.dart';
import 'package:budget_tracker/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await _initializeDependencies();

  runApp(const BudgetTrackerApp());
}

Future<void> _initializeDependencies() async {
  final getIt = GetIt.I;

  // Initialize Budget Core (SQLite database + repositories)
  await BudgetCore.initialize(getIt);
}

class BudgetTrackerApp extends StatefulWidget {
  const BudgetTrackerApp({super.key});

  @override
  State<BudgetTrackerApp> createState() => _BudgetTrackerAppState();
}

class _BudgetTrackerAppState extends State<BudgetTrackerApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Budget Tracker',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: _router.instance,
    );
  }
}
