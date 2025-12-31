import 'package:budget_core/budget_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'installment_entry_state.freezed.dart';

@freezed
sealed class InstallmentEntryState with _$InstallmentEntryState {
  const factory InstallmentEntryState({
    @Default('') String description,
    @Default(0) double totalAmount,
    @Default(12) int totalInstallments,
    @Default(0) int paidInstallments,
    @Default(InstallmentFrequency.monthly) InstallmentFrequency frequency,
    DateTime? startDate,
    String? accountId,
    @Default([]) List<AccountEntity> creditCardAccounts,
    @Default(false) bool isSaving,
    @Default(false) bool isValid,
    String? error,
    InstallmentEntity? existingInstallment,
  }) = _InstallmentEntryState;

  const InstallmentEntryState._();

  bool get isEditing => existingInstallment != null;

  DateTime get installmentStartDate => startDate ?? DateTime.now();

  double get monthlyAmount {
    if (totalInstallments <= 0) return 0;
    return totalAmount / totalInstallments;
  }

  DateTime get endDate {
    switch (frequency) {
      case InstallmentFrequency.monthly:
        return DateTime(
          installmentStartDate.year,
          installmentStartDate.month + totalInstallments,
          installmentStartDate.day,
        );
      case InstallmentFrequency.quarterly:
        return DateTime(
          installmentStartDate.year,
          installmentStartDate.month + (totalInstallments * 3),
          installmentStartDate.day,
        );
      case InstallmentFrequency.yearly:
        return DateTime(
          installmentStartDate.year + totalInstallments,
          installmentStartDate.month,
          installmentStartDate.day,
        );
    }
  }

  double get remainingAmount {
    final remaining = totalInstallments - paidInstallments;
    if (remaining <= 0) return 0;
    return monthlyAmount * remaining;
  }
}
