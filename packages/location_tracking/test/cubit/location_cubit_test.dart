import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/entities/location_permission_status.dart';
import 'package:location_tracking/src/domain/entities/location_result.dart';
import 'package:location_tracking/src/domain/failures/location_failure.dart';
import 'package:location_tracking/src/domain/repositories/location_repository.dart';
import 'package:location_tracking/src/presentation/location_picker/cubit/location_picker_cubit.dart';
import 'package:location_tracking/src/presentation/location_picker/cubit/location_picker_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'location_cubit_test.mocks.dart';

@GenerateMocks([LocationRepository])
void main() {
  late MockLocationRepository mockRepository;
  late LocationPickerCubit cubit;

  setUpAll(() {
    // Provide dummy values for sealed classes that Mockito can't generate
    provideDummy<LocationResult>(const LocationServiceDisabled());
  });

  setUp(() {
    mockRepository = MockLocationRepository();
    cubit = LocationPickerCubit(mockRepository);
  });

  const tLocation = LocationEntity(
    latitude: 0,
    longitude: 0,
  );

  group('LocationPickerCubit', () {
    test('initial state is LocationState()', () {
      expect(cubit.state, const LocationPickerState.initial());
    });

    group('initialize', () {
      blocTest<LocationPickerCubit, LocationPickerState>(
        'emits [loading, success] when location is retrieved successfully',
        build: () {
          when(
            mockRepository.getCurrentLocationWithPermission(),
          ).thenAnswer((_) async => const LocationSuccess(tLocation));
          return cubit;
        },
        act: (cubit) => cubit.initialize(),
        expect: () => [
          const LocationPickerState.loading(),
          const LocationPickerState.success(
            currentLocation: tLocation,
          ),
        ],
      );

      blocTest<LocationPickerCubit, LocationPickerState>(
        'emits [loading, permissionDenied] when permission is denied',
        build: () {
          when(mockRepository.getCurrentLocationWithPermission()).thenAnswer(
            (_) async => const LocationPermissionRequired(
              LocationPermissionStatus.denied,
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.initialize(),
        expect: () => [
          const LocationPickerState.loading(),
          const LocationPickerState.permissionDenied(
            permissionStatus: LocationPermissionStatus.denied,
            errorMessage:
                'Location permission is required to use this feature.',
          ),
        ],
      );

      blocTest<LocationPickerCubit, LocationPickerState>(
        'emits [loading, permissionDenied] with settings message '
        'when permission is denied forever',
        build: () {
          when(mockRepository.getCurrentLocationWithPermission()).thenAnswer(
            (_) async => const LocationPermissionRequired(
              LocationPermissionStatus.deniedForever,
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.initialize(),
        expect: () => [
          const LocationPickerState.loading(),
          const LocationPickerState.permissionDenied(
            permissionStatus: LocationPermissionStatus.deniedForever,
            errorMessage:
                'Location permission is permanently denied. '
                'Please enable it in settings.',
          ),
        ],
      );

      blocTest<LocationPickerCubit, LocationPickerState>(
        'emits [loading, serviceDisabled] when location service is disabled',
        build: () {
          when(
            mockRepository.getCurrentLocationWithPermission(),
          ).thenAnswer((_) async => const LocationServiceDisabled());
          return cubit;
        },
        act: (cubit) => cubit.initialize(),
        expect: () => [
          const LocationPickerState.loading(),
          const LocationPickerState.serviceDisabled(
            errorMessage: 'Location services are disabled. Please enable them.',
          ),
        ],
      );

      blocTest<LocationPickerCubit, LocationPickerState>(
        'emits [loading, failure] when an error occurs',
        build: () {
          when(
            mockRepository.getCurrentLocationWithPermission(),
          ).thenAnswer((_) async => const LocationError('Network error'));
          return cubit;
        },
        act: (cubit) => cubit.initialize(),
        expect: () => [
          const LocationPickerState.loading(),
          const LocationPickerState.failure(
            errorMessage: 'Network error',
          ),
        ],
      );
    });

    group('refreshLocation', () {
      blocTest<LocationPickerCubit, LocationPickerState>(
        'emits [loading, success] when getCurrentLocation succeeds',
        build: () {
          when(
            mockRepository.getCurrentLocation(),
          ).thenAnswer((_) async => Result.success(tLocation));
          return cubit;
        },
        act: (cubit) => cubit.refreshLocation(),
        expect: () => [
          const LocationPickerState.loading(),
          const LocationPickerState.success(
            currentLocation: tLocation,
          ),
        ],
      );

      blocTest<LocationPickerCubit, LocationPickerState>(
        'emits [loading, failure] when getCurrentLocation fails',
        build: () {
          when(mockRepository.getCurrentLocation()).thenAnswer(
            (_) async => Result.failure(const LocationFailure('Error')),
          );
          return cubit;
        },
        act: (cubit) => cubit.refreshLocation(),
        expect: () => [
          const LocationPickerState.loading(),
          const LocationPickerState.failure(
            errorMessage: 'Error',
          ),
        ],
      );
    });

    group('calculateDistance', () {
      test('returns 0 when currentLocation is null', () {
        expect(cubit.calculateDistance(tLocation), 0);
      });

      test('calls repository when currentLocation is set', () {
        // Arrange
        cubit.emit(
          const LocationPickerState.success(
            currentLocation: tLocation,
          ),
        );
        when(mockRepository.calculateDistance(any, any)).thenReturn(100);

        // Act
        final result = cubit.calculateDistance(tLocation);

        // Assert
        expect(result, 100.0);
        verify(
          mockRepository.calculateDistance(tLocation, tLocation),
        ).called(1);
      });
    });
  });
}
