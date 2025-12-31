import 'package:freezed_annotation/freezed_annotation.dart';

part 'monthly_budget_entity.freezed.dart';

/// Represents a monthly budget allocation
@freezed
sealed class MonthlyBudgetEntity with _$MonthlyBudgetEntity {
  const factory MonthlyBudgetEntity({
    required String id,

    /// Year for this budget (e.g., 2025)
    required int year,

    /// Month for this budget (1-12)
    required int month,

    /// Total budget amount for the month
    required double totalBudget,

    /// Amount spent so far this month
    @Default(0) double spentAmount,

    /// Daily budget allocation (totalBudget / days in month)
    double? dailyBudget,

    /// Optional notes about this budget
    String? notes,

    /// Creation timestamp
    DateTime? createdAt,

    /// Last updated timestamp
    DateTime? updatedAt,
  }) = _MonthlyBudgetEntity;

  const MonthlyBudgetEntity._();

  /// Remaining budget for the month
  double get remainingBudget => totalBudget - spentAmount;

  /// Percentage of budget spent (0-1)
  double get spentPercentage {
    if (totalBudget <= 0) return 0;
    return (spentAmount / totalBudget).clamp(0, 1);
  }

  /// Whether budget is exceeded
  bool get isExceeded => spentAmount > totalBudget;

  /// Get the start date of this budget month
  DateTime get startDate => DateTime(year, month);

  /// Get the end date of this budget month
  DateTime get endDate => DateTime(year, month + 1, 0);

  /// Number of days in this month
  int get daysInMonth => endDate.day;

  /// Calculated daily budget based on total and days
  double get calculatedDailyBudget {
    if (dailyBudget != null) return dailyBudget!;
    return totalBudget / daysInMonth;
  }

  /// Days remaining in the month
  int get daysRemaining {
    final now = DateTime.now();
    if (now.year != year || now.month != month) {
      return now.isBefore(startDate) ? daysInMonth : 0;
    }
    return daysInMonth - now.day + 1;
  }

  /// Remaining daily budget (remaining / days left)
  double get remainingDailyBudget {
    if (daysRemaining <= 0) return 0;
    return remainingBudget / daysRemaining;
  }
}
