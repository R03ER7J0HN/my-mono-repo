import 'package:flutter_core/flutter_core.dart';
import 'package:location_tracking/src/domain/entities/place_details_entity.dart';
import 'package:location_tracking/src/domain/entities/place_prediction_entity.dart';

/// Repository for Google Places API operations.
abstract class PlacesRepository {
  /// Searches for place predictions based on the input text.
  FutureResult<List<PlacePredictionEntity>> searchPlaces(String query);

  /// Gets detailed information about a place by its ID.
  FutureResult<PlaceDetailsEntity> getPlaceDetails(String placeId);
}
