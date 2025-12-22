/// Represents the status of location permission.
enum LocationPermissionStatus {
  denied,
  deniedForever,
  whileInUse,
  always,
  unableToDetermine
  ;

  /// Whether permission is granted (whileInUse or always).
  bool get isGranted => this == whileInUse || this == always;

  /// Whether permission is denied but can still be requested.
  bool get isDenied => this == denied;

  /// Whether permission is permanently denied.
  bool get isDeniedForever => this == deniedForever;
}
