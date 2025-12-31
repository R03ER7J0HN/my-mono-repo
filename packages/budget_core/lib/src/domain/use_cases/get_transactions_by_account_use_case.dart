import 'package:budget_core/src/domain/entities/transaction_entity.dart';
import 'package:budget_core/src/domain/repositories/transaction_repository.dart';
import 'package:flutter_core/flutter_core.dart';

/// Use case for retrieving transactions by account ID.
class GetTransactionsByAccountUseCase {
  const GetTransactionsByAccountUseCase(this._repository);

  final TransactionRepository _repository;

  /// Execute the use case to get transactions for a specific account.
  FutureResult<List<TransactionEntity>> call(String accountId) {
    return _repository.getByAccount(accountId);
  }
}
