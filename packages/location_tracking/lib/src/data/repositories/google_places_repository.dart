import 'package:flutter_core/flutter_core.dart';
import 'package:location_tracking/src/data/datasources/places_remote_data_source.dart';
import 'package:location_tracking/src/data/models/place_prediction_model.dart';
import 'package:location_tracking/src/domain/entities/place_details_entity.dart';
import 'package:location_tracking/src/domain/entities/place_prediction_entity.dart';
import 'package:location_tracking/src/domain/repositories/places_repository.dart';

class GooglePlacesRepository with ExceptionHandler implements PlacesRepository {
  const GooglePlacesRepository({
    required PlacesRemoteDataSource dataSource,
    required String apiKey,
  }) : _dataSource = dataSource,
       _apiKey = apiKey;

  final PlacesRemoteDataSource _dataSource;
  final String _apiKey;

  @override
  FutureResult<List<PlacePredictionEntity>> searchPlaces(String query) async {
    if (query.trim().isEmpty) {
      return Result.success(const []);
    }

    return handleException(
      _dataSource.searchPlaces(query: query, apiKey: _apiKey),
      onSuccess: (response) {
        return response.data.predictions.toEntityList();
      },
    );
  }

  @override
  FutureResult<PlaceDetailsEntity> getPlaceDetails(String placeId) async {
    return handleException(
      _dataSource.getPlaceDetails(placeId: placeId, apiKey: _apiKey),
      onSuccess: (response) {
        return response.data.toEntity();
      },
    );
  }
}
