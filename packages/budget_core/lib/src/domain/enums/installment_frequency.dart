/// Payment frequency for installments
enum InstallmentFrequency {
  /// Monthly payments
  monthly('Monthly'),

  /// Quarterly payments
  quarterly('Quarterly'),

  /// Yearly payments
  yearly('Yearly');

  const InstallmentFrequency(this.displayName);

  /// Display name for UI
  final String displayName;
}
