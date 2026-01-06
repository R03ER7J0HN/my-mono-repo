import 'package:budget_core/src/data/datasources/local_data_source.dart';
import 'package:budget_core/src/domain/repositories/app_data_repository.dart';

/// Implementation of [AppDataRepository] using local SQLite storage.
class AppDataRepositoryImpl implements AppDataRepository {
  /// Creates an instance with the required data source.
  const AppDataRepositoryImpl(this._dataSource);

  final LocalDataSource _dataSource;

  @override
  Future<void> clearAllData() => _dataSource.clearAllData();
}
