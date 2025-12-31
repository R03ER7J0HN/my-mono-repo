import 'package:budget_core/budget_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'accounts_state.freezed.dart';

@freezed
sealed class AccountsState with _$AccountsState {
  const factory AccountsState({
    @Default([]) List<AccountEntity> accounts,
    @Default([]) List<TransactionEntity> transactions,
    @Default(true) bool isLoading,
    String? error,
    AccountType? filterType,
  }) = _AccountsState;

  const AccountsState._();

  List<AccountEntity> get filteredAccounts {
    if (filterType == null) return accounts;
    return accounts.where((a) => a.type == filterType).toList();
  }

  /// Get monthly spending (expenses) for a specific account
  double getMonthlySpendingForAccount(String accountId) {
    final now = DateTime.now();
    return transactions
        .where(
          (t) =>
              t.accountId == accountId &&
              t.type == TransactionType.expense &&
              t.date.year == now.year &&
              t.date.month == now.month,
        )
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalBalance => accounts.fold(0, (sum, a) => sum + a.balance);

  double get totalDebt => accounts
      .where((a) => a.type == AccountType.creditCard)
      .fold(
        0,
        (sum, a) => sum + a.balance.abs(),
      );

  Map<AccountType, List<AccountEntity>> get accountsByType {
    final map = <AccountType, List<AccountEntity>>{};
    for (final account in accounts) {
      map.putIfAbsent(account.type, () => []).add(account);
    }
    return map;
  }
}
