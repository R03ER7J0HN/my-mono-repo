import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracking/src/data/datasources/geolocator_data_source.dart';
import 'package:location_tracking/src/data/repositories/geolocator_repository.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/entities/location_permission_status.dart';
import 'package:location_tracking/src/domain/failures/location_failure.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'geolocator_repository_test.mocks.dart';

@GenerateMocks([GeolocatorDataSource])
void main() {
  late MockGeolocatorDataSource mockDataSource;
  late GeolocatorRepository repository;

  setUp(() {
    mockDataSource = MockGeolocatorDataSource();
    repository = GeolocatorRepository(mockDataSource);
  });

  final tPosition = Position(
    longitude: 100,
    latitude: 100,
    timestamp: DateTime(2023),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );

  final tLocationEntity = LocationEntity(
    longitude: 100,
    latitude: 100,
    timestamp: DateTime(2023),
  );

  group('getCurrentLocation', () {
    test(
      '''
should return LocationEntity when permission is granted and service enabled''',
      () async {
        // Arrange
        when(
          mockDataSource.isLocationServiceEnabled(),
        ).thenAnswer((_) async => true);
        when(
          mockDataSource.checkPermission(),
        ).thenAnswer((_) async => LocationPermission.always);
        when(
          mockDataSource.getCurrentPosition(),
        ).thenAnswer((_) async => tPosition);

        // Act
        final result = await repository.getCurrentLocation();

        // Assert
        expect(result.isSuccess, true);
        expect(result.getSuccess(), tLocationEntity);
        verify(mockDataSource.getCurrentPosition()).called(1);
      },
    );

    test('should return failure when service is disabled', () async {
      // Arrange
      when(
        mockDataSource.isLocationServiceEnabled(),
      ).thenAnswer((_) async => false);

      // Act
      final result = await repository.getCurrentLocation();

      // Assert
      expect(result.isFailure, true);
      expect(result.getFailure(), isA<LocationFailure>());
      verifyNever(mockDataSource.getCurrentPosition());
    });

    test('should request permission when permission is denied', () async {
      // Arrange
      when(
        mockDataSource.isLocationServiceEnabled(),
      ).thenAnswer((_) async => true);
      when(
        mockDataSource.checkPermission(),
      ).thenAnswer((_) async => LocationPermission.denied);
      when(
        mockDataSource.requestPermission(),
      ).thenAnswer((_) async => LocationPermission.always);
      when(
        mockDataSource.getCurrentPosition(),
      ).thenAnswer((_) async => tPosition);

      // Act
      final result = await repository.getCurrentLocation();

      // Assert
      expect(result.isSuccess, true);
      verify(mockDataSource.requestPermission()).called(1);
    });

    test('should return failure when permission is denied forever', () async {
      // Arrange
      when(
        mockDataSource.isLocationServiceEnabled(),
      ).thenAnswer((_) async => true);
      when(
        mockDataSource.checkPermission(),
      ).thenAnswer((_) async => LocationPermission.deniedForever);

      // Act
      final result = await repository.getCurrentLocation();

      // Assert
      expect(result.isFailure, true);
      verifyNever(mockDataSource.getCurrentPosition());
    });
  });

  group('checkPermission', () {
    test('should return LocationPermissionStatus', () async {
      // Arrange
      when(
        mockDataSource.checkPermission(),
      ).thenAnswer((_) async => LocationPermission.always);

      // Act
      final result = await repository.checkPermission();

      // Assert
      expect(result.isSuccess, true);
      expect(result.getSuccess(), LocationPermissionStatus.always);
    });
  });

  group('calculateDistance', () {
    test('should return distance', () {
      // Arrange
      when(
        mockDataSource.distanceBetween(any, any, any, any),
      ).thenReturn(100);

      // Act
      final result = repository.calculateDistance(
        tLocationEntity,
        tLocationEntity,
      );

      // Assert
      expect(result, 100.0);
    });
  });
}
