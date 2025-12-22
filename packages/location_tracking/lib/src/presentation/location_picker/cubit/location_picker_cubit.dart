import 'package:flutter_core/flutter_core.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/entities/location_result.dart';
import 'package:location_tracking/src/domain/repositories/location_repository.dart';
import 'package:location_tracking/src/presentation/location_picker/cubit/location_picker_state.dart';

class LocationPickerCubit extends Cubit<LocationPickerState>
    with SafeEmitMixin {
  LocationPickerCubit(this._repository)
    : super(const LocationPickerState.initial());

  final LocationRepository _repository;

  Future<void> initialize() async {
    safeEmit(const LocationPickerState.loading());

    final result = await _repository.getCurrentLocationWithPermission();

    switch (result) {
      case LocationSuccess(:final location):
        safeEmit(
          LocationPickerState.success(currentLocation: location),
        );

      case LocationPermissionRequired(:final status):
        final message = status.isDeniedForever
            ? 'Location permission is permanently denied. '
                  'Please enable it in settings.'
            : 'Location permission is required to use this feature.';

        safeEmit(
          LocationPickerState.permissionDenied(
            permissionStatus: status,
            errorMessage: message,
          ),
        );

      case LocationServiceDisabled():
        safeEmit(
          const LocationPickerState.serviceDisabled(
            errorMessage: 'Location services are disabled. Please enable them.',
          ),
        );

      case LocationError(:final message):
        safeEmit(
          LocationPickerState.failure(errorMessage: message),
        );
    }
  }

  /// Refreshes the current location (assumes permission is already granted).
  Future<void> refreshLocation() async {
    safeEmit(const LocationPickerState.loading());

    final result = await _repository.getCurrentLocation();

    result.fold(
      onFailure: (Failure failure) {
        safeEmit(
          LocationPickerState.failure(errorMessage: failure.message),
        );
      },
      onSuccess: (LocationEntity location) {
        safeEmit(
          LocationPickerState.success(currentLocation: location),
        );
      },
    );
  }

  /// Opens app settings for the user to enable location permission.
  Future<void> openAppSettings() => _repository.openAppSettings();

  /// Opens device location settings for the user to enable location services.
  Future<void> openLocationSettings() => _repository.openLocationSettings();

  /// Calculates the distance from the current location to a target location.
  double calculateDistance(LocationEntity target) {
    return state.maybeWhen(
      success: (currentLocation) {
        return _repository.calculateDistance(currentLocation, target);
      },
      orElse: () => 0,
    );
  }
}
