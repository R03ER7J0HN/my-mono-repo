import 'package:budget_core/src/data/converters/json_converters.dart';
import 'package:budget_core/src/domain/entities/account_entity.dart';
import 'package:budget_core/src/domain/enums/account_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable()
class AccountModel extends Equatable {
  const AccountModel({
    required this.id,
    required this.name,
    required this.type,
    required this.balance,
    this.creditLimit,
    this.budgetLimit,
    this.warningThreshold = 0.8,
    this.iconName,
    this.colorHex,
    this.isActive = true,
    this.createdAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  factory AccountModel.fromEntity(AccountEntity entity) => AccountModel(
    id: entity.id,
    name: entity.name,
    type: entity.type.name,
    balance: entity.balance,
    creditLimit: entity.creditLimit,
    budgetLimit: entity.budgetLimit,
    warningThreshold: entity.warningThreshold,
    iconName: entity.iconName,
    colorHex: entity.colorHex,
    isActive: entity.isActive,
    createdAt: entity.createdAt?.toIso8601String(),
  );

  final String id;
  final String name;
  final String type;
  final double balance;

  @JsonKey(name: 'credit_limit')
  final double? creditLimit;

  @JsonKey(name: 'budget_limit')
  final double? budgetLimit;

  @JsonKey(name: 'warning_threshold')
  final double warningThreshold;

  @JsonKey(name: 'icon_name')
  final String? iconName;

  @JsonKey(name: 'color_hex')
  final String? colorHex;

  @JsonKey(
    name: 'is_active',
    fromJson: JsonConverters.boolFromInt,
    toJson: JsonConverters.boolToInt,
  )
  final bool isActive;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);

  AccountEntity toEntity() => AccountEntity(
    id: id,
    name: name,
    type: AccountType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => AccountType.cash,
    ),
    balance: balance,
    creditLimit: creditLimit,
    budgetLimit: budgetLimit,
    warningThreshold: warningThreshold,
    iconName: iconName,
    colorHex: colorHex,
    isActive: isActive,
    createdAt: createdAt != null ? DateTime.parse(createdAt!) : null,
  );

  @override
  List<Object?> get props => [id];
}

extension AccountModelListExt on List<AccountModel> {
  List<AccountEntity> toEntityList() => map((m) => m.toEntity()).toList();
}
