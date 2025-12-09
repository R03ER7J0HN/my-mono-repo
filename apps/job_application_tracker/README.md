# Job Application Tracker App

The primary application in this monorepo, designed to help users track and manage their job applications efficiently.

## 🚀 Portfolio Highlights

This project demonstrates a production-ready Flutter application architecture with the following key components:

- **Modular Monorepo Structure**: Built using `melos` to manage multiple packages, ensuring strict separation of concerns and code reusability.
- **Feature-First Architecture**: The codebase is organized by features (e.g., authentication, job tracking) rather than technical layers, making it scalable and maintainable.
- **State Management**: Utilizes `flutter_bloc` for predictable, testable, and reactive state management.
- **Firebase Integration**:
  - **Authentication**: Secure user sign-in flows using `firebase_auth`.
  - **Cloud Messaging**: Push notifications for application updates via `firebase_messaging`.
- **Localization**: Custom shell scripts (`generate_localizations.sh`) for managing app-wide localization.
- **CI/CD Readiness**: Structured for automated testing and deployment pipelines (Fastlane/GitHub Actions ready).

## Getting Started

1.  **Bootstrap the Workspace**:
    ```bash
    melos bootstrap
    ```
2.  **Run the App**:
    ```bash
    flutter run
    ```
