import 'dart:async';

import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/monthly_budget/cubit/monthly_budget_state.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:uuid/uuid.dart';

class MonthlyBudgetCubit extends Cubit<MonthlyBudgetState> with SafeEmitMixin {
  MonthlyBudgetCubit({
    required MonthlyBudgetRepository monthlyBudgetRepository,
    required TransactionRepository transactionRepository,
  }) : _monthlyBudgetRepository = monthlyBudgetRepository,
       _transactionRepository = transactionRepository,
       super(const MonthlyBudgetState()) {
    _init();
  }

  final MonthlyBudgetRepository _monthlyBudgetRepository;
  final TransactionRepository _transactionRepository;
  StreamSubscription<MonthlyBudgetEntity?>? _budgetSubscription;
  StreamSubscription<List<TransactionEntity>>? _transactionSubscription;

  void _init() {
    safeEmit(state.copyWith(isLoading: true));

    _budgetSubscription = _monthlyBudgetRepository.watchCurrentMonth().listen(
      (budget) {
        safeEmit(
          state.copyWith(
            currentBudget: budget,
            isLoading: false,
          ),
        );
      },
      onError: (Object error) {
        safeEmit(
          state.copyWith(
            isLoading: false,
            error: error.toString(),
          ),
        );
      },
    );

    _transactionSubscription = _transactionRepository.watchAll().listen(
      (transactions) {
        // Filter to current month only
        final now = DateTime.now();
        final monthlyTransactions = transactions.where((t) {
          return t.date.year == now.year && t.date.month == now.month;
        }).toList();
        safeEmit(state.copyWith(monthlyTransactions: monthlyTransactions));
      },
    );

    unawaited(_loadBudgetHistory());
  }

  Future<void> _loadBudgetHistory() async {
    final result = await _monthlyBudgetRepository.getAll();
    result.fold(
      onFailure: (failure) {
        safeEmit(state.copyWith(error: failure.message));
      },
      onSuccess: (budgets) {
        safeEmit(state.copyWith(budgetHistory: budgets));
      },
    );
  }

  Future<bool> setMonthlyBudget({
    required double totalBudget,
    double? dailyBudget,
    String? notes,
  }) async {
    safeEmit(state.copyWith(isSaving: true, error: null));

    final now = DateTime.now();
    final existingId = state.currentBudget?.id;

    final budget = MonthlyBudgetEntity(
      id: existingId ?? const Uuid().v4(),
      year: now.year,
      month: now.month,
      totalBudget: totalBudget,
      spentAmount: state.currentBudget?.spentAmount ?? 0,
      dailyBudget: dailyBudget,
      notes: notes,
      createdAt: state.currentBudget?.createdAt ?? now,
      updatedAt: now,
    );

    final result = await _monthlyBudgetRepository.save(budget);

    return result.fold(
      onFailure: (failure) {
        safeEmit(state.copyWith(isSaving: false, error: failure.message));
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
    await _budgetSubscription?.cancel();
    await _transactionSubscription?.cancel();
    return super.close();
  }
}
