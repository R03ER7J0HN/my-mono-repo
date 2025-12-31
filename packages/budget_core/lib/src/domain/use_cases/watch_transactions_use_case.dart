import 'package:budget_core/src/domain/entities/transaction_entity.dart';
import 'package:budget_core/src/domain/repositories/transaction_repository.dart';

/// Use case for watching transaction changes as a stream.
class WatchTransactionsUseCase {
  const WatchTransactionsUseCase(this._repository);

  final TransactionRepository _repository;

  /// Execute the use case to watch all transactions.
  Stream<List<TransactionEntity>> call() {
    return _repository.watchAll();
  }
}
