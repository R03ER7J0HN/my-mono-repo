import 'package:json_annotation/json_annotation.dart';
import 'package:location_tracking/src/domain/entities/place_details_entity.dart';

part 'place_details_model.g.dart';

@JsonSerializable(createToJson: false)
class PlaceDetailsResponseModel {
  const PlaceDetailsResponseModel({
    required this.result,
  });

  factory PlaceDetailsResponseModel.fromEntity(
    PlaceDetailsEntity entity,
  ) => PlaceDetailsResponseModel(
    result: PlaceDetailsResultModel(
      placeId: entity.placeId,
      name: entity.name,
      geometry: GeometryModel(
        location: LocationModel(
          lat: entity.latitude,
          lng: entity.longitude,
        ),
      ),
      formattedAddress: entity.formattedAddress,
    ),
  );

  factory PlaceDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsResponseModelFromJson(json);

  final PlaceDetailsResultModel result;

  PlaceDetailsEntity toEntity() => PlaceDetailsEntity(
    placeId: result.placeId,
    latitude: result.geometry.location.lat,
    longitude: result.geometry.location.lng,
    name: result.name,
    formattedAddress: result.formattedAddress,
  );
}

@JsonSerializable(createToJson: false)
class PlaceDetailsResultModel {
  const PlaceDetailsResultModel({
    required this.placeId,
    required this.geometry,
    this.formattedAddress,
    this.name,
  });

  factory PlaceDetailsResultModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsResultModelFromJson(json);

  final String? name;
  final GeometryModel geometry;

  @JsonKey(name: 'place_id')
  final String placeId;

  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;
}

@JsonSerializable(createToJson: false)
class GeometryModel {
  const GeometryModel({required this.location, this.viewport});

  factory GeometryModel.fromJson(Map<String, dynamic> json) =>
      _$GeometryModelFromJson(json);

  final LocationModel location;
  final ViewPortModel? viewport;
}

@JsonSerializable(createToJson: false)
class ViewPortModel {
  const ViewPortModel({
    required this.northeast,
    required this.southwest,
  });

  factory ViewPortModel.fromJson(Map<String, dynamic> json) =>
      _$ViewPortModelFromJson(json);

  final LocationModel northeast;
  final LocationModel southwest;
}

@JsonSerializable(createToJson: false)
class LocationModel {
  const LocationModel({required this.lat, required this.lng});

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  final double lat;
  final double lng;
}
