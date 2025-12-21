import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location_tracking/src/domain/entities/place_details_entity.dart';
import 'package:location_tracking/src/domain/entities/place_prediction_entity.dart';

part 'places_search_state.freezed.dart';

@freezed
sealed class PlacesSearchState with _$PlacesSearchState {
  const factory PlacesSearchState({
    /// List of place predictions from the search.
    @Default([]) List<PlacePredictionEntity> predictions,

    /// Whether a search is in progress.
    @Default(false) bool isSearching,

    /// Whether place details are being fetched.
    @Default(false) bool isFetchingDetails,

    /// The selected place details (after user selects a prediction).
    PlaceDetailsEntity? selectedPlace,

    /// Error message if an operation failed.
    String? errorMessage,
  }) = _PlacesSearchState;
}
