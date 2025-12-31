import 'package:budget_core/src/domain/entities/monthly_budget_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'monthly_budget_model.g.dart';

@JsonSerializable()
class MonthlyBudgetModel extends Equatable {
  const MonthlyBudgetModel({
    required this.id,
    required this.year,
    required this.month,
    required this.totalBudget,
    this.spentAmount = 0,
    this.dailyBudget,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory MonthlyBudgetModel.fromJson(Map<String, dynamic> json) =>
      _$MonthlyBudgetModelFromJson(json);

  factory MonthlyBudgetModel.fromEntity(MonthlyBudgetEntity entity) =>
      MonthlyBudgetModel(
        id: entity.id,
        year: entity.year,
        month: entity.month,
        totalBudget: entity.totalBudget,
        spentAmount: entity.spentAmount,
        dailyBudget: entity.dailyBudget,
        notes: entity.notes,
        createdAt: entity.createdAt?.toIso8601String(),
        updatedAt: entity.updatedAt?.toIso8601String(),
      );

  final String id;
  final int year;
  final int month;

  @JsonKey(name: 'total_budget')
  final double totalBudget;

  @JsonKey(name: 'spent_amount')
  final double spentAmount;

  @JsonKey(name: 'daily_budget')
  final double? dailyBudget;

  final String? notes;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  Map<String, dynamic> toJson() => _$MonthlyBudgetModelToJson(this);

  MonthlyBudgetEntity toEntity() => MonthlyBudgetEntity(
    id: id,
    year: year,
    month: month,
    totalBudget: totalBudget,
    spentAmount: spentAmount,
    dailyBudget: dailyBudget,
    notes: notes,
    createdAt: createdAt != null ? DateTime.parse(createdAt!) : null,
    updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
  );

  @override
  List<Object?> get props => [id];
}

extension MonthlyBudgetModelListExt on List<MonthlyBudgetModel> {
  List<MonthlyBudgetEntity> toEntityList() => map((m) => m.toEntity()).toList();
}
