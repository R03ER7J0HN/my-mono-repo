import 'package:budget_core/budget_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transactions_state.freezed.dart';

/// View mode for transactions list
enum TransactionViewMode {
  daily,
  monthly,
  yearly;

  String get label {
    switch (this) {
      case TransactionViewMode.daily:
        return 'Daily';
      case TransactionViewMode.monthly:
        return 'Monthly';
      case TransactionViewMode.yearly:
        return 'Yearly';
    }
  }
}

@freezed
sealed class TransactionsState with _$TransactionsState {
  const factory TransactionsState({
    @Default([]) List<TransactionEntity> transactions,
    @Default([]) List<AccountEntity> accounts,
    @Default([]) List<CategoryEntity> categories,
    @Default(true) bool isLoading,
    @Default(TransactionViewMode.daily) TransactionViewMode viewMode,

    /// Selected account type filter. If null, shows all account types.
    AccountType? selectedAccountType,
    String? error,
    DateTime? selectedDate,
  }) = _TransactionsState;

  const TransactionsState._();

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
        case TransactionViewMode.daily:
          return t.date.year == displayDate.year &&
              t.date.month == displayDate.month &&
              t.date.day == displayDate.day;
        case TransactionViewMode.monthly:
          return t.date.year == displayDate.year &&
              t.date.month == displayDate.month;
        case TransactionViewMode.yearly:
          return t.date.year == displayDate.year;
      }
    }).toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  CategoryEntity? getCategoryForTransaction(TransactionEntity transaction) {
    if (transaction.categoryId == null) return null;
    return categories.where((c) => c.id == transaction.categoryId).firstOrNull;
  }

  double get periodIncome => filteredTransactions
      .where((t) => t.type == TransactionType.income)
      .fold(0, (sum, t) => sum + t.amount);

  double get periodExpenses => filteredTransactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0, (sum, t) => sum + t.amount);

  double get periodNet => periodIncome - periodExpenses;

  Map<DateTime, List<TransactionEntity>> get transactionsByDate {
    final map = <DateTime, List<TransactionEntity>>{};
    for (final transaction in transactions) {
      final date = DateTime(
        transaction.date.year,
        transaction.date.month,
        transaction.date.day,
      );
      map.putIfAbsent(date, () => []).add(transaction);
    }
    return map;
  }
}
