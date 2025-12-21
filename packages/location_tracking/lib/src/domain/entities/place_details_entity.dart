import 'package:equatable/equatable.dart';

/// Represents detailed information about a place from Google Places API.
class PlaceDetailsEntity extends Equatable {
  const PlaceDetailsEntity({
    required this.placeId,
    required this.latitude,
    required this.longitude,
    this.formattedAddress,
    this.name,
  });

  /// The unique identifier for this place.
  final String placeId;

  /// The latitude of the place.
  final double latitude;

  /// The longitude of the place.
  final double longitude;

  /// The formatted address of the place.
  final String? formattedAddress;

  /// The name of the place.
  final String? name;

  @override
  List<Object?> get props => [
    placeId,
    latitude,
    longitude,
  ];
}
