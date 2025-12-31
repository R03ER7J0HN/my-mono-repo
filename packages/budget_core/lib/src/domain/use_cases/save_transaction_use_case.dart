import 'package:budget_core/src/domain/entities/transaction_entity.dart';
import 'package:budget_core/src/domain/enums/transaction_type.dart';
import 'package:budget_core/src/domain/repositories/account_repository.dart';
import 'package:budget_core/src/domain/repositories/transaction_repository.dart';
import 'package:flutter_core/flutter_core.dart';

/// Use case for saving a transaction with proper account balance updates.
///
/// For new transactions:
/// - Income: adds to account balance
/// - Expense: deducts from account balance
/// - Transfer: deducts from source, adds to destination
///
/// For updates: reverses old transaction effect, applies new effect.
class SaveTransactionUseCase {
  SaveTransactionUseCase({
    required TransactionRepository transactionRepository,
    required AccountRepository accountRepository,
  }) : _transactionRepository = transactionRepository,
       _accountRepository = accountRepository;

  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;

  /// Execute the use case to save a transaction and update balances.
  FutureResult<void> call(TransactionEntity transaction) async {
    // Check if this is an update (existing transaction)
    final existingResult = await _transactionRepository.getById(transaction.id);
    final existingTransaction = existingResult.fold(
      onFailure: (_) => null,
      onSuccess: (t) => t,
    );

    // If updating, first reverse the old transaction's effect
    if (existingTransaction != null) {
      final reverseResult = await _reverseTransactionEffect(
        existingTransaction,
      );
      if (reverseResult.isFailure) {
        return reverseResult;
      }
    }

    // Apply the new transaction's effect on account balances
    final applyResult = await _applyTransactionEffect(transaction);
    if (applyResult.isFailure) {
      // If apply failed and we reversed an existing transaction,
      // try to re-apply it
      if (existingTransaction != null) {
        await _applyTransactionEffect(existingTransaction);
      }
      return applyResult;
    }

    // Save the transaction
    return _transactionRepository.save(transaction);
  }

  Future<Result<void>> _applyTransactionEffect(
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
            newBalance = account.balance + transaction.amount;
          case TransactionType.expense:
            newBalance = account.balance - transaction.amount;
          case TransactionType.transfer:
            newBalance = account.balance - transaction.amount;

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
                  toAccount.balance + transaction.amount,
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
