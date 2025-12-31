import 'package:budget_core/src/domain/entities/transaction_entity.dart';
import 'package:budget_core/src/domain/repositories/transaction_repository.dart';
import 'package:flutter_core/flutter_core.dart';

/// Use case for retrieving a transaction by its ID.
class GetTransactionByIdUseCase {
  const GetTransactionByIdUseCase(this._repository);

  final TransactionRepository _repository;

  /// Execute the use case to get a transaction by ID.
  FutureResult<TransactionEntity> call(String transactionId) {
    return _repository.getById(transactionId);
  }
}
