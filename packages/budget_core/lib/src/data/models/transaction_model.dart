import 'package:budget_core/src/domain/entities/transaction_entity.dart';
import 'package:budget_core/src/domain/enums/transaction_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel extends Equatable {
  const TransactionModel({
    required this.id,
    required this.accountId,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
    this.toAccountId,
    this.categoryId,
    this.notes,
    this.createdAt,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  factory TransactionModel.fromEntity(TransactionEntity entity) =>
      TransactionModel(
        id: entity.id,
        accountId: entity.accountId,
        type: entity.type.name,
        amount: entity.amount,
        description: entity.description,
        date: entity.date.toIso8601String(),
        toAccountId: entity.toAccountId,
        categoryId: entity.categoryId,
        notes: entity.notes,
        createdAt: entity.createdAt?.toIso8601String(),
      );

  final String id;

  @JsonKey(name: 'account_id')
  final String accountId;

  final String type;
  final double amount;
  final String description;
  final String date;

  @JsonKey(name: 'to_account_id')
  final String? toAccountId;

  @JsonKey(name: 'category_id')
  final String? categoryId;

  final String? notes;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  TransactionEntity toEntity() => TransactionEntity(
    id: id,
    accountId: accountId,
    type: TransactionType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => TransactionType.expense,
    ),
    amount: amount,
    description: description,
    date: DateTime.parse(date),
    toAccountId: toAccountId,
    categoryId: categoryId,
    notes: notes,
    createdAt: createdAt != null ? DateTime.parse(createdAt!) : null,
  );

  @override
  List<Object?> get props => [id];
}

extension TransactionModelListExt on List<TransactionModel> {
  List<TransactionEntity> toEntityList() => map((m) => m.toEntity()).toList();
}
