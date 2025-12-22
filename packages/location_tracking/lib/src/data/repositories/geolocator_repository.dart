import 'package:flutter_core/flutter_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracking/src/data/datasources/geolocator_data_source.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/entities/location_permission_status.dart';
import 'package:location_tracking/src/domain/entities/location_result.dart';
import 'package:location_tracking/src/domain/failures/location_failure.dart';
import 'package:location_tracking/src/domain/repositories/location_repository.dart';

class GeolocatorRepository implements LocationRepository {
  const GeolocatorRepository(this._dataSource);

  final GeolocatorDataSource _dataSource;

  @override
  Future<LocationResult> getCurrentLocationWithPermission() async {
    try {
      final serviceEnabled = await _dataSource.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return const LocationServiceDisabled();
      }

      final permission = await _resolvePermission();

      final status = _mapPermission(permission);
      if (!status.isGranted) {
        return LocationPermissionRequired(status);
      }

      // Get location if permission is granted
      final position = await _dataSource.getCurrentPosition();
      return LocationSuccess(_mapPositionToEntity(position));
    } on Exception catch (e) {
      return LocationError(e.toString());
    }
  }

  Future<LocationPermission> _resolvePermission() async {
    final current = await _dataSource.checkPermission();

    if (current != LocationPermission.denied) {
      return current;
    }

    return _dataSource.requestPermission();
  }

  @override
  FutureResult<LocationEntity> getCurrentLocation() async {
    try {
      final position = await _dataSource.getCurrentPosition();
      return Result.success(_mapPositionToEntity(position));
    } on Exception catch (e) {
      return Result.failure(LocationFailure(e.toString()));
    }
  }

  @override
  Stream<LocationEntity> getLocationStream() {
    return _dataSource.getPositionStream().map(_mapPositionToEntity);
  }

  @override
  FutureResult<LocationPermissionStatus> checkPermission() async {
    try {
      final permission = await _dataSource.checkPermission();
      return Result.success(_mapPermission(permission));
    } on Exception catch (e) {
      return Result.failure(LocationFailure(e.toString()));
    }
  }

  @override
  Future<bool> openAppSettings() => _dataSource.openAppSettings();

  @override
  Future<bool> openLocationSettings() => _dataSource.openLocationSettings();

  @override
  double calculateDistance(LocationEntity start, LocationEntity end) {
    return _dataSource.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  LocationEntity _mapPositionToEntity(Position position) {
    return LocationEntity(
      latitude: position.latitude,
      longitude: position.longitude,
      accuracy: position.accuracy,
      altitude: position.altitude,
      speed: position.speed,
      speedAccuracy: position.speedAccuracy,
      heading: position.heading,
      timestamp: position.timestamp,
    );
  }

  LocationPermissionStatus _mapPermission(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.denied:
        return LocationPermissionStatus.denied;
      case LocationPermission.deniedForever:
        return LocationPermissionStatus.deniedForever;
      case LocationPermission.whileInUse:
        return LocationPermissionStatus.whileInUse;
      case LocationPermission.always:
        return LocationPermissionStatus.always;
      case LocationPermission.unableToDetermine:
        return LocationPermissionStatus.unableToDetermine;
    }
  }
}
