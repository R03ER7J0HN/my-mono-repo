/// Types of financial accounts supported
enum AccountType {
  /// Physical cash
  cash,

  /// Bank debit card
  debitCard,

  /// Credit card with limit
  creditCard,

  /// E-wallet (GCash, PayMaya, etc.)
  eWallet,

  /// Savings account
  savings;

  /// Display name for UI
  String get displayName {
    switch (this) {
      case AccountType.cash:
        return 'Cash';
      case AccountType.debitCard:
        return 'Debit Card';
      case AccountType.creditCard:
        return 'Credit Card';
      case AccountType.eWallet:
        return 'E-Wallet';
      case AccountType.savings:
        return 'Savings';
    }
  }
}
