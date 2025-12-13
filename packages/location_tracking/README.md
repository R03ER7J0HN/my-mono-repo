# Location Tracking Package

A module dedicated to handling geolocation services and map visualizations.

## Architecture: MVVM, Clean Architecture, Modular Monolith

This package follows a **Domain-Data split** architecture, designed to be modular, testable, and strictly separated from the presentation layer.

### Key Concepts

1.  **Abstraction of Hardware:**
    - The `Geolocator` package is wrapped behind a domain interface. This allows the app to request location data without knowing the underlying implementation details.
    - It simplifies testing by allowing location services to be mocked easily.

2.  **Presentation Isolation:**
    - Map widgets and logic are contained within this package, exposing high-level components to the main app rather than raw map controllers.

### Layering

| Layer | Component | Role |
| :--- | :--- | :--- |
| **Domain** | `LocationRepository` | **(Abstract Interface)** Contract for fetching current position and permission status. |
| **Domain** | `LocationEntity` | **(Entity)** Pure object representing coordinates (lat, long). |
| **Data** | `GeolocatorRepository` | **(Implementation)** Uses `geolocator` plugin to fetch device location. |
<!-- | **Presentation** | `MapView` | **(Widget)** A reusable widget that wraps `GoogleMap` and handles markers. | -->

## Installation

1.  Add the dependency to your `pubspec.yaml`.
2.  Configure AndroidManifest.xml and Info.plist for location permissions.

## Usage

### 1. Initialization

Register the repository.

```dart
void main() {
  LocationTracking.initialize(GetIt.I);
}
```

### 2. Fetching Location

```dart
class LocationCubit extends Cubit<LocationState> {
  final LocationRepository _repository;

  LocationCubit({required LocationRepository repository})
      : _repository = repository,
        super(LocationInitial());

  Future<void> checkLocation() async {
    final result = await _repository.getCurrentPosition();
    result.fold(
      (failure) => emit(LocationError(failure)),
      (location) => emit(LocationLoaded(location)),
    );
  }
}
```

<!-- ### 3. Using the Map Widget

```dart
class JobMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapView(
        initialPosition: const Location(lat: 37.77, long: -122.41),
        markers: _getJobMarkers(),
      ),
    );
  }
}
```

## Testing

You can test location logic without needing a physical device or emulator.

```dart
class MockLocationRepo extends Mock implements LocationRepository {}

void main() {
  test('LocationCubit emits loaded when position is found', () async {
    final mockRepo = MockLocationRepo();
    when(mockRepo.getCurrentPosition()).thenAnswer((_) async => Right(testLocation));
    
    // ... assert Cubit state
  });
}
``` -->

## 🚀 Highlights

- **Google Maps Integration**: Wraps `google_maps_flutter` to provide map views, markers, and camera control.
- **Geolocation Services**: Manages user permissions and retrieves real-time location updates using `geolocator`.
- **Modularity**: Isolates complex map logic from the main UI, making the codebase cleaner and the feature reusable.
- **Reactive Location Updates**: Exposes location data streams for real-time UI updates.
