import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracking/src/domain/entities/place_details_entity.dart';
import 'package:location_tracking/src/domain/entities/place_prediction_entity.dart';
import 'package:location_tracking/src/domain/failures/places_failure.dart';
import 'package:location_tracking/src/domain/repositories/places_repository.dart';
import 'package:location_tracking/src/presentation/places_search/cubit/places_search_cubit.dart';
import 'package:location_tracking/src/presentation/places_search/cubit/places_search_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'places_search_cubit_test.mocks.dart';

@GenerateMocks([PlacesRepository])
void main() {
  late MockPlacesRepository mockRepository;
  late PlacesSearchCubit cubit;

  setUp(() {
    mockRepository = MockPlacesRepository();
    cubit = PlacesSearchCubit(
      mockRepository,
      debounceTime: Duration.zero,
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  const tPrediction = PlacePredictionEntity(
    placeId: 'place_123',
    description: 'Test Place, Test City',
    mainText: 'Test Place',
    secondaryText: 'Test City',
  );

  const tPredictions = [tPrediction];

  const tPlaceDetails = PlaceDetailsEntity(
    placeId: 'place_123',
    latitude: 1,
    longitude: 2,
    formattedAddress: 'Test Address',
    name: 'Test Place',
  );

  group('PlacesSearchCubit', () {
    test('initial state is PlacesSearchState()', () {
      expect(cubit.state, const PlacesSearchState());
    });

    group('searchPlaces', () {
      blocTest<PlacesSearchCubit, PlacesSearchState>(
        'emits [isSearching: true, predictions] when search succeeds',
        build: () {
          when(
            mockRepository.searchPlaces('test'),
          ).thenAnswer((_) async => Result.success(tPredictions));
          return cubit;
        },
        act: (cubit) async {
          cubit.searchPlaces('test');
          await Future<void>.delayed(const Duration(milliseconds: 50));
        },
        expect: () => [
          const PlacesSearchState(isSearching: true),
          const PlacesSearchState(predictions: tPredictions),
        ],
        verify: (_) {
          verify(mockRepository.searchPlaces('test')).called(1);
        },
      );

      blocTest<PlacesSearchCubit, PlacesSearchState>(
        'emits [isSearching: true, error] when search fails',
        build: () {
          when(mockRepository.searchPlaces('test')).thenAnswer(
            (_) async => Result.failure(
              const PlacesFailure('Search failed'),
            ),
          );
          return cubit;
        },
        act: (cubit) async {
          cubit.searchPlaces('test');
          await Future<void>.delayed(const Duration(milliseconds: 50));
        },
        expect: () => [
          const PlacesSearchState(isSearching: true),
          const PlacesSearchState(errorMessage: 'Search failed'),
        ],
      );

      blocTest<PlacesSearchCubit, PlacesSearchState>(
        'emits empty predictions when query is empty',
        build: () => cubit,
        seed: () => const PlacesSearchState(predictions: tPredictions),
        act: (cubit) => cubit.searchPlaces(''),
        expect: () => [const PlacesSearchState()],
        verify: (_) {
          verifyNever(mockRepository.searchPlaces(any));
        },
      );

      blocTest<PlacesSearchCubit, PlacesSearchState>(
        'emits empty predictions when query is whitespace only',
        build: () => cubit,
        seed: () => const PlacesSearchState(predictions: tPredictions),
        act: (cubit) => cubit.searchPlaces('   '),
        expect: () => [const PlacesSearchState()],
        verify: (_) {
          verifyNever(mockRepository.searchPlaces(any));
        },
      );
    });

    group('selectPlace', () {
      blocTest<PlacesSearchCubit, PlacesSearchState>(
        'emits [isFetchingDetails: true, selectedPlace] when successful',
        build: () {
          when(
            mockRepository.getPlaceDetails('place_123'),
          ).thenAnswer((_) async => Result.success(tPlaceDetails));
          return cubit;
        },
        seed: () => const PlacesSearchState(predictions: tPredictions),
        act: (cubit) => cubit.selectPlace(tPrediction),
        expect: () => [
          const PlacesSearchState(isFetchingDetails: true),
          const PlacesSearchState(selectedPlace: tPlaceDetails),
        ],
        verify: (_) {
          verify(mockRepository.getPlaceDetails('place_123')).called(1);
        },
      );

      blocTest<PlacesSearchCubit, PlacesSearchState>(
        'emits [isFetchingDetails: true, error] when fails',
        build: () {
          when(mockRepository.getPlaceDetails('place_123')).thenAnswer(
            (_) async => Result.failure(
              const PlacesFailure('Failed to get details'),
            ),
          );
          return cubit;
        },
        seed: () => const PlacesSearchState(predictions: tPredictions),
        act: (cubit) => cubit.selectPlace(tPrediction),
        expect: () => [
          const PlacesSearchState(isFetchingDetails: true),
          const PlacesSearchState(errorMessage: 'Failed to get details'),
        ],
      );
    });

    group('clearPredictions', () {
      blocTest<PlacesSearchCubit, PlacesSearchState>(
        'emits state with empty predictions',
        build: () => cubit,
        seed: () => const PlacesSearchState(predictions: tPredictions),
        act: (cubit) => cubit.clearPredictions(),
        expect: () => [const PlacesSearchState()],
      );
    });

    group('clearSelection', () {
      blocTest<PlacesSearchCubit, PlacesSearchState>(
        'emits state with null selectedPlace',
        build: () => cubit,
        seed: () => const PlacesSearchState(selectedPlace: tPlaceDetails),
        act: (cubit) => cubit.clearSelection(),
        expect: () => [const PlacesSearchState()],
      );
    });
  });
}
