import 'dart:async';

import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/dashboard/cubit/dashboard_state.dart';
import 'package:flutter_core/flutter_core.dart';

class DashboardCubit extends Cubit<DashboardState>
    with SafeEmitMixin<DashboardState> {
  DashboardCubit({
    required AccountRepository accountRepository,
    required TransactionRepository transactionRepository,
    required InstallmentRepository installmentRepository,
    required CategoryRepository categoryRepository,
  }) : _accountRepository = accountRepository,
       _transactionRepository = transactionRepository,
       _installmentRepository = installmentRepository,
       _categoryRepository = categoryRepository,
       super(const DashboardState());

  final AccountRepository _accountRepository;
  final TransactionRepository _transactionRepository;
  final InstallmentRepository _installmentRepository;
  final CategoryRepository _categoryRepository;

  StreamSubscription<List<AccountEntity>>? _accountsSubscription;
  StreamSubscription<List<TransactionEntity>>? _transactionsSubscription;
  StreamSubscription<List<InstallmentEntity>>? _installmentsSubscription;
  StreamSubscription<List<CategoryEntity>>? _categoriesSubscription;

  Future<void> init() async {
    safeEmit(state.copyWith(isLoading: true));

    _accountsSubscription = _accountRepository.watchAll().listen(
      (List<AccountEntity> accounts) {
        _updateState(accounts: accounts);
      },
      onError: (Object error) {
        safeEmit(
          state.copyWith(
            isLoading: false,
            errorMessage: error.toString(),
          ),
        );
      },
    );

    _transactionsSubscription = _transactionRepository.watchAll().listen(
      (List<TransactionEntity> transactions) {
        final recent = transactions.take(5).toList();
        // Get monthly transactions for pie chart
        final now = DateTime.now();
        final startOfMonth = DateTime(now.year, now.month);
        final monthly = transactions.where((t) {
          return t.date.isAfter(
            startOfMonth.subtract(const Duration(seconds: 1)),
          );
        }).toList();
        _updateState(recentTransactions: recent, monthlyTransactions: monthly);
      },
    );

    _installmentsSubscription = _installmentRepository.watchAll().listen(
      (List<InstallmentEntity> installments) {
        final active = installments.where((i) => !i.isFullyPaid).toList();
        _updateState(activeInstallments: active);
      },
    );

    _categoriesSubscription = _categoryRepository.watchAll().listen(
      (List<CategoryEntity> categories) {
        _updateState(categories: categories);
      },
    );
  }

  void _updateState({
    List<AccountEntity>? accounts,
    List<TransactionEntity>? recentTransactions,
    List<TransactionEntity>? monthlyTransactions,
    List<CategoryEntity>? categories,
    List<InstallmentEntity>? activeInstallments,
  }) {
    final updatedAccounts = accounts ?? state.accounts;
    final updatedRecent = recentTransactions ?? state.recentTransactions;
    final updatedMonthly = monthlyTransactions ?? state.monthlyTransactions;
    final updatedCategories = categories ?? state.categories;
    final updatedInstallments = activeInstallments ?? state.activeInstallments;

    final summary = _calculateSummary(
      updatedAccounts,
      updatedMonthly,
      updatedInstallments,
    );

    safeEmit(
      state.copyWith(
        isLoading: false,
        accounts: updatedAccounts,
        recentTransactions: updatedRecent,
        monthlyTransactions: updatedMonthly,
        categories: updatedCategories,
        activeInstallments: updatedInstallments,
        summary: summary,
      ),
    );
  }

  BudgetSummary _calculateSummary(
    List<AccountEntity> accounts,
    List<TransactionEntity> monthlyTransactions,
    List<InstallmentEntity> installments,
  ) {
    var totalBalance = 0.0;
    var totalDebt = 0.0;
    var totalAvailableCredit = 0.0;
    var accountsOverThreshold = 0;
    var creditCardsOverThreshold = 0;

    for (final account in accounts) {
      if (account.type == AccountType.creditCard) {
        totalDebt += account.totalDebt;
        totalAvailableCredit += account.availableCredit;
        if (account.isCreditOverThreshold) {
          creditCardsOverThreshold++;
        }
      } else {
        totalBalance += account.balance;
        if (account.isOverThreshold) {
          accountsOverThreshold++;
        }
      }
    }

    // Calculate monthly totals from already-filtered transactions
    var monthlyIncome = 0.0;
    var monthlyExpenses = 0.0;

    for (final transaction in monthlyTransactions) {
      if (transaction.type == TransactionType.income) {
        monthlyIncome += transaction.amount;
      } else if (transaction.type == TransactionType.expense) {
        monthlyExpenses += transaction.amount;
      }
    }

    // Calculate monthly installments
    var monthlyInstallments = 0.0;
    for (final installment in installments) {
      monthlyInstallments += installment.monthlyAmount;
    }

    return BudgetSummary(
      totalBalance: totalBalance,
      totalDebt: totalDebt,
      totalAvailableCredit: totalAvailableCredit,
      monthlyIncome: monthlyIncome,
      monthlyExpenses: monthlyExpenses,
      monthlySavings: monthlyIncome - monthlyExpenses,
      monthlyInstallments: monthlyInstallments,
      accountsOverThreshold: accountsOverThreshold,
      creditCardsOverThreshold: creditCardsOverThreshold,
    );
  }

  @override
  Future<void> close() async {
    await _accountsSubscription?.cancel();
    await _transactionsSubscription?.cancel();
    await _installmentsSubscription?.cancel();
    await _categoriesSubscription?.cancel();
    return super.close();
  }
}
