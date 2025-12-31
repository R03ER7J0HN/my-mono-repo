/// Budget Core Package
///
/// Core package for budget tracking with domain entities and repository
/// contracts that can be reused across multiple apps.
library;

import 'package:budget_core/src/data/datasources/local_data_source.dart';
import 'package:budget_core/src/data/repositories/account_repository_impl.dart';
import 'package:budget_core/src/data/repositories/category_repository_impl.dart';
import 'package:budget_core/src/data/repositories/installment_repository_impl.dart';
import 'package:budget_core/src/data/repositories/monthly_budget_repository_impl.dart';
import 'package:budget_core/src/data/repositories/transaction_repository_impl.dart';
import 'package:budget_core/src/domain/repositories/account_repository.dart';
import 'package:budget_core/src/domain/repositories/category_repository.dart';
import 'package:budget_core/src/domain/repositories/installment_repository.dart';
import 'package:budget_core/src/domain/repositories/monthly_budget_repository.dart';
import 'package:budget_core/src/domain/repositories/transaction_repository.dart';
import 'package:budget_core/src/domain/use_cases/delete_transaction_use_case.dart';
import 'package:budget_core/src/domain/use_cases/get_all_transactions_use_case.dart';
import 'package:budget_core/src/domain/use_cases/get_transaction_by_id_use_case.dart';
import 'package:budget_core/src/domain/use_cases/get_transactions_by_account_use_case.dart';
import 'package:budget_core/src/domain/use_cases/reset_all_data_use_case.dart';
import 'package:budget_core/src/domain/use_cases/save_transaction_use_case.dart';
import 'package:budget_core/src/domain/use_cases/watch_transactions_use_case.dart';
import 'package:get_it/get_it.dart';

export 'src/data/data.dart';
export 'src/domain/domain.dart';

/// Initializes the budget_core package with dependency injection
class BudgetCore {
  const BudgetCore._();

  /// Initialize all budget core dependencies
  static Future<void> initialize(GetIt instance) async {
    final dataSource = await LocalDataSource.createDatabase();

    instance
      ..registerSingleton<LocalDataSource>(dataSource)
      ..registerLazySingleton<AccountRepository>(
        () => AccountRepositoryImpl(dataSource),
      )
      ..registerLazySingleton<TransactionRepository>(
        () => TransactionRepositoryImpl(dataSource),
      )
      ..registerLazySingleton<InstallmentRepository>(
        () => InstallmentRepositoryImpl(dataSource),
      )
      ..registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImpl(dataSource),
      )
      ..registerLazySingleton<MonthlyBudgetRepository>(
        () => MonthlyBudgetRepositoryImpl(dataSource),
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
      )
      ..registerLazySingleton<GetAllTransactionsUseCase>(
        () => GetAllTransactionsUseCase(instance<TransactionRepository>()),
      )
      ..registerLazySingleton<GetTransactionByIdUseCase>(
        () => GetTransactionByIdUseCase(instance<TransactionRepository>()),
      )
      ..registerLazySingleton<GetTransactionsByAccountUseCase>(
        () =>
            GetTransactionsByAccountUseCase(instance<TransactionRepository>()),
      )
      ..registerLazySingleton<WatchTransactionsUseCase>(
        () => WatchTransactionsUseCase(instance<TransactionRepository>()),
      )
      ..registerLazySingleton<ResetAllDataUseCase>(
        () => ResetAllDataUseCase(dataSource),
      );
  }
}
