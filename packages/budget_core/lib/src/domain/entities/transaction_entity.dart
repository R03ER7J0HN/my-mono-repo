import 'package:budget_core/src/domain/enums/transaction_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_entity.freezed.dart';

/// Represents a financial transaction
@freezed
sealed class TransactionEntity with _$TransactionEntity {
  const factory TransactionEntity({
    required String id,

    /// Source account ID
    required String accountId,

    /// Transaction type
    required TransactionType type,

    /// Transaction amount (always positive)
    required double amount,

    /// Transaction description
    required String description,

    /// Transaction date and time
    required DateTime date,

    /// Destination account ID (for transfers)
    String? toAccountId,

    /// Optional category ID for organization
    String? categoryId,

    /// Optional notes
    String? notes,

    /// Whether this is recurring
    @Default(false) bool isRecurring,

    /// Creation timestamp
    DateTime? createdAt,
  }) = _TransactionEntity;

  const TransactionEntity._();

  /// Whether this is a transfer transaction
  bool get isTransfer => type == TransactionType.transfer;

  /// Whether this is an income transaction
  bool get isIncome => type == TransactionType.income;

  /// Whether this is an expense transaction
  bool get isExpense => type == TransactionType.expense;

  /// Signed amount (negative for expenses from source account perspective)
  double get signedAmount {
    switch (type) {
      case TransactionType.income:
        return amount;
      case TransactionType.expense:
        return -amount;
      case TransactionType.transfer:
        return -amount; // Outgoing from source account
    }
  }
}
