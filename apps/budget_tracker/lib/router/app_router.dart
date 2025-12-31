import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/accounts/account_entry/account_entry_screen.dart';
import 'package:budget_tracker/features/accounts/accounts_screen.dart';
import 'package:budget_tracker/features/analytics/analytics_screen.dart';
import 'package:budget_tracker/features/categories/categories_screen.dart';
import 'package:budget_tracker/features/categories/category_entry/category_entry_screen.dart';
import 'package:budget_tracker/features/dashboard/dashboard_screen.dart';
import 'package:budget_tracker/features/installments/installment_entry/installment_entry_screen.dart';
import 'package:budget_tracker/features/installments/installments_screen.dart';
import 'package:budget_tracker/features/monthly_budget/monthly_budget_screen.dart';
import 'package:budget_tracker/features/transactions/transaction_entry/transaction_entry_screen.dart';
import 'package:budget_tracker/features/transactions/transactions_screen.dart';
import 'package:budget_tracker/router/app_routes.dart';
import 'package:budget_tracker/widgets/navigation/scaffold_with_nav_bar.dart';
import 'package:go_router/go_router.dart';

/// App router configuration
class AppRouter {
  AppRouter();

  late final GoRouter instance = GoRouter(
    initialLocation: AppRoutes.dashboard.path,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(
            name: AppRoutes.dashboard.name,
            path: AppRoutes.dashboard.path,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
          GoRoute(
            name: AppRoutes.accounts.name,
            path: AppRoutes.accounts.path,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AccountsScreen(),
            ),
          ),
          GoRoute(
            name: AppRoutes.transactions.name,
            path: AppRoutes.transactions.path,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TransactionsScreen(),
            ),
          ),
          GoRoute(
            name: AppRoutes.installments.name,
            path: AppRoutes.installments.path,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: InstallmentsScreen(),
            ),
          ),
        ],
      ),
      // Analytics as standalone screen
      GoRoute(
        name: AppRoutes.analytics.name,
        path: AppRoutes.analytics.path,
        builder: (context, state) => const AnalyticsScreen(),
      ),
      // Entry screens as standalone routes
      GoRoute(
        name: AppRoutes.accountEntry.name,
        path: AppRoutes.accountEntry.path,
        builder: (context, state) {
          final account = state.extra as AccountEntity?;
          return AccountEntryScreen(account: account);
        },
      ),
      GoRoute(
        name: AppRoutes.transactionEntry.name,
        path: AppRoutes.transactionEntry.path,
        builder: (context, state) {
          final transaction = state.extra as TransactionEntity?;
          return TransactionEntryScreen(transaction: transaction);
        },
      ),
      GoRoute(
        name: AppRoutes.installmentEntry.name,
        path: AppRoutes.installmentEntry.path,
        builder: (context, state) {
          final installment = state.extra as InstallmentEntity?;
          return InstallmentEntryScreen(installment: installment);
        },
      ),
      GoRoute(
        name: AppRoutes.categories.name,
        path: AppRoutes.categories.path,
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        name: AppRoutes.categoryEntry.name,
        path: AppRoutes.categoryEntry.path,
        builder: (context, state) {
          final category = state.extra as CategoryEntity?;
          return CategoryEntryScreen(category: category);
        },
      ),
      GoRoute(
        name: AppRoutes.monthlyBudget.name,
        path: AppRoutes.monthlyBudget.path,
        builder: (context, state) => const MonthlyBudgetScreen(),
      ),
    ],
  );
}
