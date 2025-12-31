// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstallmentModel _$InstallmentModelFromJson(Map<String, dynamic> json) =>
    InstallmentModel(
      id: json['id'] as String,
      accountId: json['account_id'] as String,
      description: json['description'] as String,
      totalAmount: (json['total_amount'] as num).toDouble(),
      totalInstallments: (json['total_installments'] as num).toInt(),
      startDate: json['start_date'] as String,
      paidInstallments: (json['paid_installments'] as num?)?.toInt() ?? 0,
      frequency: json['frequency'] as String? ?? 'monthly',
      merchantName: json['merchant_name'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$InstallmentModelToJson(InstallmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_id': instance.accountId,
      'description': instance.description,
      'total_amount': instance.totalAmount,
      'total_installments': instance.totalInstallments,
      'paid_installments': instance.paidInstallments,
      'frequency': instance.frequency,
      'start_date': instance.startDate,
      'merchant_name': instance.merchantName,
      'notes': instance.notes,
      'created_at': instance.createdAt,
    };
