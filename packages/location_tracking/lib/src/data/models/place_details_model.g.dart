// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetailsResponseModel _$PlaceDetailsResponseModelFromJson(
  Map<String, dynamic> json,
) => PlaceDetailsResponseModel(
  result: PlaceDetailsResultModel.fromJson(
    json['result'] as Map<String, dynamic>,
  ),
);

PlaceDetailsResultModel _$PlaceDetailsResultModelFromJson(
  Map<String, dynamic> json,
) => PlaceDetailsResultModel(
  placeId: json['place_id'] as String,
  geometry: GeometryModel.fromJson(json['geometry'] as Map<String, dynamic>),
  formattedAddress: json['formatted_address'] as String?,
  name: json['name'] as String?,
);

GeometryModel _$GeometryModelFromJson(Map<String, dynamic> json) =>
    GeometryModel(
      location: LocationModel.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      viewport: json['viewport'] == null
          ? null
          : ViewPortModel.fromJson(json['viewport'] as Map<String, dynamic>),
    );

ViewPortModel _$ViewPortModelFromJson(
  Map<String, dynamic> json,
) => ViewPortModel(
  northeast: LocationModel.fromJson(json['northeast'] as Map<String, dynamic>),
  southwest: LocationModel.fromJson(json['southwest'] as Map<String, dynamic>),
);

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
