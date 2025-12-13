# Job Application Feature Package

A dedicated feature package responsible for the domain logic and data management of job applications.

## Architecture: Clean Architecture + Modular Monolith

This package follows a **Domain-Data split** architecture, designed to be modular, testable, and strictly separated from the presentation layer.

### Key Concepts

1.  **Domain-Driven Design (DDD):**
    - The business logic for job applications (e.g., validation, status transitions) is encapsulated within the Domain layer.
    - Entities are pure Dart objects, free from framework dependencies like Flutter or Firebase.

2.  **Real-time Synchronization:**
    - The repository exposes `Stream`s of data, allowing the UI to automatically update whenever the backend data changes (e.g., via Cloud Firestore).

### Layering

| Layer | Component | Role |
| :--- | :--- | :--- |
| **Domain** | `JobApplicationRepository` | **(Abstract Interface)** Defines operations for CRUD and real-time listening of applications. |
| **Domain** | `JobApplicationEntity` | **(Entity)** Immutable data class representing a job application. |
| **Data** | `FirestoreJobApplicationRepository` | **(Implementation)** Concrete implementation using Cloud Firestore. |
| **Data** | `JobApplicationModel` | **(DTO)** Data Transfer Object for serializing/deserializing Firestore documents. |

## Installation

1.  Add the dependency to your `pubspec.yaml`.

```yaml
dependencies:
  job_application:
    path: ../packages/job_application
```

## Usage

### 1. Initialization

Register the repository with your dependency injection container (e.g., `GetIt`).

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  JobApplication.initialize(GetIt.I);
}
```

### 2. Consuming in the App Layer

```dart
class JobBoardCubit extends Cubit<JobBoardState> {
  final JobApplicationRepository _repository;

  JobBoardCubit({required JobApplicationRepository repository})
      : _repository = repository,
        super(JobBoardInitial()) {
    _subscribeToJobs();
  }

  void _subscribeToJobs() {
    _repository.watchJobs('SomeUserId').listen((jobs) {
      emit(JobBoardLoaded(jobs));
    });
  }
  
  Future<void> addJob(JobApplicationEntity job) async {
    await _repository.createJob(job);
  }
}
```

## Testing

Mocking the repository allows testing business logic without a live backend.

```dart
class MockJobRepo extends Mock implements JobApplicationRepository {}

void main() {
  test('JobBoardCubit emits loaded state with jobs', () {
    final mockRepo = MockJobRepo();
    when(mockRepo.getJobApplications()).thenAnswer((_) => Stream.value([job1, job2]));
    
    // ... assert Cubit state
  });
}
```

## 🚀 Highlights

- **Cloud Firestore Integration**: Implements real-time data synchronization and persistence using `cloud_firestore`.
- **Immutable Data Models**: Uses `freezed` and `json_serializable` to generate robust, immutable data classes with JSON serialization support.
- **Domain-Driven Design**: Encapsulates business logic related to job applications (creation, status updates, deletion) within this package.
- **Dependency Injection**: Designed to work with `get_it` for loose coupling and easy testing.
