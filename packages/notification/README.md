# Notification Package

A package for handling **Remote Push Notifications** using Firebase Cloud Messaging (FCM).

> ⚠️ **Work in Progress**: This package is under active development.

## ✨ Current Features

### Firebase Cloud Messaging
- FCM token retrieval
- Foreground message stream
- Background message handling
- Notification permission requests

### Notification Entity
- Title and body content
- Data payload support
- Decoupled from Firebase `RemoteMessage`

## 🏗️ Architecture

This package follows **Clean Architecture** with a Domain-Data split:

| Layer | Component | Role |
|-------|-----------|------|
| **Domain** | `NotificationRepository` | Abstract interface for notification operations |
| **Domain** | `NotificationEntity` | Immutable notification representation |
| **Data** | `FirebaseNotificationRepository` | FCM implementation |

**Note**: This package handles **remote** notifications only. Local notification display (banners, sounds) is the responsibility of the consuming app.

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
      // Handle incoming notification
      if (notification.title != null) {
        // Show local notification or update UI
      }
    });
  }
}
```

### Getting FCM Token

```dart
Future<void> registerForNotifications() async {
  final result = await _notificationRepository.getToken();
  result.fold(
    onFailure: (failure) => print('Failed to get token'),
    onSuccess: (token) => print('FCM Token: $token'),
  );
}
```

## 🧪 Testing

```dart
class MockNotificationRepository extends Mock implements NotificationRepository {}

void main() {
  test('AppCubit handles incoming notification', () {
    final mockRepo = MockNotificationRepository();
    when(mockRepo.onMessage).thenAnswer((_) => Stream.value(
      NotificationEntity(title: 'Test', body: 'Body'),
    ));
    // ... assert Cubit state
  });
}
```
