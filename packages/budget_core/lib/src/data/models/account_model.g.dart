// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
  balance: (json['balance'] as num).toDouble(),
  creditLimit: (json['credit_limit'] as num?)?.toDouble(),
  budgetLimit: (json['budget_limit'] as num?)?.toDouble(),
  warningThreshold: (json['warning_threshold'] as num?)?.toDouble() ?? 0.8,
  iconName: json['icon_name'] as String?,
  colorHex: json['color_hex'] as String?,
  isActive: json['is_active'] == null
      ? true
      : JsonConverters.boolFromInt((json['is_active'] as num).toInt()),
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'balance': instance.balance,
      'credit_limit': instance.creditLimit,
      'budget_limit': instance.budgetLimit,
      'warning_threshold': instance.warningThreshold,
      'icon_name': instance.iconName,
      'color_hex': instance.colorHex,
      'is_active': JsonConverters.boolToInt(instance.isActive),
      'created_at': instance.createdAt,
    };
