# Project Overview: Job Application Tracker Monorepo

This is a Flutter monorepo managed by `melos`, designed to help users track and manage their job applications efficiently.

## Architecture and Key Components

*   **Modular Monorepo Structure**: Uses `melos` to organize code into multiple packages, ensuring clear separation of concerns, code reusability, and maintainability.
*   **Feature-First Architecture**: Codebase is organized by features (e.g., authentication, home, job tracking) rather than technical layers.
*   **Clean Architecture & MVVM**: Follows a strict Clean Architecture pattern with MVVM, emphasizing separation of `data`, `domain`, and `presentation` layers within features.
*   **State Management**: Primarily uses `flutter_bloc` (with `Cubit` implementations) for predictable, testable, and reactive state management. `freezed` is used for immutable state and data classes.
*   **Firebase Integration**: Leverages Firebase for backend services including authentication (`firebase_auth`) and cloud messaging (`firebase_messaging`).
*   **Routing**: Uses `go_router` for declarative navigation.
*   **Localization**: Features are set up with `flutter gen-l10n` for internationalization.

## Building and Running

1.  **Bootstrap the Workspace**:
    This command links all local packages and installs dependencies. Run from the project root.
    ```bash
    melos bootstrap
    ```
2.  **Run the App**:
    To run the main Flutter application.
    ```bash
    flutter run apps/job_application_tracker
    ```
3.  **Code Generation**:
    For `freezed` and `json_serializable` code generation, use the `melos` script from the project root.
    ```bash
    melos run build-files --no-select
    ```
4.  **Testing**:
    ```bash
    melos run test
    ```
5.  **Dependency Updates**:
    ```bash
    melos run upgrade
    melos run outdated
    ```

## Development Conventions & AI Agent Guidelines

This project adheres to strict development guidelines, some of which are documented for AI agent interaction.

*   **Core Operating Principles (`ai-agent/CORE_RULES.md`)**: Defines the fundamental workflow for all AI agents, including:
    *   **Plan, Propose, Await Approval, Execute**: Always present a concise plan with diffs for modifications (using standard unified diff format), await explicit approval, and then execute all steps.
    *   **Communication Style**: Professional, concise, clear, transparent, and always asking for confirmation on ambiguities.
*   **Flutter Development Standards (`ai-agent/flutter-developer/coding-rules.md`)**: Specific guidelines for Flutter code, including:
    *   Strict Clean Architecture (`data`, `domain`, `presentation` layers).
    *   Dependency Injection (using `get_it`).
    *   Immutability (using `freezed` for entities and states).
    *   Strict linting (`very_good_analysis`).
    *   Mandatory test coverage (Unit and Widget tests).
    *   Centralized theming and reusable widgets.
*   **Monorepo & Melos Rules (`ai-agent/mono-repo/rules.md`)**: Specific guidelines for managing the monorepo:
    *   Use `melos run build-files --no-select` for code generation.
    *   Use `melos bootstrap` after adding new packages to `pubspec.yaml`.
*   **Flutter Developer Identity (`ai-agent/flutter-developer/identity.md`)**: Describes the persona and preferred practices of the Flutter developer agent (e.g., Cubit over Bloc, single Cubit per screen).
*   **Constructive Critic (`ai-agent/critic-developer/identity.md`)**: A persona designed to provide objective, growth-oriented feedback on development work.

## Planned Feature: Interview Scheduling

A new feature is planned to enable users to add interview dates and create device calendar appointments. It will accept details such as interview date, interviewer name, and invitation link. This will be implemented as a new feature module under `apps/job_application_tracker/lib/features/jobs/`.
