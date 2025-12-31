// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: json['id'] as String,
      accountId: json['account_id'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      date: json['date'] as String,
      toAccountId: json['to_account_id'] as String?,
      categoryId: json['category_id'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_id': instance.accountId,
      'type': instance.type,
      'amount': instance.amount,
      'description': instance.description,
      'date': instance.date,
      'to_account_id': instance.toAccountId,
      'category_id': instance.categoryId,
      'notes': instance.notes,
      'created_at': instance.createdAt,
    };
