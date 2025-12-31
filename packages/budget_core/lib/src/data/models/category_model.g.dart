// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      iconCodePoint: (json['icon_code_point'] as num).toInt(),
      colorHex: json['color_hex'] as String,
      isSystem: json['is_system'] == null
          ? false
          : JsonConverters.boolFromInt((json['is_system'] as num).toInt()),
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon_code_point': instance.iconCodePoint,
      'color_hex': instance.colorHex,
      'is_system': JsonConverters.boolToInt(instance.isSystem),
      'created_at': instance.createdAt,
    };
