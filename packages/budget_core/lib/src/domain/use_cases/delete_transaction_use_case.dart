import 'package:budget_core/src/domain/entities/transaction_entity.dart';
import 'package:budget_core/src/domain/enums/transaction_type.dart';
import 'package:budget_core/src/domain/repositories/account_repository.dart';
import 'package:budget_core/src/domain/repositories/transaction_repository.dart';
import 'package:flutter_core/flutter_core.dart';

/// Use case for deleting a transaction and reversing its effect on balances.
class DeleteTransactionUseCase {
  DeleteTransactionUseCase({
    required TransactionRepository transactionRepository,
    required AccountRepository accountRepository,
  }) : _transactionRepository = transactionRepository,
       _accountRepository = accountRepository;

  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;

  /// Execute the use case to delete a transaction and reverse balance effects.
  FutureResult<void> call(String transactionId) async {
    final result = await _transactionRepository.getById(transactionId);

    return result.fold(
      onFailure: Result.failure,
      onSuccess: (transaction) async {
        final reverseResult = await _reverseTransactionEffect(transaction);
        if (reverseResult.isFailure) {
          return reverseResult;
        }

        return _transactionRepository.delete(transactionId);
      },
    );
  }

  Future<Result<void>> _reverseTransactionEffect(
    TransactionEntity transaction,
  ) async {
    final accountResult = await _accountRepository.getById(
      transaction.accountId,
    );

    return accountResult.fold(
      onFailure: Result.failure,
      onSuccess: (account) async {
        double newBalance;

        switch (transaction.type) {
          case TransactionType.income:
            newBalance = account.balance - transaction.amount;
          case TransactionType.expense:
            newBalance = account.balance + transaction.amount;
          case TransactionType.transfer:
            newBalance = account.balance + transaction.amount;

            if (transaction.toAccountId != null) {
              final toAccountResult = await _accountRepository.getById(
                transaction.toAccountId!,
              );
              final toAccount = toAccountResult.fold(
                onFailure: (_) => null,
                onSuccess: (a) => a,
              );
              if (toAccount != null) {
                await _accountRepository.updateBalance(
                  transaction.toAccountId!,
                  toAccount.balance - transaction.amount,
                );
              }
            }
        }

        return _accountRepository.updateBalance(
          transaction.accountId,
          newBalance,
        );
      },
    );
  }
}
