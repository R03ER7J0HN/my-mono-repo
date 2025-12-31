import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_summary.freezed.dart';

/// Aggregated budget summary for dashboard
@freezed
sealed class BudgetSummary with _$BudgetSummary {
  const factory BudgetSummary({
    /// Total balance across all accounts (excluding credit cards)
    @Default(0) double totalBalance,

    /// Total credit card debt
    @Default(0) double totalDebt,

    /// Total available credit
    @Default(0) double totalAvailableCredit,

    /// Total income this month
    @Default(0) double monthlyIncome,

    /// Total expenses this month
    @Default(0) double monthlyExpenses,

    /// Net savings this month (income - expenses)
    @Default(0) double monthlySavings,

    /// Total monthly installment payments
    @Default(0) double monthlyInstallments,

    /// Number of accounts over budget threshold
    @Default(0) int accountsOverThreshold,

    /// Number of credit cards over threshold
    @Default(0) int creditCardsOverThreshold,
  }) = _BudgetSummary;

  const BudgetSummary._();

  /// Net worth (total balance - total debt)
  double get netWorth => totalBalance - totalDebt;

  /// Whether any account is over threshold
  bool get hasWarnings =>
      accountsOverThreshold > 0 || creditCardsOverThreshold > 0;

  /// Total warnings count
  int get totalWarnings => accountsOverThreshold + creditCardsOverThreshold;
}
