# Copilot Instructions

## Project Overview

Flutter monorepo (Dart SDK ^3.9.0) managed by **Melos** for a job application tracker. Uses **Clean Architecture + MVVM**, **Cubit** for state management, and **Firebase** for backend.

## Architecture

### Package Structure

- **`apps/job_application_tracker/`** — Main Flutter app with features, routing, theming
- **`packages/flutter_core`** — Core utilities: `Result<T>`, `Failure`, `SafeEmitMixin`, extensions
- **`packages/authentication`** — Firebase Auth with `AuthenticationRepository`
- **`packages/job_application`** — Job entities, repository contracts, Firestore implementation
- **`packages/notification`, `packages/location_tracking`** — Feature-specific packages

### Feature Module Pattern

```
apps/*/lib/features/<feature>/
├── cubit/<feature>_cubit.dart, <feature>_state.dart
├── widgets/                     # Private widgets prefixed with _
├── l10n/<feature>_en.arb        # Localization
└── <feature>_screen.dart        # Entry widget with BlocProvider
```

### Domain Package Pattern

```
packages/<package>/lib/src/
├── domain/entities/             # Immutable Equatable/freezed entities
├── domain/repositories/         # Abstract contracts (FutureResult<T>)
├── data/datasources/            # Retrofit for HTTP, concrete for others
├── data/models/                 # JSON models with toEntity()
└── data/repositories/           # Converts models → entities
```

### Model vs Entity (Composition Pattern)

**Entities** (Domain layer):

- Immutable data classes using `Equatable` or `freezed`
- Zero knowledge of JSON, APIs, or data sources
- Consumed by presentation layer

**Models** (Data layer):

- Handle serialization with `@JsonSerializable`
- Use **composition, NOT inheritance** — models do NOT extend entities
- Must have `toEntity()` method to convert to domain entity
- Optionally have `fromEntity()` factory for write operations
- Use `Equatable` for test equality matching with mocks
- Use `createToJson: false` for read-only models (API responses)
- Add extension methods for collection conversions (e.g., `toEntityList()`)

```dart
// ✅ CORRECT: Composition pattern with best practices
@JsonSerializable(createToJson: false)  // Read-only model
class PlacePredictionModel extends Equatable {
  const PlacePredictionModel({required this.placeId, required this.description});

  factory PlacePredictionModel.fromJson(Map<String, dynamic> json) => ...;

  @JsonKey(name: 'place_id')
  final String placeId;
  final String description;

  PlacePrediction toEntity() => PlacePrediction(placeId: placeId, description: description);

  @override
  List<Object?> get props => [placeId, description];
}

// Extension for collection conversion
extension PlacePredictionModelListExt on List<PlacePredictionModel> {
  List<PlacePrediction> toEntityList() => map((m) => m.toEntity()).toList();
}

// ❌ WRONG: Inheritance pattern (tight coupling)
class UserModel extends UserEntity { ... }
```

### Data Source Patterns

**HTTP APIs** — Use Retrofit abstract class:

```dart
@RestApi(baseUrl: 'https://api.example.com')
abstract class PlacesRemoteDataSource {
  factory PlacesRemoteDataSource(Dio dio) = _PlacesRemoteDataSource;

  @GET('/search')
  Future<SearchResponse> search(@Query('q') String query);
}
```

**Platform APIs** — Use concrete classes (no interface needed):

```dart
class GeolocatorDataSource {
  Future<Position> getCurrentPosition() => Geolocator.getCurrentPosition();
}
```

**Local Storage** — Use concrete classes:

```dart
class LocalDataSource {
  const LocalDataSource(this._secureStorage);
  Future<UserModel?> getLastSignedInUser() async { ... }
}
```

### Exception Handling Pattern

Use the base `ExceptionHandler` mixin from `flutter_core` for consistent error handling. Extend it with package-specific handlers using mixin composition:

**Base handler** (in `flutter_core`):

```dart
mixin ExceptionHandler {
  Failure? mapException(Object error) => null; // Override for custom mapping

  FutureResult<T> handleException<R, T>(
    Future<R> execute, {
    required FutureOr<T> Function(R response) onSuccess,
  }) async {
    try {
      return Result.success(await onSuccess(await execute));
    } on DioException catch (e) {
      return Result.failure(mapException(e) ?? _mapDioException(e));
    } on Exception catch (e) {
      return Result.failure(mapException(e) ?? GenericFailure(kGenericErrorMessage));
    }
  }
}
```

**Package-specific handler** (extends base):

```dart
mixin FirebaseAuthExceptionHandler on ExceptionHandler {
  @override
  Failure? mapException(Object error) {
    if (error is FirebaseAuthException) {
      return _mapAuthError(error);  // Custom mapping
    }
    return super.mapException(error);
  }
}
```

**Repository usage** (compose both mixins):

