// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlyBudgetModel _$MonthlyBudgetModelFromJson(Map<String, dynamic> json) =>
    MonthlyBudgetModel(
      id: json['id'] as String,
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      totalBudget: (json['total_budget'] as num).toDouble(),
      spentAmount: (json['spent_amount'] as num?)?.toDouble() ?? 0,
      dailyBudget: (json['daily_budget'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MonthlyBudgetModelToJson(MonthlyBudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'month': instance.month,
      'total_budget': instance.totalBudget,
      'spent_amount': instance.spentAmount,
      'daily_budget': instance.dailyBudget,
      'notes': instance.notes,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
