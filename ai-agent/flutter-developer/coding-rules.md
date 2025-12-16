# Flutter Development Standards

### **Architecture & Project Structure**

1.  **Strict Layering within Modules:** Each feature module (package) must strictly follow the `data`, `domain`, and `presentation` structure.
    *   **`data`**: Contains repository implementations and data sources (e.g., API clients, local database access). It depends on the `domain` layer.
    *   **`domain`**: The core of the feature. Contains entities (plain Dart objects), repository contracts (abstract classes), and use cases. This layer must have **zero** dependencies on Flutter or any external packages.
    *   **`presentation`**: The UI layer. Contains screens, widgets, and the Cubits that manage their state. It depends on the `domain` layer.
2.  **Dependency Injection (DI):** Use a DI framework like `get_it` to decouple layers. Register all repositories, data sources, and Cubits in a central service locator for each module. Never instantiate a dependency directly (e.g., `MyRepositoryImpl()`) within a class that uses it.
3.  **Contracts for Repositories:** Always define an abstract `class` (the contract) for a repository in the `domain` layer. The concrete implementation resides in the `data` layer. This enforces the Dependency Inversion Principle.
4.  **Models vs. Entities:**
    *   **Entities** (in `domain`) are plain Dart objects representing core business objects.
    *   **Models** (in `data`) are representations of data from external sources (e.g., JSON from an API). They should include `fromJson`/`toJson` methods and be mapped to/from domain Entities within the repository implementation. The presentation layer should only ever interact with Entities.

### **Code Style & Quality**

1.  **Strict Linting with `very_good_analysis`:** All packages must use `very_good_analysis` as the base for linting rules in `analysis_options.yaml`. This ensures a high standard of code quality and consistency across the monorepo.
2.  **Single Responsibility Principle (SRP):** Keep files and classes small and focused. A file should contain a single public widget/class, unless they are small, private, and directly related.
3.  **Immutability:** All state classes and model/entity objects must be immutable. Use the `@immutable` annotation and ensure all properties are `final`. When a change is needed, create a new instance of the object with the updated values (e.g., using a `copyWith` method).

### **State Management (Cubit)**

1.  **Isolate Business Logic:** Business logic must reside exclusively within Cubits (or Use Cases called by Cubits). Widgets should contain zero business logic.
2.  **Flexible State Class Design:** The structure of a Cubit's state class should match the complexity of the screen's logic.
    *   **Flat State Class:** For simple screens, use a single state class with properties representing the UI's state (e.g., `bool isLoading`, `List<Item> items`, `String? error`). This is straightforward and efficient for basic use cases.
    *   **Union-Typed State Class:** For complex screens with distinct, mutually exclusive states (e.g., loading, success, error, submission in progress), use a union/sealed class (e.g., with `freezed`). This provides strong type safety and ensures you handle every possible UI state explicitly in the presentation layer.
3.  **View-to-Cubit Communication:** The View (Screen/Widget) communicates with its Cubit by calling public methods on the Cubit class (e.g., `cubit.fetchUserData()`).
4.  **Cubit-to-View Communication:** The Cubit communicates with the View by emitting new states. The View uses `BlocBuilder` or `BlocListener` to react to these state changes.

### **Testing**

1.  **Mandatory Test Coverage:** Every new feature or bug fix must be accompanied by tests.
    *   **Unit Tests:** For every Cubit, repository implementation, and use case. Achieve >90% line coverage.
    *   **Widget Tests:** For every screen and significant reusable widget. Test for UI states (e.g., show a progress bar on `Loading` state, show data on `Success` state).
2.  **Mocking:** Use `mockito` or `mocktail` to generate mocks for all dependencies (especially repositories and data sources) when testing Cubits and widgets.

### **UI & Theming**

1.  **Centralized Theme:** All colors, text styles, and spacing values must be defined in the central `ThemeData`. Avoid hardcoding values directly in widgets. For example, use `Theme.of(context).primaryColor` instead of `Colors.blue`.
2.  **Reusable Widget Library:** Create a shared package (`flutter_core` or similar) for common, app-specific widgets (e.g., `PrimaryButton`, `StyledTextField`). This ensures UI consistency and reduces code duplication.
3.  **Responsive UI:** Build UIs that adapt to different screen sizes and orientations using `LayoutBuilder`, `MediaQuery`, and `FractionallySizedBox`. Do not use fixed pixel values for widths and heights.
