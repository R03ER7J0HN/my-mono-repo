import 'package:flutter_core/flutter_core.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/entities/location_permission_status.dart';

abstract class LocationRepository {
  FutureResult<LocationEntity> getCurrentLocation();
  Stream<LocationEntity> getLocationStream();
  FutureResult<LocationPermissionStatus> checkPermission();
  FutureResult<LocationPermissionStatus> requestPermission();
  FutureResult<bool> openAppSettings();
  FutureResult<bool> openLocationSettings();
  double calculateDistance(LocationEntity start, LocationEntity end);
}
