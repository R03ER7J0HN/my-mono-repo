import 'package:flutter_core/flutter_core.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/entities/location_permission_status.dart';
import 'package:location_tracking/src/domain/entities/location_result.dart';

/// Repository for location-related operations.
abstract class LocationRepository {
  /// Gets current location, handling permissions automatically.
  ///
  /// Returns:
  /// - [LocationSuccess] if location was retrieved
  /// - [LocationPermissionRequired] if permission is denied/deniedForever
  /// - [LocationServiceDisabled] if location services are off
  /// - [LocationError] for other failures
  Future<LocationResult> getCurrentLocationWithPermission();

  /// Gets current location (assumes permission is already granted).
  FutureResult<LocationEntity> getCurrentLocation();

  /// Stream of location updates.
  Stream<LocationEntity> getLocationStream();

  /// Checks current permission status without requesting.
  FutureResult<LocationPermissionStatus> checkPermission();

  /// Opens app settings (for deniedForever cases).
  Future<bool> openAppSettings();

  /// Opens location settings (for disabled service cases).
  Future<bool> openLocationSettings();

  /// Calculates distance between two points in meters.
  double calculateDistance(LocationEntity start, LocationEntity end);
}
