import 'package:budget_core/src/domain/entities/transaction_entity.dart';
import 'package:flutter_core/flutter_core.dart';

/// Repository contract for transaction operations
abstract class TransactionRepository {
  /// Save (create or update) a transaction
  FutureResult<void> save(TransactionEntity transaction);

  /// Delete a transaction by ID
  FutureResult<void> delete(String transactionId);

  /// Get all transactions
  FutureResult<List<TransactionEntity>> getAll();

  /// Get transaction by ID
  FutureResult<TransactionEntity> getById(String transactionId);

  /// Get transactions for a specific account
  FutureResult<List<TransactionEntity>> getByAccount(String accountId);

  /// Watch all transactions (real-time stream)
  Stream<List<TransactionEntity>> watchAll();
}
