# Authentication Package

A reusable, secure authentication module for the Job Application Tracker workspace.

> ⚠️ **Work in Progress**: This package is under active development.

## ✨ Current Features

### Authentication Operations
- Email/password sign-in
- Email/password sign-up
- Password reset via email
- Sign out
- Auth state stream (real-time user status)

### Security
- Secure token storage with `flutter_secure_storage`
- Persistent auth state across app restarts

### User Entity
- Immutable user representation
- User ID, email, display name

## 🏗️ Architecture

This package follows **Clean Architecture** with a Domain-Data split:

| Layer | Component | Role |
|-------|-----------|------|
| **Domain** | `AuthenticationRepository` | Abstract interface for auth operations |
| **Domain** | `UserEntity` | Immutable user representation |
| **Data** | `FirebaseAuthenticationRepository` | Firebase Auth implementation |
| **Data** | `SecureStorageDataSource` | Secure hardware storage for tokens |

## 📦 Installation

```yaml
dependencies:
  authentication:
    path: ../packages/authentication
```

Ensure `firebase_core` is initialized in your app.

## 💡 Usage

### Initialization

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuthentication.initialize(GetIt.I);
  runApp(const MyApp());
}
```

### Consuming in Cubit

```dart
class SignInCubit extends Cubit<SignInState> with SafeEmitMixin {
  SignInCubit(this._authRepository) : super(const SignInState.initial());

  final AuthenticationRepository _authRepository;

  Future<void> signIn(String email, String password) async {
    safeEmit(const SignInState.loading());

    final result = await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.fold(
      onFailure: (failure) => safeEmit(SignInState.failure(failure.message)),
      onSuccess: (_) => safeEmit(const SignInState.success()),
    );
  }
}
```

## 🧪 Testing

```dart
class MockAuthRepository extends Mock implements AuthenticationRepository {}

void main() {
  test('emits authenticated state when user logs in', () {
    final mockRepo = MockAuthRepository();
    when(mockRepo.user).thenAnswer((_) => Stream.value(User(id: '123')));
    // ... assert Cubit state
  });
}
```
