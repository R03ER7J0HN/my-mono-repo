# Firebase Notification Package

A pragmatic, feature-sliced package for handling **Remote Push Notifications** using Firebase Cloud Messaging (FCM).

## Architecture: Pragmatic Clean Architecture

This package follows a **Domain-Data split** architecture, designed to be modular, testable, and strictly separated from the presentation layer.

### Key Concepts

1.  **Remote vs. Local Separation:**
    - This package is responsible **ONLY** for the **Remote** data source (fetching data from Firebase).
    - It is **NOT** responsible for displaying local notifications (banners, sounds, vibrations). That is the responsibility of the consuming application (Presentation Layer).

2.  **Repository Pattern:**
    - We use `NotificationRepository` as the abstraction. This treats notifications as a data source that provides a stream of events, rather than a "service" that performs actions.

### Layering

| Layer      | Component                        | Role                                                                                                                     |
| :--------- | :------------------------------- | :----------------------------------------------------------------------------------------------------------------------- |
| **Domain** | `NotificationRepository`         | **(Abstract Interface)** The contract that the app depends on. Defines _what_ we can do (get token, listen to messages). |
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

Inject the `NotificationRepository` into your Cubit. Do not depend on the concrete implementation.

```dart
class AppCubit extends Cubit<AppState> {
  final NotificationRepository _notificationRepository;
  final LocalNotificationService _localNotificationService; // Your app's local handler

  AppCubit({
    required NotificationRepository notificationRepository,
    required LocalNotificationService localNotificationService,
  })  : _notificationRepository = notificationRepository,
        _localNotificationService = localNotificationService,
        super(AppState.initial()) {
    _initNotifications();
  }

  void _initNotifications() {
    // Listen to remote data
    _notificationRepository.onMessage.listen((notification) {
      // Decide how to present it locally
      if (notification.title != null) {
        _localNotificationService.showNotification(
          title: notification.title!,
          body: notification.body!
        );
      }
    });
  }
}
```

## Testing

This architecture makes testing easy. You can mock `NotificationRepository` to simulate incoming notifications without needing a real Firebase connection.

```dart
// Mocking in tests
class MockNotificationRepository extends Mock implements NotificationRepository {}

void main() {
  test('AppCubit handles incoming notification', () {
    final mockRepo = MockNotificationRepository();
    when(mockRepo.onMessage).thenAnswer((_) => Stream.value(
      Notification(title: 'Test', body: 'Body')
    ));

    // ... assert that AppCubit reacts correctly
  });
}
```

## 🚀 Highlights

- **Pragmatic Clean Architecture**: Demonstrates a clear separation of Domain and Data layers.
- **Repository Pattern**: Abstracts the data source (`firebase_messaging`) behind a clean interface (`NotificationRepository`).
- **Stream-Based Architecture**: Treats notifications as a reactive stream of events.
- **Testability**: Designed with dependency injection in mind, allowing for easy mocking of remote services.
