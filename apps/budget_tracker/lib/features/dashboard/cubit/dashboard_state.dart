import 'package:budget_core/budget_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(true) bool isLoading,
    @Default([]) List<AccountEntity> accounts,
    @Default([]) List<TransactionEntity> recentTransactions,
    @Default([]) List<TransactionEntity> monthlyTransactions,
    @Default([]) List<CategoryEntity> categories,
    @Default([]) List<InstallmentEntity> activeInstallments,
    @Default(BudgetSummary()) BudgetSummary summary,
    String? errorMessage,
  }) = _DashboardState;
}
