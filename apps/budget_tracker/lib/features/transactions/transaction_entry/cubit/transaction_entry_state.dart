import 'package:budget_core/budget_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_entry_state.freezed.dart';

@freezed
sealed class TransactionEntryState with _$TransactionEntryState {
  const factory TransactionEntryState({
    @Default(TransactionType.expense) TransactionType type,
    @Default(0) double amount,
    @Default('') String description,
    String? categoryId,
    String? accountId,
    String? toAccountId,
    DateTime? date,
    @Default([]) List<AccountEntity> accounts,
    @Default([]) List<CategoryEntity> categories,
    @Default(false) bool isSaving,
    @Default(false) bool isValid,
    String? error,
    TransactionEntity? existingTransaction,
  }) = _TransactionEntryState;

  const TransactionEntryState._();

  bool get isEditing => existingTransaction != null;

  bool get isTransfer => type == TransactionType.transfer;

  DateTime get transactionDate => date ?? DateTime.now();

  AccountEntity? get selectedAccount =>
      accounts.where((a) => a.id == accountId).firstOrNull;

  AccountEntity? get selectedToAccount =>
      accounts.where((a) => a.id == toAccountId).firstOrNull;

  CategoryEntity? get selectedCategory =>
      categories.where((c) => c.id == categoryId).firstOrNull;
}
