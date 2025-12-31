# Budget Tracker

> ⚠️ **Development Status**: This application is AI-assisted and currently in the initial phase for code review. While functional based on initial testing, it has not undergone comprehensive production testing.

A personal budget tracking Flutter application for managing finances across multiple accounts. Built with Clean Architecture, MVVM pattern, and Cubit state management.

## 📱 Screenshots

*Screenshots coming soon*

## ✨ Features

### Dashboard
- **Financial Overview**: Quick summary of total balance, income, and expenses
- **Recent Transactions**: View latest transactions at a glance
- **Quick Actions**: Fast access to common operations
- **Warning Banners**: Alerts for accounts approaching budget limits
- **Data Reset**: Option to clear all data and start fresh

### Account Management
- **Multiple Account Types**: Cash, Debit Card, Credit Card, E-Wallet, Savings
- **Balance Tracking**: Real-time balance for each account
- **Credit Management**: Track credit limits for credit cards
- **Budget Limits**: Set spending thresholds per account

### Transaction Tracking
- **Income/Expense/Transfer**: Support for all transaction types
- **Category Assignment**: Organize spending by categories
- **Date Navigation**: Browse transactions by day, month, or year
- **Account Filtering**: Filter transactions by account type
- **Edit & Delete**: Full CRUD operations on transactions

### Analytics
- **Spending Charts**: Visual breakdown of expenses by category
- **Income vs Expense**: Track financial flow over time
- **Category Analysis**: Identify spending patterns
- **Time-based Views**: Daily, monthly, yearly perspectives

### Installments
- **Credit Card Installments**: Track payment plans
- **Progress Monitoring**: View paid vs remaining installments
- **Flexible Frequencies**: Monthly, quarterly, yearly options

### Monthly Budgets
- **Budget Setting**: Define monthly spending targets
- **Progress Tracking**: Monitor spending against budget
- **Daily Budget**: Automatic daily allowance calculation

### Categories
- **Custom Categories**: Create personalized spending categories
- **Visual Customization**: Choose icons and colors
- **System Defaults**: Pre-configured common categories

## 🏗️ Architecture

This app follows **Clean Architecture + MVVM** with feature-based organization:

```
lib/
├── main.dart                     # App entry point
├── router/                       # GoRouter navigation
│   └── app_routes.dart           # Route definitions
├── theme/                        # App theming
│   └── app_theme.dart            # Material theme configuration
├── widgets/                      # Shared widgets
│   ├── background_decoration.dart
│   ├── glass_card.dart
│   ├── budget_widgets.dart
│   └── confirmation_bottom_sheet.dart
└── features/                     # Feature modules
    ├── accounts/
    │   ├── cubit/                # State management
    │   ├── widgets/              # Feature-specific widgets
    │   └── accounts_screen.dart  # Entry point
    ├── analytics/
    ├── categories/
    ├── dashboard/
    ├── installments/
    ├── monthly_budget/
    └── transactions/
        ├── cubit/
        │   ├── transactions_cubit.dart
        │   └── transactions_state.dart
        ├── transaction_entry/    # Sub-feature
        │   ├── cubit/
        │   └── transaction_entry_screen.dart
        ├── widgets/
        └── transactions_screen.dart
```

### Feature Module Pattern

Each feature follows this structure:

```
features/<feature>/
├── cubit/
│   ├── <feature>_cubit.dart      # Business logic
│   └── <feature>_state.dart      # Immutable state (freezed)
├── widgets/                       # Private widgets
├── l10n/                         # Localization (if needed)
└── <feature>_screen.dart         # Entry widget with BlocProvider
```

### Key Patterns

| Pattern | Implementation |
|---------|----------------|
| **State Management** | Cubit with `SafeEmitMixin` |
| **Navigation** | GoRouter with typed routes |
| **DI** | GetIt service locator |
| **Immutable State** | freezed data classes |
| **Error Handling** | Result<T> type from flutter_core |

## 🔧 Dependencies

### Core
- `flutter_bloc` / `bloc` - State management
- `go_router` - Declarative routing
- `get_it` - Dependency injection
- `budget_core` - Domain layer package
- `flutter_core` - Core utilities

### UI
- `fl_chart` - Charts and graphs
- `flex_color_picker` - Color selection
- `flutter_form_builder` - Form handling
- `form_builder_validators` - Form validation

### Data
- `freezed` - Immutable data classes
- `json_serializable` - JSON serialization
- `equatable` - Value equality
- `uuid` - Unique ID generation
- `intl` - Internationalization

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ^3.9.0
- Dart SDK ^3.9.0
- Melos (for monorepo management)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd my-mono-repo
   ```

2. **Bootstrap the workspace**
   ```bash
   melos bootstrap
   ```

3. **Generate secrets** (if applicable)
   ```bash
   cd apps/budget_tracker
   ./scripts/generate_secrets.sh
   ```

4. **Run code generation**
   ```bash
   melos run build-files --no-select
   ```

5. **Run the app**
   ```bash
   cd apps/budget_tracker
   flutter run
   ```

### Available Commands

```bash
# Bootstrap workspace
melos bootstrap

# Run code generation for all packages
melos run build-files --no-select

# Run tests
melos run test

# Format code
dart format . --line-length 80

# Analyze code
dart analyze
```

## 📁 Project Structure

```
my-mono-repo/
├── apps/
│   └── budget_tracker/           # This app
├── packages/
│   ├── budget_core/              # Domain & data layer
│   └── flutter_core/             # Shared utilities
└── melos.yaml                    # Monorepo configuration
```

## 🎨 Theming

The app uses a custom Material 3 theme with:
- Glass-morphism effects
- Gradient backgrounds
- Consistent color palette
- Dark/light mode support (planned)

## 🌐 Localization

The app supports localization using Flutter's built-in l10n:

```bash
cd apps/budget_tracker
./generate_localizations.sh
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/transactions/cubit/transactions_cubit_test.dart
```

### Test Structure

```
test/
└── features/
    └── <feature>/
        └── cubit/
            └── <feature>_cubit_test.dart
```

## 📱 Supported Platforms

- ✅ iOS
- ✅ Android
- 🔲 Web (planned)
- 🔲 Desktop (planned)

## 🔒 Data Storage

All data is stored locally using SQLite via the `budget_core` package. No cloud sync is currently implemented.

## 🤝 Contributing

This is a private project in active development. Contributions are managed internally.

## 📄 License

Private - Not for public distribution.

---

## 🛠️ Development Notes

### Code Quality
- **Linting**: `very_good_analysis` with strict rules
- **Formatting**: 80-character line width
- **Imports**: Always use package imports

### Best Practices
1. One Cubit per screen
2. Use `SafeEmitMixin` to prevent post-close emissions
3. Inject dependencies at Screen level via `BlocProvider`
4. Keep widgets small and focused
5. Test Cubits with >90% coverage target

---

*This application was developed with AI assistance and is in active development.*
