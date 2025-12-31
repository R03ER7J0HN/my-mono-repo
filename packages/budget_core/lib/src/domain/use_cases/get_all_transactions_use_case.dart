import 'package:budget_core/src/domain/entities/transaction_entity.dart';
import 'package:budget_core/src/domain/repositories/transaction_repository.dart';
import 'package:flutter_core/flutter_core.dart';

/// Use case for retrieving all transactions.
class GetAllTransactionsUseCase {
  const GetAllTransactionsUseCase(this._repository);

  final TransactionRepository _repository;

  /// Execute the use case to get all transactions.
  FutureResult<List<TransactionEntity>> call() {
    return _repository.getAll();
  }
}
