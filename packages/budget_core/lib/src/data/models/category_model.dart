import 'package:budget_core/src/domain/entities/category_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends Equatable {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.iconCodePoint,
    required this.colorHex,
    this.isSystem = false,
    this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  factory CategoryModel.fromEntity(CategoryEntity entity) => CategoryModel(
    id: entity.id,
    name: entity.name,
    iconCodePoint: entity.iconCodePoint,
    colorHex: entity.colorHex,
    isSystem: entity.isSystem,
    createdAt: entity.createdAt,
  );

  final String id;
  final String name;

  @JsonKey(name: 'icon_code_point')
  final int iconCodePoint;

  @JsonKey(name: 'color_hex')
  final String colorHex;

  @BoolToIntConverter()
  @JsonKey(name: 'is_system')
  final bool isSystem;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  CategoryEntity toEntity() => CategoryEntity(
    id: id,
    name: name,
    iconCodePoint: iconCodePoint,
    colorHex: colorHex,
    isSystem: isSystem,
    createdAt: createdAt,
  );

  @override
  List<Object?> get props => [id];
}

extension CategoryModelListExt on List<CategoryModel> {
  List<CategoryEntity> toEntityList() => map((m) => m.toEntity()).toList();
}
