import 'dart:async';

import 'package:flutter_core/flutter_core.dart';
import 'package:location_tracking/src/domain/entities/place_prediction_entity.dart';
import 'package:location_tracking/src/domain/repositories/places_repository.dart';
import 'package:location_tracking/src/presentation/places_search/cubit/places_search_state.dart';
import 'package:uuid/uuid.dart';

/// Cubit for managing Places search state and business logic.
class PlacesSearchCubit extends Cubit<PlacesSearchState>
    with SafeEmitMixin<PlacesSearchState> {
  PlacesSearchCubit(
    this._repository, {
    this.debounceTime = const Duration(milliseconds: 400),
  }) : _sessionToken = const Uuid().v4(),
       super(const PlacesSearchState());

  final PlacesRepository _repository;
  final Duration debounceTime;
  final String _sessionToken;

  Timer? _debounceTimer;

  /// Searches for places based on the query with debouncing.
  void searchPlaces(String query) {
    _debounceTimer?.cancel();

    if (query.trim().isEmpty) {
      safeEmit(state.copyWith(predictions: []));
      return;
    }

    _debounceTimer = Timer(debounceTime, () => _executeSearch(query));
  }

  Future<void> _executeSearch(String query) async {
    safeEmit(state.copyWith(isSearching: true));

    final result = await _repository.searchPlaces(
      query,
      sessionToken: _sessionToken,
    );

    result.fold(
      onFailure: (failure) => safeEmit(
        state.copyWith(
          isSearching: false,
          predictions: [],
          errorMessage: failure.message,
        ),
      ),
      onSuccess: (predictions) => safeEmit(
        state.copyWith(
          isSearching: false,
          predictions: predictions,
        ),
      ),
    );
  }

  Future<void> selectPlace(PlacePredictionEntity prediction) async {
    safeEmit(
      state.copyWith(
        isFetchingDetails: true,
        predictions: [],
      ),
    );

    final result = await _repository.getPlaceDetails(
      prediction.placeId,
      sessionToken: _sessionToken,
    );

    result.fold(
      onFailure: (failure) {
        safeEmit(
          state.copyWith(
            isFetchingDetails: false,
            errorMessage: failure.message,
          ),
        );
      },
      onSuccess: (details) {
        safeEmit(
          state.copyWith(
            isFetchingDetails: false,
            selectedPlace: details,
          ),
        );
      },
    );
  }

  void clearPredictions() {
    _debounceTimer?.cancel();
    safeEmit(state.copyWith(predictions: []));
  }

  void clearSelection() {
    safeEmit(const PlacesSearchState());
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
