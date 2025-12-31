// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IconDataModel _$IconDataModelFromJson(Map<String, dynamic> json) =>
    _IconDataModel(
      name: json['name'] as String,
      codePoint: (json['codePoint'] as num).toInt(),
      fontFamily: json['fontFamily'] as String,
      fontPackage: json['fontPackage'] as String? ?? 'MaterialIcons',
    );

Map<String, dynamic> _$IconDataModelToJson(_IconDataModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'codePoint': instance.codePoint,
      'fontFamily': instance.fontFamily,
      'fontPackage': instance.fontPackage,
    };
