import 'package:budget_core/budget_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'monthly_budget_state.freezed.dart';

@freezed
sealed class MonthlyBudgetState with _$MonthlyBudgetState {
  const factory MonthlyBudgetState({
    MonthlyBudgetEntity? currentBudget,
    @Default([]) List<MonthlyBudgetEntity> budgetHistory,
    @Default([]) List<TransactionEntity> monthlyTransactions,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    String? error,
  }) = _MonthlyBudgetState;

  const MonthlyBudgetState._();

  /// Today's date
  DateTime get today => DateTime.now();

  /// Current month's total expenses
  double get totalExpenses {
    return monthlyTransactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0, (sum, t) => sum + t.amount);
  }

  /// Current month's total income
  double get totalIncome {
    return monthlyTransactions
        .where((t) => t.type == TransactionType.income)
        .fold(0, (sum, t) => sum + t.amount);
  }

  /// Today's expenses
  double get todayExpenses {
    return monthlyTransactions
        .where(
          (t) =>
              t.type == TransactionType.expense &&
              t.date.year == today.year &&
              t.date.month == today.month &&
              t.date.day == today.day,
        )
        .fold(0, (sum, t) => sum + t.amount);
  }

  /// Remaining budget for the month
  double get remainingBudget {
    if (currentBudget == null) return 0;
    return currentBudget!.totalBudget - totalExpenses;
  }

  /// Suggested daily budget based on remaining days
  double get suggestedDailyBudget {
    if (currentBudget == null) return 0;
    final daysInMonth = DateTime(today.year, today.month + 1, 0).day;
    final remainingDays = daysInMonth - today.day + 1;
    if (remainingDays <= 0) return 0;
    return remainingBudget / remainingDays;
  }

  /// Today's remaining budget
  double get todayRemainingBudget {
    final daily = currentBudget?.dailyBudget ?? suggestedDailyBudget;
    return daily - todayExpenses;
  }

  /// Budget spent percentage (0-100)
  double get spentPercentage {
    if (currentBudget == null || currentBudget!.totalBudget <= 0) return 0;
    return (totalExpenses / currentBudget!.totalBudget * 100).clamp(0, 999);
  }

  /// Whether the user is over budget for the month
  bool get isOverBudget => remainingBudget < 0;

  /// Whether the user is over daily budget
  bool get isOverDailyBudget => todayRemainingBudget < 0;
}
