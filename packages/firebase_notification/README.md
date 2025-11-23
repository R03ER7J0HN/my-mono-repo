# Firebase Notification Package

This package provides a clean, reusable, and testable way to handle Firebase Cloud Messaging in a Flutter application. It is designed as a self-contained feature package that can be easily integrated into any app.

## Architecture: Pragmatic Clean Architecture

This package follows a pragmatic and lean interpretation of Clean Architecture, optimized for creating scalable feature packages. It maintains a strong separation of concerns without the heavy boilerplate of a more traditional, "heavy" Clean Architecture that includes explicit use case classes for every repository method.

We can call this a **Feature-Sliced Architecture with a Domain-Data Split**.

### Comparison to "Traditional" Clean Architecture

| Layer           | Traditional Clean Architecture                                                                | This Package's Architecture (Pragmatic)                                                                        |
| :-------------- | :-------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------- |
| **Domain**      | Contains entities, abstract repositories, and **use case classes** (e.g., `GetTokenUseCase`). | Contains entities (`Notification`) and abstract repositories (`NotificationService`). **No use case classes.** |
| **Data**        | Contains repository implementations and data source definitions.                              | Contains the repository implementation (`FCMService`).                                                         |
| **Interaction** | The Presentation Layer (UI/Cubit) calls a specific `UseCase` class.                           | The Presentation Layer calls methods directly on the abstract `Repository` (`NotificationService`).            |

### Why This Approach?

For features that don't have complex business logic orchestrating multiple repositories, use case classes can be redundant boilerplate (e.g., a class that does nothing but call a single repository method).

This pragmatic approach simplifies the structure by allowing the Presentation Layer to depend directly on the repository's contract. It remains highly testable and maintainable because the dependency is still on an **abstraction**, not a concrete implementation.

### Layers in This Package

1.  **Public API (`lib/firebase_notification.dart`)**

    - This is the "facade" and the only file your application should ever import.
    - It exports the abstract `NotificationService` and the `Notification` model.
    - It provides a single `initialize()` method to handle dependency injection.

2.  **Abstraction Layer (The "Domain")**

    - `lib/src/notification_service.dart`: The abstract contract that defines _what_ the service can do.
    - `lib/src/models/notification.dart`: The pure data model (entity) that the rest of your app will interact with.

3.  **Implementation Layer (The "Data")**
    - `lib/src/fcm_service.dart`: The concrete implementation of `NotificationService`. This is the only file that knows about the `firebase_messaging` SDK. It handles the "how."

This structure provides the best of both worlds: the high cohesion of a feature-sliced package and the low coupling and testability of a layered architecture, all while keeping the code lean and easy to navigate.
