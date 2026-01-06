/// Types of financial accounts supported
enum AccountType {
  /// Physical cash
  cash('Cash'),

  /// Bank debit card
  debitCard('Debit Card'),

  /// Credit card with limit
  creditCard('Credit Card'),

  /// E-wallet (GCash, PayMaya, etc.)
  eWallet('E-Wallet'),

  /// Savings account
  savings('Savings');

  const AccountType(this.displayName);

  /// Display name for UI
  final String displayName;
}
