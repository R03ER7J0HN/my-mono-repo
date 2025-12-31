/// Payment frequency for installments
enum InstallmentFrequency {
  /// Monthly payments
  monthly,

  /// Quarterly payments
  quarterly,

  /// Yearly payments
  yearly;

  /// Display name for UI
  String get displayName {
    switch (this) {
      case InstallmentFrequency.monthly:
        return 'Monthly';
      case InstallmentFrequency.quarterly:
        return 'Quarterly';
      case InstallmentFrequency.yearly:
        return 'Yearly';
    }
  }
}
