import 'package:dio/dio.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracking/src/data/datasources/places_remote_data_source.dart';
import 'package:location_tracking/src/data/models/place_details_model.dart';
import 'package:location_tracking/src/data/models/place_prediction_model.dart';
import 'package:location_tracking/src/data/repositories/google_places_repository.dart';
import 'package:location_tracking/src/domain/entities/place_details_entity.dart';
import 'package:location_tracking/src/domain/entities/place_prediction_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';

import 'places_repository_test.mocks.dart';

@GenerateMocks([PlacesRemoteDataSource])
void main() {
  late MockPlacesRemoteDataSource mockDataSource;
  late GooglePlacesRepository repository;

  // Test constants
  const tApiKey = 'test_api_key';
  const tPlaceId = 'place_123';
  const tQuery = 'test';
  const tMainText = 'Test Place';
  const tSecondaryText = 'Test City';
  const tDescription = '$tMainText, $tSecondaryText';
  const tFormattedAddress = 'Test Address';
  const tLatitude = 1.0;
  const tLongitude = 2.0;

  setUp(() {
    mockDataSource = MockPlacesRemoteDataSource();
    repository = GooglePlacesRepository(
      dataSource: mockDataSource,
      apiKey: tApiKey,
    );
  });

  const tPredictionModel = PlacePredictionModel(
    placeId: tPlaceId,
    description: tDescription,
    structuredFormatting: StructuredFormattingModel(
      mainText: tMainText,
      secondaryText: tSecondaryText,
    ),
  );

  const tPredictionEntity = PlacePredictionEntity(
    placeId: tPlaceId,
    description: tDescription,
    mainText: tMainText,
    secondaryText: tSecondaryText,
  );

  const tDetailsModel = PlaceDetailsModel(
    placeId: tPlaceId,
    latitude: tLatitude,
    longitude: tLongitude,
    formattedAddress: tFormattedAddress,
    name: tMainText,
  );

  const tDetailsEntity = PlaceDetailsEntity(
    placeId: tPlaceId,
    latitude: tLatitude,
    longitude: tLongitude,
    formattedAddress: tFormattedAddress,
    name: tMainText,
  );

  group('PlacesRepositoryImpl', () {
    group('searchPlaces', () {
      test('returns Success with empty list when query is empty', () async {
        // Act
        final result = await repository.searchPlaces('');

        // Assert
        expect(result.isSuccess, isTrue);
        result.fold(
          onFailure: (_) => fail('Expected success'),
          onSuccess: (predictions) => expect(predictions, isEmpty),
        );
        verifyNever(
          mockDataSource.searchPlaces(
            query: anyNamed('query'),
            apiKey: anyNamed('apiKey'),
          ),
        );
      });

      test(
        'returns Success with entities when data source returns predictions',
        () async {
          // Arrange
          when(
            mockDataSource.searchPlaces(query: tQuery, apiKey: tApiKey),
          ).thenAnswer(
            (_) async => HttpResponse(
              const PlacesPredictionResponseModel(
                predictions: [tPredictionModel],
              ),
              Response(requestOptions: RequestOptions()),
            ),
          );

          // Act
          final result = await repository.searchPlaces(tQuery);

          // Assert
          expect(result.isSuccess, isTrue);
          result.fold(
            onFailure: (_) => fail('Expected success'),
            onSuccess: (predictions) {
              expect(predictions, hasLength(1));
              expect(predictions.first, equals(tPredictionEntity));
            },
          );
          verify(
            mockDataSource.searchPlaces(query: tQuery, apiKey: tApiKey),
          ).called(1);
        },
      );

      test('returns Failure when data source throws exception', () async {
        // Arrange
        when(
          mockDataSource.searchPlaces(query: tQuery, apiKey: tApiKey),
        ).thenAnswer((_) async => throw Exception('Network error'));

        // Act
        final result = await repository.searchPlaces(tQuery);

        // Assert
        expect(result.isFailure, isTrue);
        result.fold(
          onFailure: (failure) {
            expect(failure, isA<GenericFailure>());
          },
          onSuccess: (_) => fail('Expected failure'),
        );
      });
    });

    group('getPlaceDetails', () {
      test(
        'returns Success with entity when data source returns details',
        () async {
          // Arrange
          when(
            mockDataSource.getPlaceDetails(
              placeId: tPlaceId,
              apiKey: tApiKey,
            ),
          ).thenAnswer(
            (_) async => HttpResponse(
              tDetailsModel,
              Response(requestOptions: RequestOptions()),
            ),
          );

          // Act
          final result = await repository.getPlaceDetails(tPlaceId);

          // Assert
          expect(result.isSuccess, isTrue);
          result.fold(
            onFailure: (_) => fail('Expected success'),
            onSuccess: (details) => expect(details, equals(tDetailsEntity)),
          );
          verify(
            mockDataSource.getPlaceDetails(
              placeId: tPlaceId,
              apiKey: tApiKey,
            ),
          ).called(1);
        },
      );

      test('returns Failure when data source throws exception', () async {
        // Arrange
        when(
          mockDataSource.getPlaceDetails(placeId: tPlaceId, apiKey: tApiKey),
        ).thenAnswer((_) async => throw Exception('Network error'));

        // Act
        final result = await repository.getPlaceDetails(tPlaceId);

        // Assert
        expect(result.isFailure, isTrue);
        result.fold(
          onFailure: (failure) {
            expect(failure, isA<GenericFailure>());
          },
          onSuccess: (_) => fail('Expected failure'),
        );
      });
    });
  });
}
