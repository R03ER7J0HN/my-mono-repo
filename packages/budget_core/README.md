# Budget Core Package

A core package for budget tracking functionality, providing domain entities and repository contracts that can be reused across multiple apps.

## ✨ Features

### Account Management
- **Account Types**: Cash, Debit Card, Credit Card, E-Wallet, Savings
- **Balance Tracking**: Current balance for each account
- **Credit Limits**: Track credit limits and available credit for credit cards
- **Budget Thresholds**: Set spending limits with 80% warning threshold

### Transaction Tracking
- **Transaction Types**: Income, Expense, Transfer
- **Daily Monitoring**: Track daily transactions across accounts
- **Category-based**: Organize transactions by account/category

### Installment Management
- **Credit Card Installments**: Track itemized installments
- **Payment Schedule**: Monthly/yearly breakdown until completion
- **Remaining Balance**: Monitor outstanding amounts

### Budget Categories
- **Spending Limits**: Set budgets per category
- **Threshold Warnings**: Alert when reaching 80% of budget
- **Period Tracking**: Monthly budget cycles

## 🏗️ Architecture

This package follows **Clean Architecture** with Domain-Data split:

| Layer | Component | Role |
|-------|-----------|------|
| **Domain** | `AccountEntity` | Bank accounts, cards, e-wallets |
| **Domain** | `TransactionEntity` | Income, expense, transfer records |
| **Domain** | `InstallmentEntity` | Credit card installment plans |
| **Domain** | `BudgetCategoryEntity` | Spending categories with limits |
| **Domain** | `AccountRepository` | Account CRUD operations |
| **Domain** | `TransactionRepository` | Transaction CRUD operations |
| **Domain** | `InstallmentRepository` | Installment tracking operations |
| **Data** | Local Storage Implementations | SharedPreferences/SQLite |

## 📦 Installation

```yaml
dependencies:
  budget_core:
    path: ../packages/budget_core
```

## 💡 Usage

### Initialization

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BudgetCore.initialize(GetIt.I);
}
```

### Account Operations

```dart
// Create account
final account = AccountEntity(
  id: uuid.v4(),
  name: 'Main Savings',
  type: AccountType.savings,
  balance: 10000,
  budgetLimit: 5000,
);

await accountRepository.createAccount(account);

// Check budget threshold
if (account.isOverThreshold) {
  showWarning('Budget threshold exceeded!');
}
```

### Transaction Operations

```dart
// Add expense
final transaction = TransactionEntity(
  id: uuid.v4(),
  accountId: account.id,
  type: TransactionType.expense,
  amount: 500,
  description: 'Grocery shopping',
  date: DateTime.now(),
);

await transactionRepository.createTransaction(transaction);
```

## 🧪 Testing

```dart
class MockAccountRepo extends Mock implements AccountRepository {}
```
