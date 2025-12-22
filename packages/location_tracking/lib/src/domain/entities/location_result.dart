import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/entities/location_permission_status.dart';

/// Result of attempting to get location with permission handling.
///
/// This sealed class represents all possible outcomes when requesting
/// the user's location, including permission and service states.
sealed class LocationResult {
  const LocationResult();
}

/// Location was successfully retrieved.
class LocationSuccess extends LocationResult {
  const LocationSuccess(this.location);

  final LocationEntity location;
}

/// Permission is required to access location.
///
/// Contains the current permission status which can be used to determine
/// whether to show a permission request dialog or direct to settings.
class LocationPermissionRequired extends LocationResult {
  const LocationPermissionRequired(this.status);

  final LocationPermissionStatus status;
}

/// Location services are disabled on the device.
class LocationServiceDisabled extends LocationResult {
  const LocationServiceDisabled();
}

/// An error occurred while getting the location.
class LocationError extends LocationResult {
  const LocationError(this.message);

  final String message;
}
