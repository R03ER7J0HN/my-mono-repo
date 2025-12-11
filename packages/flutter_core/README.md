# Flutter Core Package

The foundational library for the monorepo, providing shared utilities, networking clients, and base classes.

## Architecture: Foundation Layer

This package serves as the **Core Layer** of the application, providing essential building blocks that other feature packages depend on. It enforces consistency in error handling, networking, and coding standards.

### Key Concepts

1.  **Functional Error Handling:**
    - Leverages `fpdart` to replace exception-based control flow with **Result types** (`Either<Failure, T>`).
    - This ensures that errors are treated as values and must be handled explicitly by the consumer.

2.  **Standardized Failures:**
    - Defines a base `Failure` class hierarchy (e.g., `ServerFailure`, `CacheFailure`, `NetworkFailure`) to unify error reporting across the app.

### Components

| Component    | Role                                                                             |
| :----------- | :------------------------------------------------------------------------------- |
| `Result<T>`  | **(Type Alias)** A wrapper around `Either<Failure, T>` for concise return types. |
| `Failure`    | **(Base Class)** The parent class for all domain-level errors.                   |
| `Extensions` | **(Utils)** Shared extension methods for `BuildContext`, `String`, `Date`, etc.  |

## Installation

1.  Add the dependency to your `pubspec.yaml`.

```yaml
dependencies:
  flutter_core:
    path: ../flutter_core
```

## Usage

### 1. Handling Errors with `Result`

Instead of try-catch blocks, use functional pattern matching.

```dart
FutureResult<User> getUser() async {
  try {
    final user = await api.fetchUser();
    return Result.success(user);
  } catch (e) {
    return Result.failure(ServerFailure(message: e.toString()));
  }
}

void main() async {
  final result = await getUser();

  result.fold(
    (failure) => print('Error: ${failure.message}'),
    (user) => print('User: ${user.name}'),
  );
}
```

or use the api_response_handler.dart

```dart
FutureResult<User> getUser() {
  return handleApiResponse(
    getUser(),
    onSuccess: (user) => user.toEntity(),
  );
}

void main() async {
  final result = await getUser();

  result.fold(
    (failure) => print('Error: ${failure.message}'),
    (user) => print('User: ${user.name}'),
  );
}
```

### 2. Using Extensions

```dart
// Context extensions for showing snackbar
context.showSnackBar('This is an error!', type: SnackBarType.error);

// String extensions
final capitalized = 'hello'.capitalize();
```

## 🚀 Highlights

- **Functional Programming**: Leverages `fpdart` to introduce functional concepts like `Either` and `Option` for robust error handling and null safety.
- **Shared Utilities**: Contains reusable extensions and helper functions to reduce boilerplate in feature packages.
