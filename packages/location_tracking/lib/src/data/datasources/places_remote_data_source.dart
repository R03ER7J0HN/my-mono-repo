import 'package:dio/dio.dart';
import 'package:location_tracking/src/data/models/place_details_model.dart';
import 'package:location_tracking/src/data/models/place_prediction_model.dart';
import 'package:retrofit/retrofit.dart';

part 'places_remote_data_source.g.dart';

/// Remote data source for Google Places API using Retrofit pattern.
/// Returns response models for repository to process.
@RestApi(baseUrl: 'https://maps.googleapis.com/maps/api/place')
abstract class PlacesRemoteDataSource {
  factory PlacesRemoteDataSource(Dio dio, {String baseUrl}) =
      _PlacesRemoteDataSource;

  /// Searches for place predictions based on the input text.
  @GET('/autocomplete/json')
  Future<HttpResponse<PlacesPredictionResponseModel>> searchPlaces({
    @Query('input') required String query,
    @Query('key') required String apiKey,
    @Query('components') String components = 'country:ph',
  });

  /// Gets detailed information about a place by its ID.
  @GET('/details/json')
  Future<HttpResponse<PlaceDetailsModel>> getPlaceDetails({
    @Query('place_id') required String placeId,
    @Query('key') required String apiKey,
    @Query('fields') String fields = 'place_id,geometry,formatted_address,name',
  });
}
