import 'dart:async';

import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/transactions/cubit/transactions_state.dart';
import 'package:flutter_core/flutter_core.dart';

class TransactionsCubit extends Cubit<TransactionsState> with SafeEmitMixin {
  TransactionsCubit({
    required DeleteTransactionUseCase deleteTransactionUseCase,
    required TransactionRepository transactionRepository,
    required AccountRepository accountRepository,
    required CategoryRepository categoryRepository,
  }) : _deleteTransactionUseCase = deleteTransactionUseCase,
       _transactionRepository = transactionRepository,
       _accountRepository = accountRepository,
       _categoryRepository = categoryRepository,
       super(const TransactionsState()) {
    _init();
  }

  final DeleteTransactionUseCase _deleteTransactionUseCase;
  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;
  final CategoryRepository _categoryRepository;
  StreamSubscription<List<TransactionEntity>>? _transactionSubscription;
  StreamSubscription<List<AccountEntity>>? _accountSubscription;
  StreamSubscription<List<CategoryEntity>>? _categorySubscription;

  void _init() {
    _transactionSubscription = _transactionRepository.watchAll().listen(
      (transactions) {
        safeEmit(
          state.copyWith(
            transactions: transactions,
            isLoading: false,
          ),
        );
      },
      onError: (Object error) {
        safeEmit(
          state.copyWith(
            error: error.toString(),
            isLoading: false,
          ),
        );
      },
    );

    _accountSubscription = _accountRepository.watchAll().listen(
      (accounts) {
        safeEmit(state.copyWith(accounts: accounts));
      },
    );

    _categorySubscription = _categoryRepository.watchAll().listen(
      (categories) {
        safeEmit(state.copyWith(categories: categories));
      },
    );
  }

  void selectDate(DateTime date) {
    safeEmit(state.copyWith(selectedDate: date));
  }

  void setViewMode(TransactionViewMode mode) {
    safeEmit(state.copyWith(viewMode: mode));
  }

  void setAccountTypeFilter(AccountType? accountType) {
    safeEmit(state.copyWith(selectedAccountType: accountType));
  }

  void goToPreviousPeriod() {
    final current = state.displayDate;
    DateTime newDate;
    switch (state.viewMode) {
      case TransactionViewMode.daily:
        newDate = current.subtract(const Duration(days: 1));
      case TransactionViewMode.monthly:
        newDate = DateTime(current.year, current.month - 1, current.day);
      case TransactionViewMode.yearly:
        newDate = DateTime(current.year - 1, current.month, current.day);
    }
    safeEmit(state.copyWith(selectedDate: newDate));
  }

  void goToNextPeriod() {
    final current = state.displayDate;
    DateTime newDate;
    switch (state.viewMode) {
      case TransactionViewMode.daily:
        newDate = current.add(const Duration(days: 1));
      case TransactionViewMode.monthly:
        newDate = DateTime(current.year, current.month + 1, current.day);
      case TransactionViewMode.yearly:
        newDate = DateTime(current.year + 1, current.month, current.day);
    }
    safeEmit(state.copyWith(selectedDate: newDate));
  }

  void goToPreviousDay() {
    final newDate = state.displayDate.subtract(const Duration(days: 1));
    safeEmit(state.copyWith(selectedDate: newDate));
  }

  void goToNextDay() {
    final newDate = state.displayDate.add(const Duration(days: 1));
    safeEmit(state.copyWith(selectedDate: newDate));
  }

  void goToToday() {
    safeEmit(state.copyWith(selectedDate: DateTime.now()));
  }

  Future<void> deleteTransaction(String id) async {
    final result = await _deleteTransactionUseCase(id);
    result.fold(
      onFailure: (failure) {
        safeEmit(state.copyWith(error: failure.message));
      },
      onSuccess: (_) {},
    );
  }

  @override
  Future<void> close() async {
    await _transactionSubscription?.cancel();
    await _accountSubscription?.cancel();
    await _categorySubscription?.cancel();
    return super.close();
  }
}
