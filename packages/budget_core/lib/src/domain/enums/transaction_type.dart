/// Types of financial transactions
enum TransactionType {
  /// Money coming in (salary, refund, payment received)
  income,

  /// Money going out (purchase, bill, payment)
  expense,

  /// Transfer between accounts
  transfer;

  /// Display name for UI
  String get displayName {
    switch (this) {
      case TransactionType.income:
        return 'Income';
      case TransactionType.expense:
        return 'Expense';
      case TransactionType.transfer:
        return 'Transfer';
    }
  }
}
