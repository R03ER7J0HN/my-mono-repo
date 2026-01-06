/// Types of financial transactions
enum TransactionType {
  /// Money coming in (salary, refund, payment received)
  income('Income'),

  /// Money going out (purchase, bill, payment)
  expense('Expense'),

  /// Transfer between accounts
  transfer('Transfer');

  const TransactionType(this.displayName);

  /// Display name for UI
  final String displayName;
}