```dart
class FirebaseAuthRepositoryImpl
    with ExceptionHandler, FirebaseAuthExceptionHandler
    implements AuthenticationRepository {

  @override
  FutureResult<UserEntity> signIn({required String email, required String password}) {
    return handleException(
      _firebaseAuth.signInWithEmailAndPassword(email: email, password: password),
      onSuccess: (credential) => credential.user!.toEntity(),
    );
  }
}
```

### Repository Implementation

Repositories convert models to entities and use `handleException`:

```dart
class PlacesRepositoryImpl with ExceptionHandler implements PlacesRepository {
  PlacesRepositoryImpl({required PlacesRemoteDataSource dataSource, required String apiKey});

  @override
  FutureResult<List<PlacePrediction>> searchPlaces(String query) {
    return handleException(
      _dataSource.searchPlaces(query, _apiKey),
      onSuccess: (response) => response.toEntityList(),  // Use extension method
    );
  }
}
```

### Data Sources vs Repositories

- **Data sources** — Internal to package, return Models. Mockable via `@GenerateMocks`.
- **Repositories** — Exposed to consumers, return Entities wrapped in `Result<T>`.

## Critical Patterns

### Result & Failure Types

All failable operations use `FutureResult<T>` (alias for `Future<Result<T>>`):

```dart
// Repository contract
FutureResult<String> createJob(JobApplicationEntity job);

// Handling results
result.fold(
  onFailure: (failure) => safeEmit(state.copyWith(error: failure.message)),
  onSuccess: (data) => safeEmit(state.copyWith(data: data)),
);
```

**Failure hierarchy** (in `flutter_core`):

- `Failure` — Abstract base class with `message` property
- `FirebaseFailure` — Firebase errors (`.notLoggedIn()`, `.userNotFound()`)
- `DioFailure` — HTTP/API errors
- `FormatFailure` — JSON/parsing errors
- `GenericFailure` — Fallback for unexpected errors
- `CancellationFailure` — User-cancelled operations

### State Management (Cubit)

- **One Cubit per screen** — Created in Screen's `BlocProvider`
- Use `SafeEmitMixin` to prevent emitting after close
- Use `freezed` for immutable state: flat properties for simple screens, sealed unions for complex states

### Dependency Injection

- Packages expose `static void initialize(GetIt instance)` method
- Registration in `apps/*/lib/application/di/injector.dart`
- Access via `GetIt.I<RepositoryType>()` in Screen widgets only

## Key Commands

```bash
melos bootstrap                      # Bootstrap workspace
melos run test                       # Run all tests
flutter run apps/job_application_tracker
```

### Code Generation

Run build_runner **only for the specific package** you modified to reduce build time:

```bash
# From the specific package directory (preferred for single-package changes)
cd packages/<package_name> && dart run build_runner build --delete-conflicting-outputs

# Or run for all packages (only when multiple packages need regeneration)
melos run build-files --no-select
```

## Code Quality

- **Linting**: `very_good_analysis` with `always_use_package_imports: true`
- **Formatter**: 80-character page width
- **Testing**: `mockito` with `@GenerateMocks`, >90% coverage for Cubits/repositories

## Localization

Each feature has `l10n/<feature>_en.arb`. To migrate hardcoded strings:

1. Add key to ARB: `{"screenTitle": "Title"}`
2. Run: `cd apps/job_application_tracker && ./generate_localizations.sh`
3. Use: `AuthLocalizations.of(context).screenTitle`
4. Register delegate in `main.dart`'s `localizationsDelegates`

For new features: add feature name to `FEATURES` array in `generate_localizations.sh`

## Routing

Routes defined as enum in `lib/router/app_routes.dart`:

- Navigate: `context.goNamed(AppRoutes.home.name)`
- Pass data: `context.pushNamed(AppRoutes.jobEntry.name, extra: job)`
- Auth redirects handled in `AppRouter._redirectHandler` based on `AppCubit.state.status`

---

## AI Agent Guidelines

### Core Workflow

1. **Plan** — Present a concise plan before any file creation/modification
2. **Explain** — Use unified diff format for modifications; document assumptions
3. **Await approval** — Request explicit approval before executing
4. **Execute completely** — Complete all steps without re-prompting unless the plan fails

### Communication

- Professional, concise, clear, transparent
- Ask for confirmation on ambiguous decisions with succinct options

### Development Standards

- **Architecture**: Strict Clean Architecture (`data` → `domain` ← `presentation`)
- **Domain layer**: Zero Flutter/external dependencies
- **Code style**: `very_good_analysis` linting, zero warnings, immutable state/entities (`freezed`)
- **Testing**: Unit tests for Cubits/repositories (>90% coverage), widget tests for screens

### Self-Review Checklist

1. Did I understand the "why" before coding?
2. Did I consider alternatives and trade-offs?
3. Do changes align with Clean Architecture?
4. Did I avoid tight coupling between layers?
5. Did I test behavior, edge cases, and error states?
6. Are any hacks marked with `// TODO:` comments?
