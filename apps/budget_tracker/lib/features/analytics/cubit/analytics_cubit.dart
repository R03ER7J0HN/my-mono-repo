import 'dart:async';

import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/analytics/cubit/analytics_state.dart';
import 'package:flutter_core/flutter_core.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> with SafeEmitMixin {
  AnalyticsCubit({
    required TransactionRepository transactionRepository,
    required AccountRepository accountRepository,
    required CategoryRepository categoryRepository,
  }) : _transactionRepository = transactionRepository,
       _accountRepository = accountRepository,
       _categoryRepository = categoryRepository,
       super(const AnalyticsState()) {
    _init();
  }

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

  void setViewMode(AnalyticsViewMode mode) {
    safeEmit(state.copyWith(viewMode: mode));
  }

  void setAccountTypeFilter(AccountType? accountType) {
    safeEmit(state.copyWith(selectedAccountType: accountType));
  }

  void selectDate(DateTime date) {
    safeEmit(state.copyWith(selectedDate: date));
  }

  void goToPreviousPeriod() {
    final current = state.displayDate;
    DateTime newDate;
    switch (state.viewMode) {
      case AnalyticsViewMode.daily:
        newDate = current.subtract(const Duration(days: 1));
      case AnalyticsViewMode.monthly:
        newDate = DateTime(current.year, current.month - 1, current.day);
      case AnalyticsViewMode.yearly:
        newDate = DateTime(current.year - 1, current.month, current.day);
    }
    safeEmit(state.copyWith(selectedDate: newDate));
  }

  void goToNextPeriod() {
    final current = state.displayDate;
    DateTime newDate;
    switch (state.viewMode) {
      case AnalyticsViewMode.daily:
        newDate = current.add(const Duration(days: 1));
      case AnalyticsViewMode.monthly:
        newDate = DateTime(current.year, current.month + 1, current.day);
      case AnalyticsViewMode.yearly:
        newDate = DateTime(current.year + 1, current.month, current.day);
    }
    safeEmit(state.copyWith(selectedDate: newDate));
  }

  void goToCurrentPeriod() {
    safeEmit(state.copyWith(selectedDate: DateTime.now()));
  }

  @override
  Future<void> close() async {
    await _transactionSubscription?.cancel();
    await _accountSubscription?.cancel();
    await _categorySubscription?.cancel();
    return super.close();
  }
}
