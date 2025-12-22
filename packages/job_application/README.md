# Job Application Package

A dedicated feature package responsible for the domain logic and data management of job applications.

> ⚠️ **Work in Progress**: This package is under active development.

## ✨ Current Features

### Job Application Entity
- Company name and job title
- Job posting URL with platform auto-detection
- Application date tracking
- Status management (Applied, Interviewing, Offer, Rejected, Ghosted)
- Work setup (Remote, Onsite, Hybrid)
- Employment type (Full-time, Part-time, Contract, Internship, Freelance)
- Salary tracking with currency support
- Interview dates list
- Deadlines list
- Recruiter name
- Location with coordinates (lat/long) and place ID
- Personal notes

### Job Platforms Supported
- LinkedIn
- Indeed
- Glassdoor
- JobStreet
- We Work Remotely
- Upwork
- Other

### Repository Operations
- Create job application
- Update job application
- Delete job application
- Get all applications for user
- Real-time stream of job applications

## 🏗️ Architecture

This package follows **Clean Architecture** with a Domain-Data split:

| Layer | Component | Role |
|-------|-----------|------|
| **Domain** | `JobApplicationRepository` | Abstract interface for CRUD operations |
| **Domain** | `JobApplicationEntity` | Immutable job application representation |
| **Domain** | `JobLocationEntity` | Location with address and coordinates |
| **Data** | `FirestoreJobApplicationRepository` | Cloud Firestore implementation |
| **Data** | `JobApplicationModel` | DTO for Firestore serialization |

## 📦 Installation

```yaml
dependencies:
  job_application:
    path: ../packages/job_application
```

## 💡 Usage

### Initialization

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  JobApplication.initialize(GetIt.I);
}
```

### Consuming in Cubit

```dart
class JobListCubit extends Cubit<JobListState> {
  JobListCubit(this._repository) : super(JobListState.initial()) {
    _subscribeToJobs();
  }

  final JobApplicationRepository _repository;

  void _subscribeToJobs() {
    _repository.watchJobs(userId).listen((jobs) {
      emit(JobListState.loaded(jobs));
    });
  }
  
  Future<void> addJob(JobApplicationEntity job) async {
    await _repository.createJob(job);
  }
}
```

## 🧪 Testing

```dart
class MockJobRepo extends Mock implements JobApplicationRepository {}

void main() {
  test('JobListCubit emits loaded state with jobs', () {
    final mockRepo = MockJobRepo();
    when(mockRepo.watchJobs(any)).thenAnswer((_) => Stream.value([job1, job2]));
    // ... assert Cubit state
  });
}
```
