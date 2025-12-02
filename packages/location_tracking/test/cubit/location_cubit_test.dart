import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/failures/location_failure.dart';
import 'package:location_tracking/src/domain/repositories/location_repository.dart';
import 'package:location_tracking/src/presentation/cubit/location_cubit.dart';
import 'package:location_tracking/src/presentation/cubit/location_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'location_cubit_test.mocks.dart';

@GenerateMocks([LocationRepository])
void main() {
  late MockLocationRepository mockRepository;
  late LocationCubit cubit;

  setUp(() {
    mockRepository = MockLocationRepository();
    cubit = LocationCubit(mockRepository);
  });

  const tLocation = LocationEntity(
    latitude: 0,
    longitude: 0,
  );

  group('LocationCubit', () {
    test('initial state is LocationState()', () {
      expect(cubit.state, const LocationState());
    });

    blocTest<LocationCubit, LocationState>(
      'emits [loading, success] when getCurrentLocation succeeds',
      build: () {
        when(
          mockRepository.getCurrentLocation(),
        ).thenAnswer((_) async => Result.success(tLocation));
        return cubit;
      },
      act: (cubit) => cubit.getCurrentLocation(),
      expect: () => [
        const LocationState(status: LocationStatus.loading),
        const LocationState(
          status: LocationStatus.success,
          currentLocation: tLocation,
        ),
      ],
    );

    blocTest<LocationCubit, LocationState>(
      'emits [loading, failure] when getCurrentLocation fails',
      build: () {
        when(mockRepository.getCurrentLocation()).thenAnswer(
          (_) async => Result.failure(const LocationFailure('Error')),
        );
        return cubit;
      },
      act: (cubit) => cubit.getCurrentLocation(),
      expect: () => [
        const LocationState(status: LocationStatus.loading),
        const LocationState(
          status: LocationStatus.failure,
          errorMessage: 'Error',
        ),
      ],
    );

    test('calculateDistance returns 0 when currentLocation is null', () {
      expect(cubit.calculateDistance(tLocation), 0);
    });

    test('calculateDistance calls repository when currentLocation is set', () {
      // Arrange
      cubit.emit(
        const LocationState(
          status: LocationStatus.success,
          currentLocation: tLocation,
        ),
      );
      when(mockRepository.calculateDistance(any, any)).thenReturn(100);

      // Act
      final result = cubit.calculateDistance(tLocation);

      // Assert
      expect(result, 100.0);
      verify(mockRepository.calculateDistance(tLocation, tLocation)).called(1);
    });
  });
}
