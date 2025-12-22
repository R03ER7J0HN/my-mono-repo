# Job Application Tracker Monorepo

A Flutter monorepo for a job application tracking mobile app, built with **Clean Architecture + MVVM** pattern. Managed by **Melos** for scalable package management.

> ⚠️ **Work in Progress**: This project is under active development. Features listed below represent the current state and may change.

## 📱 Overview

Job Application Tracker helps users organize and monitor their job search journey by tracking applications, interview schedules, and application statuses across multiple job platforms.

## 🏗️ Architecture

This monorepo follows **Clean Architecture** principles with a **feature-first** organization:

```
my-mono-repo/
├── apps/
│   └── job_application_tracker/    # Main Flutter application
└── packages/
    ├── flutter_core/               # Shared utilities & Result types
    ├── authentication/             # Firebase Auth integration
    ├── job_application/            # Job tracking domain & data
    ├── location_tracking/          # Geolocation services
    └── notification/               # Push notifications (FCM)
```

## ✨ Current Features

### Authentication
- Email/password sign-in and sign-up
- Password reset via email
- Secure token storage
- Persistent auth state

### Job Application Management
- Create, read, update, delete job applications
- Track application status (Applied, Interviewing, Offer, Rejected, Ghosted)
- Support for multiple job platforms (LinkedIn, Indeed, Glassdoor, JobStreet, We Work Remotely, Upwork)
- Work setup tracking (Remote, Onsite, Hybrid)
- Employment type categorization (Full-time, Part-time, Contract, Internship, Freelance)
- Salary tracking with currency support
- Interview date scheduling
- Deadline reminders
- Recruiter contact information
- Notes per application

### Location Services
- Google Maps integration for job locations
- Address autocomplete with Places API
- Geolocation for nearby job tracking

### Notifications
- Firebase Cloud Messaging integration
- Push notification support for reminders

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| Framework | Flutter (Dart SDK ^3.9.0) |
| State Management | flutter_bloc / Cubit |
| Architecture | Clean Architecture + MVVM |
| Backend | Firebase (Auth, Firestore, FCM) |
| DI | GetIt |
| Monorepo Management | Melos |
| Code Generation | freezed, json_serializable, build_runner |
| Linting | very_good_analysis |
| Maps | Google Maps Flutter |
| Location | Geolocator |

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ^3.9.0
- Dart SDK ^3.9.0
- Melos CLI (`dart pub global activate melos`)
- Firebase project configured

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/R03ER7J0HN/my-mono-repo.git
   cd my-mono-repo
   ```

2. **Bootstrap the workspace**
   ```bash
   melos bootstrap
   ```

3. **Configure secrets**
   ```bash
   cd apps/job_application_tracker
   cp secrets.json.example secrets.json
   # Edit secrets.json with your API keys
   ```

4. **Generate code files**
   ```bash
   melos run build-files --no-select
   ```

5. **Run the app**
   ```bash
   cd apps/job_application_tracker
   flutter run
   ```

## 📦 Packages

| Package | Description |
|---------|-------------|
| [flutter_core](packages/flutter_core/) | Core utilities, Result types, extensions, and error handling |
| [authentication](packages/authentication/) | Firebase Authentication with secure storage |
| [job_application](packages/job_application/) | Job application entities, repository, and Firestore integration |
| [location_tracking](packages/location_tracking/) | Geolocation services and Google Maps integration |
| [notification](packages/notification/) | Firebase Cloud Messaging for push notifications |

## 🧪 Testing

```bash
# Run all tests
melos run test

# Run tests for a specific package
cd packages/<package_name>
flutter test
```

## 📝 Useful Commands

```bash
melos bootstrap              # Install dependencies for all packages
melos run build-files        # Run build_runner for code generation
melos run test               # Run tests across all packages
melos run outdated           # Check for outdated dependencies
melos run upgrade            # Upgrade dependencies
```

## 📄 License

This project is for portfolio/demonstration purposes.

---

*Built with ❤️ using Flutter*
