import 'package:budget_core/src/domain/enums/installment_frequency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'installment_entity.freezed.dart';

/// Represents a credit card installment plan
@freezed
sealed class InstallmentEntity with _$InstallmentEntity {
  const factory InstallmentEntity({
    required String id,

    /// Associated credit card account ID
    required String accountId,

    /// Description of the purchase
    required String description,

    /// Total amount of the purchase
    required double totalAmount,

    /// Total number of installments
    required int totalInstallments,

    /// Start date of the installment plan
    required DateTime startDate,

    /// Number of installments already paid
    @Default(0) int paidInstallments,

    /// Payment frequency
    @Default(InstallmentFrequency.monthly) InstallmentFrequency frequency,

    /// Optional merchant/store name
    String? merchantName,

    /// Optional notes
    String? notes,

    /// Creation timestamp
    DateTime? createdAt,
  }) = _InstallmentEntity;

  const InstallmentEntity._();

  /// Amount per installment
  double get monthlyAmount {
    if (totalInstallments == 0) return 0;
    return totalAmount / totalInstallments;
  }

  /// Remaining number of installments
  int get remainingInstallments => totalInstallments - paidInstallments;

  /// Remaining amount to pay
  double get remainingAmount => monthlyAmount * remainingInstallments;

  /// Amount already paid
  double get paidAmount => monthlyAmount * paidInstallments;

  /// Whether installment is fully paid
  bool get isFullyPaid => paidInstallments >= totalInstallments;

  /// End date based on frequency and total installments
  DateTime get endDate {
    switch (frequency) {
      case InstallmentFrequency.monthly:
        return DateTime(
          startDate.year,
          startDate.month + totalInstallments,
          startDate.day,
        );
      case InstallmentFrequency.quarterly:
        return DateTime(
          startDate.year,
          startDate.month + (totalInstallments * 3),
          startDate.day,
        );
      case InstallmentFrequency.yearly:
        return DateTime(
          startDate.year + totalInstallments,
          startDate.month,
          startDate.day,
        );
    }
  }

  /// Progress percentage (0-1)
  double get progressPercentage {
    if (totalInstallments == 0) return 0;
    return (paidInstallments / totalInstallments).clamp(0.0, 1.0);
  }
}
