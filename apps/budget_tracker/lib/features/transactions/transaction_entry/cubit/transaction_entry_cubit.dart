import 'dart:async';

import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/transactions/transaction_entry/cubit/transaction_entry_state.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:uuid/uuid.dart';

class TransactionEntryCubit extends Cubit<TransactionEntryState>
    with SafeEmitMixin {
  TransactionEntryCubit({
    required SaveTransactionUseCase saveTransactionUseCase,
    required AccountRepository accountRepository,
    required CategoryRepository categoryRepository,
    TransactionEntity? existingTransaction,
  }) : _saveTransactionUseCase = saveTransactionUseCase,
       _accountRepository = accountRepository,
       _categoryRepository = categoryRepository,
       super(
         existingTransaction != null
             ? TransactionEntryState(
                 type: existingTransaction.type,
                 amount: existingTransaction.amount,
                 description: existingTransaction.description,
                 categoryId: existingTransaction.categoryId,
                 accountId: existingTransaction.accountId,
                 toAccountId: existingTransaction.toAccountId,
                 date: existingTransaction.date,
                 isValid: true,
                 existingTransaction: existingTransaction,
               )
             : const TransactionEntryState(),
       ) {
    _init();
  }

  final SaveTransactionUseCase _saveTransactionUseCase;
  final AccountRepository _accountRepository;
  final CategoryRepository _categoryRepository;
  StreamSubscription<List<AccountEntity>>? _accountSubscription;
  StreamSubscription<List<CategoryEntity>>? _categorySubscription;

  void _init() {
    _accountSubscription = _accountRepository.watchAll().listen(
      (accounts) {
        safeEmit(
          state.copyWith(
            accounts: accounts,
            accountId: state.accountId ?? accounts.firstOrNull?.id,
          ),
        );
      },
    );

    _categorySubscription = _categoryRepository.watchAll().listen(
      (categories) {
        safeEmit(state.copyWith(categories: categories));
      },
    );
  }

  void setType(TransactionType type) {
    safeEmit(
      state.copyWith(
        type: type,
        toAccountId: type == TransactionType.transfer
            ? state.toAccountId
            : null,
      ),
    );
  }

  void setAmount(double amount) {
    safeEmit(
      state.copyWith(
        amount: amount,
        isValid: _validate(amount: amount),
      ),
    );
  }

  void setDescription(String description) {
    safeEmit(
      state.copyWith(
        description: description,
        isValid: _validate(description: description),
      ),
    );
  }

  void setCategoryId(String? categoryId) {
    safeEmit(state.copyWith(categoryId: categoryId));
  }

  void setAccountId(String? accountId) {
    safeEmit(
      state.copyWith(
        accountId: accountId,
        isValid: _validate(accountId: accountId),
      ),
    );
  }

  void setToAccountId(String? toAccountId) {
    safeEmit(
      state.copyWith(
        toAccountId: toAccountId,
        isValid: _validate(toAccountId: toAccountId),
      ),
    );
  }

  void setDate(DateTime date) {
    safeEmit(state.copyWith(date: date));
  }

  bool _validate({
    double? amount,
    String? description,
    String? accountId,
    String? toAccountId,
  }) {
    final amt = amount ?? state.amount;
    final desc = description ?? state.description;
    final accId = accountId ?? state.accountId;
    final toAccId = toAccountId ?? state.toAccountId;

    if (amt <= 0) return false;
    if (desc.trim().isEmpty) return false;
    if (accId == null) return false;
    if (state.type == TransactionType.transfer && toAccId == null) return false;
    if (state.type == TransactionType.transfer && accId == toAccId) {
      return false;
    }

    return true;
  }

  Future<bool> save() async {
    if (!state.isValid) return false;

    safeEmit(state.copyWith(isSaving: true, error: null));

    final transaction = TransactionEntity(
      id: state.existingTransaction?.id ?? const Uuid().v4(),
      accountId: state.accountId!,
      toAccountId: state.isTransfer ? state.toAccountId : null,
      type: state.type,
      amount: state.amount,
      description: state.description.trim(),
      categoryId: state.categoryId,
      date: state.transactionDate,
      createdAt: state.existingTransaction?.createdAt ?? DateTime.now(),
    );

    final result = await _saveTransactionUseCase(transaction);

    return result.fold(
      onFailure: (failure) {
        safeEmit(
          state.copyWith(
            isSaving: false,
            error: failure.message,
          ),
        );
        return false;
      },
      onSuccess: (_) {
        safeEmit(state.copyWith(isSaving: false));
        return true;
      },
    );
  }

  @override
  Future<void> close() async {
    await _accountSubscription?.cancel();
    await _categorySubscription?.cancel();
    return super.close();
  }
}
