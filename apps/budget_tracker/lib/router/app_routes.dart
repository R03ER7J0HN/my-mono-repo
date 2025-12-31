/// Routes enum for the app
enum AppRoutes {
  dashboard(path: '/'),
  accounts(path: '/accounts'),
  accountEntry(path: '/account-entry'),
  transactions(path: '/transactions'),
  transactionEntry(path: '/transaction-entry'),
  analytics(path: '/analytics'),
  installments(path: '/installments'),
  installmentEntry(path: '/installment-entry'),
  categories(path: '/categories'),
  categoryEntry(path: '/category-entry'),
  monthlyBudget(path: '/monthly-budget');

  const AppRoutes({required this.path});

  final String path;
}
