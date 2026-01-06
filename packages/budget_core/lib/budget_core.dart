/// Budget Core Package
///
/// Core package for budget tracking with domain entities and repository
/// contracts that can be reused across multiple apps.
library;

import 'package:budget_core/src/data/data.dart';
import 'package:budget_core/src/domain/domain.dart';
import 'package:get_it/get_it.dart';

export 'src/data/data.dart';
export 'src/domain/domain.dart';

/// Initializes the budget_core package with dependency injection
class BudgetCore {
  const BudgetCore._();

  /// Initialize all budget core dependencies
  static Future<void> initialize(GetIt instance) async {
    final datasource = await LocalDataSource.createDatabase();

    instance
      ..registerLazySingleton<LocalDataSource>(
        () => datasource,
      )
      ..registerLazySingleton<AccountRepository>(
        () => AccountRepositoryImpl(instance<LocalDataSource>()),
      )
      ..registerLazySingleton<TransactionRepository>(
        () => TransactionRepositoryImpl(instance<LocalDataSource>()),
      )
      ..registerLazySingleton<InstallmentRepository>(
        () => InstallmentRepositoryImpl(instance<LocalDataSource>()),
      )
      ..registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImpl(instance<LocalDataSource>()),
      )
      ..registerLazySingleton<MonthlyBudgetRepository>(
        () => MonthlyBudgetRepositoryImpl(instance<LocalDataSource>()),
      )
      ..registerLazySingleton<AppDataRepository>(
        () => AppDataRepositoryImpl(instance<LocalDataSource>()),
      )
      ..registerLazySingleton<SaveTransactionUseCase>(
        () => SaveTransactionUseCase(
          transactionRepository: instance<TransactionRepository>(),
          accountRepository: instance<AccountRepository>(),
        ),
      )
      ..registerLazySingleton<DeleteTransactionUseCase>(
        () => DeleteTransactionUseCase(
          transactionRepository: instance<TransactionRepository>(),
          accountRepository: instance<AccountRepository>(),
        ),
      );
  }
}
