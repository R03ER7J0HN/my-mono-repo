# Firebase Notification Package

A pragmatic, feature-sliced package for handling **Remote Push Notifications** using Firebase Cloud Messaging (FCM).

## Architecture: Pragmatic Clean Architecture

This package follows a **Domain-Data split** architecture, designed to be modular, testable, and strictly separated from the presentation layer.

### Key Concepts

1.  **Remote vs. Local Separation:**

    - This package is responsible **ONLY** for the **Remote** data source (fetching data from Firebase).
    - It is **NOT** responsible for displaying local notifications (banners, sounds, vibrations). That is the responsibility of the consuming application (Presentation Layer).

2.  **Repository Pattern:**
    - We use `RemoteNotificationRepository` as the abstraction. This treats notifications as a data source that provides a stream of events, rather than a "service" that performs actions.

### Layering

| Layer      | Component                        | Role                                                                                                                     |
| :--------- | :------------------------------- | :----------------------------------------------------------------------------------------------------------------------- |
| **Domain** | `RemoteNotificationRepository`   | **(Abstract Interface)** The contract that the app depends on. Defines _what_ we can do (get token, listen to messages). |
| **Domain** | `Notification`                   | **(Entity)** A pure, immutable Dart object representing a notification. Decoupled from Firebase's `RemoteMessage`.       |
| **Data**   | `FirebaseNotificationRepository` | **(Implementation)** The concrete class that talks to `firebase_messaging`. It maps raw data to Domain Entities.         |

## Installation

1.  Add the dependency to your `pubspec.yaml`.
2.  Ensure you have configured Firebase for your Android and iOS apps.

## Usage

### 1. Initialization

Initialize the package in your `main.dart`. This registers the repository with `GetIt`.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize this package
  FirebaseNotification.initialize(GetIt.instance);

  runApp(const MyApp());
}
```

### 2. Consuming in the App Layer (e.g., Cubit)

Inject the `RemoteNotificationRepository` into your Cubit. Do not depend on the concrete implementation.

```dart
class AppCubit extends Cubit<AppState> {
  final RemoteNotificationRepository _remoteRepository;
  final LocalNotificationService _localService; // Your app's local handler

  AppCubit({
    required RemoteNotificationRepository remoteRepository,
    required LocalNotificationService localService,
  })  : _remoteRepository = remoteRepository,
        _localService = localService,
        super(AppState.initial()) {
    _initNotifications();
  }

  void _initNotifications() {
    // Listen to remote data
    _remoteRepository.onMessage.listen((notification) {
      // Decide how to present it locally
      if (notification.title != null) {
        _localService.showNotification(
          title: notification.title!,
          body: notification.body!
        );
      }
    });
  }
}
```

## Testing

This architecture makes testing easy. You can mock `RemoteNotificationRepository` to simulate incoming notifications without needing a real Firebase connection.

```dart
// Mocking in tests
class MockRemoteNotificationRepository extends Mock implements RemoteNotificationRepository {}

void main() {
  test('AppCubit handles incoming notification', () {
    final mockRepo = MockRemoteNotificationRepository();
    when(mockRepo.onMessage).thenAnswer((_) => Stream.value(
      Notification(title: 'Test', body: 'Body')
    ));

    // ... assert that AppCubit reacts correctly
  });
}
```
