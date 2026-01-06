/// Repository for managing app-level data operations.
///
/// This includes operations that span multiple data types,
/// such as resetting all app data.
abstract interface class AppDataRepository {
  /// Clears all user data from the app.
  ///
  /// This removes:
  /// - All accounts
  /// - All transactions
  /// - All installments
  /// - All monthly budgets
  /// - All custom categories
  ///
  /// Default system categories are restored.
  Future<void> clearAllData();
}
