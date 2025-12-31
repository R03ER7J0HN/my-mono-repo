import 'package:budget_core/src/data/datasources/local_data_source.dart';

/// Use case for resetting all app data to initial state.
///
/// This removes:
/// - All accounts
/// - All transactions
/// - All installments
/// - All monthly budgets
/// - All custom categories
///
/// Default system categories are restored.
class ResetAllDataUseCase {
  const ResetAllDataUseCase(this._dataSource);

  final LocalDataSource _dataSource;

  /// Execute the use case to clear all data.
  Future<void> call() async {
    await _dataSource.clearAllData();
  }
}
