# Notification Package

A package for handling **Remote Push Notifications** using Firebase Cloud Messaging (FCM).

## ✨ Features

- **FCM Token Retrieval** — Get device tokens for targeted push notifications
- **Foreground Message Stream** — React to notifications while app is active
- **Background Message Handling** — Process notifications when app is in background
- **Permission Management** — Request and handle notification permissions (iOS/Web)
- **Provider-Agnostic Entity** — `NotificationEntity` decoupled from Firebase internals

## 🏗️ Architecture

This package follows a **pragmatic Clean Architecture** approach — applying just enough abstraction to enable testability and future flexibility without over-engineering.

### Why Pragmatic?

Traditional Clean Architecture prescribes separate Data Sources, Models, and Repositories. For this package, we simplified:

| Traditional Approach | Our Pragmatic Approach | Rationale |
|---------------------|------------------------|-----------|
| `RemoteDataSource` + `Model` + `Repository` | `Repository` only | FCM SDK already handles data fetching; no HTTP layer to abstract |
| Separate `NotificationModel` | Direct mapping in repository | No JSON serialization needed; `RemoteMessage` → `Entity` is a simple transform |
| Multiple exception handlers | Single `FirebaseExceptionHandler` mixin | One external dependency = one handler |

### Package Structure

```
lib/
├── firebase_notification.dart      # Public API & DI registration
└── src/
    ├── notification_entity.dart            # Domain: Immutable notification representation
    ├── notification_repository.dart        # Domain: Abstract contract
    ├── firebase_notification_repository.dart  # Data: FCM implementation
    └── firebase_exception_handler.dart     # Data: Firebase error mapping
```

### Layer Responsibilities

| Layer | Component | Responsibility |
|-------|-----------|----------------|
| **Domain** | `NotificationRepository` | Abstract interface exposing streams and methods |
| **Domain** | `NotificationEntity` | Immutable, `Equatable` notification model |
| **Data** | `FirebaseNotificationRepository` | FCM implementation with `ExceptionHandler` mixin |
| **Data** | `FirebaseExceptionHandler` | Maps `FirebaseException` → `FirebaseFailure` |

### Key Patterns

- **Composition over Inheritance** — Repository uses mixins (`ExceptionHandler`, `FirebaseExceptionHandler`) for error handling
- **Result Type** — All fallible operations return `FutureResult<T>` for explicit error handling
- **Stream-based API** — Notifications delivered via `Stream<NotificationEntity>` for reactive consumption
- **Dependency Injection** — `FirebaseNotification.initialize(GetIt)` registers the repository

> **Note**: This package handles **remote** notifications only. Local notification display (banners, sounds, badges) is the responsibility of the consuming app.

## 📦 Installation

```yaml
dependencies:
  notification:
    path: ../packages/notification
```

Ensure Firebase is configured for your Android and iOS apps.

## 💡 Usage

### Initialization

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseNotification.initialize(GetIt.instance);
  runApp(const MyApp());
}
```

### Listening to Notifications

```dart
class AppCubit extends Cubit<AppState> {
  AppCubit(this._notificationRepository) : super(AppState.initial()) {
    _initNotifications();
  }

  final NotificationRepository _notificationRepository;

  void _initNotifications() {
    _notificationRepository.onMessage.listen((notification) {
      // Handle foreground notification
      if (notification.title != null) {
        // Show local notification or update UI
      }
    });

    _notificationRepository.onMessageOpenedApp.listen((notification) {
      // Handle notification tap (app opened from background/terminated)
      _navigateBasedOnPayload(notification.data);
    });
  }
}
```

### Getting FCM Token

```dart
Future<void> registerForNotifications() async {
  final result = await _notificationRepository.getToken();
  result.fold(
    onFailure: (failure) => print('Failed to get token: ${failure.message}'),
    onSuccess: (token) => sendTokenToBackend(token),
  );
}
```

### Requesting Permission

```dart
Future<void> setupNotifications() async {
  final result = await _notificationRepository.requestPermission();
  result.fold(
    onFailure: (failure) => showPermissionDeniedMessage(),
    onSuccess: (_) => registerForNotifications(),
  );
}
```

## 🧪 Testing

The abstract `NotificationRepository` enables easy mocking:

```dart
@GenerateMocks([NotificationRepository])
void main() {
  late MockNotificationRepository mockRepo;

  setUp(() {
    mockRepo = MockNotificationRepository();
  });

  test('AppCubit reacts to incoming notification', () {
    when(mockRepo.onMessage).thenAnswer(
      (_) => Stream.value(const NotificationEntity(title: 'Test', body: 'Body')),
    );
    when(mockRepo.onMessageOpenedApp).thenAnswer((_) => const Stream.empty());

    final cubit = AppCubit(mockRepo);
    // Assert cubit state updates based on notification
  });

  test('getToken returns FCM token on success', () async {
    when(mockRepo.getToken()).thenAnswer(
      (_) async => const Result.success('fake-fcm-token'),
    );

    final result = await mockRepo.getToken();
    expect(result.isSuccess, isTrue);
  });
}
```

## 🔮 Future Considerations

If requirements grow (e.g., multiple push providers, local caching), the architecture can evolve:

- Add `NotificationRemoteDataSource` abstraction if swapping FCM for another provider
- Introduce `NotificationModel` if notification payloads require complex JSON parsing
- Extend `NotificationEntity` with additional fields (e.g., `imageUrl`, `actionType`)
