# Budget Core Package

A core package for budget tracking functionality, providing domain entities, use cases, and repository contracts following Clean Architecture principles. Designed to be reused across multiple apps in a monorepo structure.

## ✨ Features

### Account Management
- **Multiple Account Types**: Cash, Debit Card, Credit Card, E-Wallet, Savings
- **Balance Tracking**: Real-time balance updates for each account
- **Credit Limits**: Track credit limits and available credit for credit cards
- **Budget Thresholds**: Set spending limits with configurable warning thresholds

### Transaction Tracking
- **Transaction Types**: Income, Expense, Transfer between accounts
- **Category Support**: Organize transactions by customizable categories
- **Date-based Queries**: Filter transactions by date ranges
- **Reactive Streams**: Watch transactions in real-time with streams

### Installment Management
- **Credit Card Installments**: Track itemized installment plans
- **Payment Scheduling**: Monthly, quarterly, yearly frequency options
- **Progress Tracking**: Monitor paid vs remaining installments

### Monthly Budget
- **Budget Planning**: Set monthly spending targets
- **Spending Tracking**: Monitor spent amounts against budgets
- **Daily Budget Calculation**: Automatic daily budget computation

### Category Management
- **Custom Categories**: Create personalized spending categories
- **System Categories**: Pre-defined default categories
- **Visual Customization**: Icons and colors for categories

## 🏗️ Architecture

This package follows **Clean Architecture** with a clear separation between Domain and Data layers:

```
lib/
├── budget_core.dart              # Package entry point & DI setup
└── src/
    ├── domain/                   # Business logic layer (pure Dart)
    │   ├── entities/             # Immutable domain objects (freezed)
    │   ├── enums/                # Domain enumerations
    │   ├── repositories/         # Abstract repository contracts
    │   └── use_cases/            # Business use case implementations
    └── data/                     # Data layer (infrastructure)
        ├── converters/           # JSON/SQLite converters
        ├── datasources/          # Database access (LocalDataSource)
        ├── models/               # JSON-serializable data models
        └── repositories/         # Repository implementations (*Impl)
```

### Layer Responsibilities

| Layer | Component | Responsibility |
|-------|-----------|----------------|
| **Domain** | Entities | Immutable business objects using `freezed` |
| **Domain** | Enums | `AccountType`, `TransactionType`, `InstallmentFrequency` |
| **Domain** | Repositories | Abstract CRUD contracts returning `FutureResult<T>` |
| **Domain** | Use Cases | Single-responsibility business operations |
| **Data** | Models | JSON-serializable with `@JsonKey` annotations |
| **Data** | LocalDataSource | SQLite database management |
| **Data** | *RepositoryImpl | Concrete repository implementations |

### Key Patterns

- **Repository Pattern**: Abstract contracts in domain, implementations in data
- **Use Case Pattern**: Granular, single-purpose business operations
- **Result Type**: All failable operations return `Result<T>` (success/failure)
- **Composition over Inheritance**: Models compose entities, don't extend them
- **Dependency Injection**: Uses `GetIt` for service location

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  budget_core:
    path: ../packages/budget_core
```

## 💡 Usage

### Initialization

```dart
import 'package:budget_core/budget_core.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize all budget_core dependencies
  await BudgetCore.initialize(GetIt.I);
  
  runApp(MyApp());
}
```

### Using Use Cases

```dart
// Save a transaction (with automatic balance updates)
final saveTransaction = GetIt.I<SaveTransactionUseCase>();

final transaction = TransactionEntity(
  id: const Uuid().v4(),
  accountId: accountId,
  type: TransactionType.expense,
  amount: 150.00,
  description: 'Grocery shopping',
  date: DateTime.now(),
  createdAt: DateTime.now(),
);

final result = await saveTransaction(transaction);
result.fold(
  onFailure: (failure) => print('Error: ${failure.message}'),
  onSuccess: (_) => print('Transaction saved!'),
);
```

### Watching Data Streams

```dart
final transactionRepo = GetIt.I<TransactionRepository>();

transactionRepo.watchAll().listen((transactions) {
  print('Transactions updated: ${transactions.length}');
});
```

### Reset All Data

```dart
final resetData = GetIt.I<ResetAllDataUseCase>();
await resetData();
```

## 🔧 Available Use Cases

| Use Case | Description |
|----------|-------------|
| `SaveTransactionUseCase` | Save transaction with automatic balance updates |
| `DeleteTransactionUseCase` | Delete transaction and reverse balance effects |
| `GetAllTransactionsUseCase` | Retrieve all transactions |
| `GetTransactionByIdUseCase` | Get single transaction by ID |
| `GetTransactionsByAccountUseCase` | Get transactions for specific account |
| `WatchTransactionsUseCase` | Stream of transaction changes |
| `ResetAllDataUseCase` | Clear all data and restore defaults |

## 🗄️ Database Schema

The package uses SQLite with the following tables:

- `accounts` - User accounts (cash, cards, e-wallets)
- `transactions` - Income, expense, transfer records
- `installments` - Credit card installment plans
- `categories` - Spending categories
- `monthly_budgets` - Monthly budget targets

All tables use `CREATE TABLE IF NOT EXISTS` for safe initialization.

## 🧪 Testing

This package includes comprehensive tests following industry best practices:

```bash
# Run all tests
cd packages/budget_core && flutter test

# Run with coverage
flutter test --coverage
```

### Test Coverage

| Layer | Component | Tests |
|-------|-----------|-------|
| **Domain** | Entities | ✅ Business logic (computed properties, validations) |
| **Domain** | Use Cases | ✅ Business orchestration & balance updates |
| **Data** | Repositories | ✅ CRUD operations with in-memory SQLite |
| **Data** | LocalDataSource | ✅ Database setup & table creation |

### Mocking for Consumer Tests

```dart
import 'package:mockito/annotations.dart';
import 'package:budget_core/budget_core.dart';

@GenerateMocks([
  AccountRepository,
  TransactionRepository,
  SaveTransactionUseCase,
])
void main() {
  // Your tests here
}
```

## 📄 Dependencies

- `equatable` - Value equality for entities
- `freezed` - Immutable data classes
- `json_serializable` - JSON serialization
- `sqflite` - SQLite database
- `get_it` - Dependency injection
- `flutter_core` - Core utilities (Result type, Failure classes)

## 📝 License

This project is part of a private monorepo and is not published to pub.dev.
