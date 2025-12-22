# Flutter Core Package

The foundational library for the monorepo, providing shared utilities, error handling, and base classes.

> ⚠️ **Work in Progress**: This package is under active development.

## ✨ Current Features

### Result Types
- `Result<T>` — Functional wrapper for success/failure outcomes
- `FutureResult<T>` — Async result type alias
- Pattern matching with `.fold()` for explicit error handling

### Failure Hierarchy
- `Failure` — Base class for all domain-level errors
- `FirebaseFailure` — Firebase-specific errors
- `DioFailure` — HTTP/API errors
- `FormatFailure` — JSON/parsing errors
- `GenericFailure` — Fallback for unexpected errors
- `CancellationFailure` — User-cancelled operations

### Exception Handling
- `ExceptionHandler` mixin — Standardized try-catch pattern with `handleException()`
- Extensible for package-specific error mapping

### Extensions
- `BuildContext` extensions (snackbars, navigation)
- `String` extensions (capitalize, validation)
- `DateTime` extensions

### Mixins
- `SafeEmitMixin` — Prevents Cubit emit after close

## 🏗️ Architecture

This package serves as the **Foundation Layer**, providing essential building blocks that all feature packages depend on.

| Component | Role |
|-----------|------|
| `Result<T>` | Type alias wrapping success/failure outcomes |
| `Failure` | Base class for domain-level errors |
| `ExceptionHandler` | Mixin for consistent error handling in repositories |
| `Extensions` | Shared utility methods for BuildContext, String, etc. |

## 📦 Installation

```yaml
dependencies:
  flutter_core:
    path: ../flutter_core
```

## 💡 Usage

### Handling Errors with Result

```dart
FutureResult<User> getUser() {
  return handleException(
    api.fetchUser(),
    onSuccess: (user) => user.toEntity(),
  );
}

// Consuming results
final result = await getUser();
result.fold(
  onFailure: (failure) => print('Error: ${failure.message}'),
  onSuccess: (user) => print('User: ${user.name}'),
);
```

### Using Extensions

```dart
// Context extensions
context.showSnackBar('Error!', type: SnackBarType.error);

// String extensions
final capitalized = 'hello'.capitalize();
```
