import 'package:budget_core/budget_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_entry_state.freezed.dart';

@freezed
sealed class AccountEntryState with _$AccountEntryState {
  const factory AccountEntryState({
    @Default('') String name,
    @Default(AccountType.cash) AccountType type,
    @Default(0) double balance,
    double? creditLimit,
    double? budgetLimit,
    @Default(false) bool isSaving,
    @Default(false) bool isValid,
    String? error,
    AccountEntity? existingAccount,
  }) = _AccountEntryState;

  const AccountEntryState._();

  bool get isEditing => existingAccount != null;
}
