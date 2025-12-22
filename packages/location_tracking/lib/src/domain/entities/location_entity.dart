import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  const LocationEntity({
    required this.latitude,
    required this.longitude,
    this.accuracy = 0.0,
    this.altitude = 0.0,
    this.speed = 0.0,
    this.speedAccuracy = 0.0,
    this.heading = 0.0,
    this.timestamp,
    this.address,
  });

  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double speed;
  final double speedAccuracy;
  final double heading;
  final DateTime? timestamp;
  final String? address;

  @override
  List<Object?> get props => [
    latitude,
    longitude,
    accuracy,
    altitude,
    speed,
    speedAccuracy,
    heading,
    timestamp,
  ];
}
