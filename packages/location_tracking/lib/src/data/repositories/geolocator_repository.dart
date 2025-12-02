import 'package:flutter_core/flutter_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracking/src/data/datasources/geolocator_data_source.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';
import 'package:location_tracking/src/domain/entities/location_permission_status.dart';
import 'package:location_tracking/src/domain/failures/location_failure.dart';
import 'package:location_tracking/src/domain/repositories/location_repository.dart';

class GeolocatorRepository implements LocationRepository {
  const GeolocatorRepository(this._dataSource);

  final GeolocatorDataSource _dataSource;

  @override
  FutureResult<LocationEntity> getCurrentLocation() async {
    try {
      LocationPermission permission;

      final serviceEnabled = await _dataSource.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Result.failure(
          const LocationFailure('Location services are disabled.'),
        );
      }

      permission = await _dataSource.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await _dataSource.requestPermission();
        if (permission == LocationPermission.denied) {
          return Result.failure(
            const LocationFailure('Location permissions are denied'),
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Result.failure(
          const LocationFailure(
            '''
Location permissions are permanently denied, we cannot request permissions.''',
          ),
        );
      }

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
  FutureResult<LocationPermissionStatus> requestPermission() async {
    try {
      final permission = await _dataSource.requestPermission();
      return Result.success(_mapPermission(permission));
    } on Exception catch (e) {
      return Result.failure(LocationFailure(e.toString()));
    }
  }

  @override
  FutureResult<bool> openAppSettings() async {
    try {
      final result = await _dataSource.openAppSettings();
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(LocationFailure(e.toString()));
    }
  }

  @override
  FutureResult<bool> openLocationSettings() async {
    try {
      final result = await _dataSource.openLocationSettings();
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(LocationFailure(e.toString()));
    }
  }

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
