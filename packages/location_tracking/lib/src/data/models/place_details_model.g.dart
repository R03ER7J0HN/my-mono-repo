// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetailsModel _$PlaceDetailsModelFromJson(Map<String, dynamic> json) =>
    PlaceDetailsModel(
      placeId: json['place_id'] as String,
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lng'] as num).toDouble(),
      name: json['name'] as String?,
      formattedAddress: json['formatted_address'] as String?,
    );

Map<String, dynamic> _$PlaceDetailsModelToJson(PlaceDetailsModel instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'lat': instance.latitude,
      'lng': instance.longitude,
      'name': instance.name,
      'formatted_address': instance.formattedAddress,
    };
