import 'package:equatable/equatable.dart';
import 'package:location_tracking/src/domain/entities/location_entity.dart';

enum LocationStatus { initial, loading, success, failure }

class LocationState extends Equatable {
  const LocationState({
    this.status = LocationStatus.initial,
    this.currentLocation,
    this.errorMessage,
  });

  final LocationStatus status;
  final LocationEntity? currentLocation;
  final String? errorMessage;

  LocationState copyWith({
    LocationStatus? status,
    LocationEntity? currentLocation,
    String? errorMessage,
  }) {
    return LocationState(
      status: status ?? this.status,
      currentLocation: currentLocation ?? this.currentLocation,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, currentLocation, errorMessage];
}
