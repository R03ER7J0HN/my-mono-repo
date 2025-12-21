import 'package:equatable/equatable.dart';

/// Represents a place prediction from Google Places Autocomplete API.
class PlacePredictionEntity extends Equatable {
  const PlacePredictionEntity({
    required this.placeId,
    required this.description,
    this.mainText,
    this.secondaryText,
  });

  /// The unique identifier for this place.
  final String placeId;

  /// The full description of the place.
  final String description;

  /// The main text (usually the place name).
  final String? mainText;

  /// The secondary text (usually the address).
  final String? secondaryText;

  @override
  List<Object?> get props => [placeId, description];
}
