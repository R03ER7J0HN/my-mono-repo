import 'package:budget_core/budget_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_state.freezed.dart';

/// View mode for analytics period
enum AnalyticsViewMode {
  daily,
  monthly,
  yearly;

  String get label {
    switch (this) {
      case AnalyticsViewMode.daily:
        return 'Daily';
      case AnalyticsViewMode.monthly:
        return 'Monthly';
      case AnalyticsViewMode.yearly:
        return 'Yearly';
    }
  }
}

@freezed
sealed class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState({
    @Default([]) List<TransactionEntity> transactions,
    @Default([]) List<AccountEntity> accounts,
    @Default([]) List<CategoryEntity> categories,
    @Default(true) bool isLoading,
    @Default(AnalyticsViewMode.monthly) AnalyticsViewMode viewMode,

    /// Selected account type filter. If null, shows all account types.
    AccountType? selectedAccountType,
    DateTime? selectedDate,
    String? error,
  }) = _AnalyticsState;

  const AnalyticsState._();

  DateTime get displayDate => selectedDate ?? DateTime.now();

  List<TransactionEntity> get filteredTransactions {
    return transactions.where((t) {
      // Filter by account type if selected
      if (selectedAccountType != null) {
        final account = accounts.where((a) => a.id == t.accountId).firstOrNull;
        if (account == null || account.type != selectedAccountType) {
          return false;
        }
      }

      // Filter by date based on view mode
      switch (viewMode) {
        case AnalyticsViewMode.daily:
          return t.date.year == displayDate.year &&
              t.date.month == displayDate.month &&
              t.date.day == displayDate.day;
        case AnalyticsViewMode.monthly:
          return t.date.year == displayDate.year &&
              t.date.month == displayDate.month;
        case AnalyticsViewMode.yearly:
          return t.date.year == displayDate.year;
      }
    }).toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  double get periodIncome => filteredTransactions
      .where((t) => t.type == TransactionType.income)
      .fold(0, (sum, t) => sum + t.amount);

  double get periodExpenses => filteredTransactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0, (sum, t) => sum + t.amount);

  double get periodNet => periodIncome - periodExpenses;

  String get periodLabel {
    switch (viewMode) {
      case AnalyticsViewMode.daily:
        return 'Today';
      case AnalyticsViewMode.monthly:
        return 'This Month';
      case AnalyticsViewMode.yearly:
        return 'This Year';
    }
  }
}
