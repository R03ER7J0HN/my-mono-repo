import 'package:budget_core/budget_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'installments_state.freezed.dart';

@freezed
sealed class InstallmentsState with _$InstallmentsState {
  const factory InstallmentsState({
    @Default([]) List<InstallmentEntity> installments,
    @Default([]) List<AccountEntity> accounts,
    @Default(true) bool isLoading,
    String? error,
    String? filterAccountId,
  }) = _InstallmentsState;

  const InstallmentsState._();

  List<InstallmentEntity> get filteredInstallments {
    if (filterAccountId == null) return installments;
    return installments.where((i) => i.accountId == filterAccountId).toList();
  }

  List<InstallmentEntity> get activeInstallments =>
      filteredInstallments.where((i) => !i.isFullyPaid).toList();

  List<InstallmentEntity> get completedInstallments =>
      filteredInstallments.where((i) => i.isFullyPaid).toList();

  double get totalMonthlyPayment =>
      activeInstallments.fold(0, (sum, i) => sum + i.monthlyAmount);

  double get totalRemainingAmount =>
      activeInstallments.fold(0, (sum, i) => sum + i.remainingAmount);

  List<AccountEntity> get creditCardAccounts =>
      accounts.where((a) => a.type == AccountType.creditCard).toList();
}
