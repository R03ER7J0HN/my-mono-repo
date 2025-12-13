# Authentication Package

A reusable, secure authentication module for the Job Application Tracker workspace.

## Architecture: Pragmatic Clean Architecture

This package follows a **Domain-Data split** architecture, designed to be modular, testable, and strictly separated from the presentation layer.

### Key Concepts

1.  **Provider Agnostic:**
    - The domain layer defines *what* authentication operations are available (sign in, sign out, current user), but not *how* they are implemented.
    - This allows easily swapping Firebase for another provider (e.g., AWS Cognito, Auth0) without changing the app code.

2.  **Secure Storage:**
    - Sensitive data (like tokens) is persisted using `flutter_secure_storage`, ensuring security best practices are met on both Android and iOS.

### Layering

| Layer | Component | Role |
| :--- | :--- | :--- |
| **Domain** | `AuthenticationRepository` | **(Abstract Interface)** The contract for authentication actions (signIn, signOut, userStream). |
| **Domain** | `User` | **(Entity)** A pure, immutable Dart object representing the authenticated user. |
| **Data** | `FirebaseAuthenticationRepository` | **(Implementation)** The concrete class that interacts with `firebase_auth`. |
| **Data** | `SecureStorageDataSource` | **(Data Source)** Handles reading/writing sensitive data to the device's secure hardware. |

## Installation

1.  Add the dependency to your `pubspec.yaml`.
2.  Ensure `firebase_core` is initialized in your app.

## Usage

### 1. Initialization

Initialize the package in your `main.dart` and register dependencies.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Register repository
  FirebaseAuthentication.initialize(GetIt.I);

  runApp(const MyApp());
}
```

### 2. Consuming in the App Layer (e.g., Cubit)

Inject the `AuthenticationRepository` into your Bloc.

```dart
class SignInCubit extends Cubit<SignInState> {
   SignInCubit(this._authRepository) : super(const SignInState.initial());

  final AuthenticationRepository _authRepository;

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    safeEmit(const SignInState.loading());

    final result = await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.fold(
      onFailure: (failure) {
        safeEmit(
          SignInState.failure(failure.message),
        );
        safeEmit(const SignInState.initial());
      },
      onSuccess: (data) => safeEmit(const SignInState.success()),
    );
  }
}
```

## Testing

The clean architecture allows for easy mocking of the authentication flow.

```dart
class MockAuthRepository extends Mock implements AuthenticationRepository {}

void main() {
  test('emits authenticated state when user logs in', () {
    final mockRepo = MockAuthRepository();
    when(mockRepo.user).thenAnswer((_) => Stream.value(User(id: '123')));
    
    // ... assert Bloc state
  });
}
```

## 🚀 Highlights

- **Secure Storage**: Implements `flutter_secure_storage` to safely persist session tokens and sensitive user data.
- **Clean Architecture**: Decouples the `FirebaseAuth` implementation from the domain logic, allowing for easy swapping of auth providers or mocking in tests.
- **Unit Testing**: Includes comprehensive tests (`test/auth_local_data_source_test.dart`) to ensure reliability of the login/logout flows.
