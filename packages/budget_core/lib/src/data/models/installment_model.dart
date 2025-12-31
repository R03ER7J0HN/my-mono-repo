import 'package:budget_core/src/domain/entities/installment_entity.dart';
import 'package:budget_core/src/domain/enums/installment_frequency.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'installment_model.g.dart';

@JsonSerializable()
class InstallmentModel extends Equatable {
  const InstallmentModel({
    required this.id,
    required this.accountId,
    required this.description,
    required this.totalAmount,
    required this.totalInstallments,
    required this.startDate,
    this.paidInstallments = 0,
    this.frequency = 'monthly',
    this.merchantName,
    this.notes,
    this.createdAt,
  });

  factory InstallmentModel.fromJson(Map<String, dynamic> json) =>
      _$InstallmentModelFromJson(json);

  factory InstallmentModel.fromEntity(InstallmentEntity entity) =>
      InstallmentModel(
        id: entity.id,
        accountId: entity.accountId,
        description: entity.description,
        totalAmount: entity.totalAmount,
        totalInstallments: entity.totalInstallments,
        paidInstallments: entity.paidInstallments,
        frequency: entity.frequency.name,
        startDate: entity.startDate.toIso8601String(),
        merchantName: entity.merchantName,
        notes: entity.notes,
        createdAt: entity.createdAt?.toIso8601String(),
      );

  final String id;

  @JsonKey(name: 'account_id')
  final String accountId;

  final String description;

  @JsonKey(name: 'total_amount')
  final double totalAmount;

  @JsonKey(name: 'total_installments')
  final int totalInstallments;

  @JsonKey(name: 'paid_installments')
  final int paidInstallments;

  final String frequency;

  @JsonKey(name: 'start_date')
  final String startDate;

  @JsonKey(name: 'merchant_name')
  final String? merchantName;

  final String? notes;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  Map<String, dynamic> toJson() => _$InstallmentModelToJson(this);

  InstallmentEntity toEntity() => InstallmentEntity(
    id: id,
    accountId: accountId,
    description: description,
    totalAmount: totalAmount,
    totalInstallments: totalInstallments,
    paidInstallments: paidInstallments,
    frequency: InstallmentFrequency.values.firstWhere(
      (e) => e.name == frequency,
      orElse: () => InstallmentFrequency.monthly,
    ),
    startDate: DateTime.parse(startDate),
    merchantName: merchantName,
    notes: notes,
    createdAt: createdAt != null ? DateTime.parse(createdAt!) : null,
  );

  @override
  List<Object?> get props => [id];
}

/// Extension to convert list of models to entities
extension InstallmentModelListExt on List<InstallmentModel> {
  /// Converts list of models to list of entities
  List<InstallmentEntity> toEntityList() => map((m) => m.toEntity()).toList();
}
