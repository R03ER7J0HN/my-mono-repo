# Location Tracking Package

A module dedicated to handling geolocation services and map visualizations.

> ⚠️ **Work in Progress**: This package is under active development.

## ✨ Current Features

### Geolocation Services
- Get current device position
- Location permission handling
- Location entity with latitude/longitude

### Google Maps Integration
- Google Maps Flutter widget support
- Place autocomplete with Google Places API
- Address to coordinates conversion

### Places API
- Address search/autocomplete
- Place details retrieval
- Place predictions

## 🏗️ Architecture

This package follows **Clean Architecture** with a Domain-Data split:

| Layer | Component | Role |
|-------|-----------|------|
| **Domain** | `LocationRepository` | Abstract interface for location operations |
| **Domain** | `PlacesRepository` | Abstract interface for Places API |
| **Domain** | `LocationEntity` | Coordinates representation (lat, long) |
| **Domain** | `PlacePrediction` | Place autocomplete suggestion |
| **Data** | `GeolocatorDataSource` | Device location via Geolocator plugin |
| **Data** | `PlacesRemoteDataSource` | Google Places API (Retrofit) |

## 📦 Installation

```yaml
dependencies:
  location_tracking:
    path: ../packages/location_tracking
```

Configure platform permissions:
- **Android**: Add location permissions to `AndroidManifest.xml`
- **iOS**: Add location usage descriptions to `Info.plist`

## 💡 Usage

### Initialization

```dart
void main() {
  LocationTracking.initialize(GetIt.I);
}
```

### Fetching Current Location

```dart
class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this._repository) : super(LocationState.initial());

  final LocationRepository _repository;

  Future<void> getCurrentLocation() async {
    final result = await _repository.getCurrentPosition();
    result.fold(
      onFailure: (failure) => emit(LocationState.error(failure)),
      onSuccess: (location) => emit(LocationState.loaded(location)),
    );
  }
}
```

### Place Autocomplete

```dart
Future<void> searchPlaces(String query) async {
  final result = await _placesRepository.searchPlaces(query);
  result.fold(
    onFailure: (failure) => emit(state.copyWith(error: failure)),
    onSuccess: (predictions) => emit(state.copyWith(predictions: predictions)),
  );
}
```

## 🧪 Testing

```dart
class MockLocationRepo extends Mock implements LocationRepository {}

void main() {
  test('LocationCubit emits loaded when position is found', () async {
    final mockRepo = MockLocationRepo();
    when(mockRepo.getCurrentPosition())
        .thenAnswer((_) async => Result.success(testLocation));
    // ... assert Cubit state
  });
}
```
