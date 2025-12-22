# Job Application Tracker App

The primary Flutter application in this monorepo, designed to help users track and manage their job applications efficiently.

> ⚠️ **Work in Progress**: This app is under active development. Features listed below represent the current state.

## ✨ Current Features

### Authentication (`features/auth/`)
- **Sign In**: Email and password authentication
- **Sign Up**: New user registration
- **Forgot Password**: Password reset via email

### Job Management (`features/jobs/`)
- **Job List**: View all job applications with status filtering
- **Job Entry**: Create and edit job applications with:
  - Company name and job title
  - Job posting URL (auto-detects platform)
  - Work setup (Remote, Onsite, Hybrid)
  - Employment type (Full-time, Part-time, Contract, Internship, Freelance)
  - Salary expectations with currency
  - Interview dates and deadlines
  - Recruiter contact information
  - Location with Google Maps integration
  - Personal notes

### Home Dashboard (`features/home/`)
- Overview of application statistics
- Quick access to recent applications

### User Profile (`features/profile/`)
- User account management
- Sign out functionality

### Splash Screen (`features/splash/`)
- App initialization and auth state check

## 🏗️ Architecture Highlights

- **Feature-First Organization**: Each feature is self-contained with its own cubit, widgets, and localization
- **State Management**: `flutter_bloc` (Cubit) for predictable, testable state
- **Dependency Injection**: `GetIt` for service location
- **Localization**: Per-feature ARB files with custom generation script

## 📦 Package Dependencies

This app consumes the following workspace packages:
- `flutter_core` — Result types, extensions, error handling
- `authentication` — Firebase Auth integration
- `job_application` — Job entities and Firestore repository
- `location_tracking` — Geolocation and Google Maps
- `notification` — Push notifications (FCM)

## 🚀 Getting Started

1. **Bootstrap the workspace** (from monorepo root):
   ```bash
   melos bootstrap
   ```

2. **Configure secrets**:
   ```bash
   cp secrets.json.example secrets.json
   # Add your Google Maps API key and other secrets
   ```

3. **Generate localization files**:
   ```bash
   ./generate_localizations.sh
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

## 🧪 Testing

```bash
flutter test
```
