import 'package:json_annotation/json_annotation.dart';
import 'package:location_tracking/src/domain/entities/place_details_entity.dart';

part 'place_details_model.g.dart';

@JsonSerializable()
class PlaceDetailsModel {
  const PlaceDetailsModel({
    required this.placeId,
    required this.latitude,
    required this.longitude,
    this.name,
    this.formattedAddress,
  });

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsModelFromJson(json);

  @JsonKey(name: 'place_id')
  final String placeId;

  @JsonKey(name: 'lat')
  final double latitude;

  @JsonKey(name: 'lng')
  final double longitude;

  final String? name;

  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;

  Map<String, dynamic> toJson() => _$PlaceDetailsModelToJson(this);

  PlaceDetailsEntity toEntity() => PlaceDetailsEntity(
    placeId: placeId,
    latitude: latitude,
    longitude: longitude,
    name: name,
    formattedAddress: formattedAddress,
  );
}
