import 'package:budget_core/src/domain/enums/account_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_entity.freezed.dart';

/// Represents a financial account (cash, card, e-wallet, etc.)
@freezed
sealed class AccountEntity with _$AccountEntity {
  const factory AccountEntity({
    required String id,
    required String name,
    required AccountType type,

    /// Current balance (positive for assets, can be negative for credit)
    @Default(0) double balance,

    /// Credit limit for credit cards
    double? creditLimit,

    /// Monthly budget limit for spending from this account
    double? budgetLimit,

    /// Threshold percentage (0-1) for budget warning, defaults to 0.8 (80%)
    @Default(0.8) double warningThreshold,

    /// Icon name for display
    String? iconName,

    /// Color hex for display
    String? colorHex,

    /// Whether this account is active
    @Default(true) bool isActive,

    /// Creation timestamp
    DateTime? createdAt,
  }) = _AccountEntity;

  const AccountEntity._();

  /// Available credit for credit cards (creditLimit - used amount)
  double get availableCredit {
    if (type != AccountType.creditCard || creditLimit == null) return 0;
    // For credit cards, negative balance means debt
    return creditLimit! + balance;
  }

  /// Amount spent from budget (for non-credit accounts)
  double get budgetSpent {
    if (budgetLimit == null || budgetLimit == 0) return 0;
    // Calculate how much has been spent from the initial budget
    return budgetLimit! - balance;
  }

  /// Budget usage percentage (0-1)
  double get budgetUsagePercentage {
    if (budgetLimit == null || budgetLimit == 0) return 0;
    final spent = budgetSpent;
    if (spent <= 0) return 0;
    return (spent / budgetLimit!).clamp(0.0, 1.0);
  }

  /// Whether the account has exceeded the warning threshold
  bool get isOverThreshold {
    if (budgetLimit == null || budgetLimit == 0) return false;
    return budgetUsagePercentage >= warningThreshold;
  }

  /// Credit usage percentage for credit cards (0-1)
  double get creditUsagePercentage {
    if (type != AccountType.creditCard || creditLimit == null) return 0;
    if (creditLimit == 0) return 0;
    // Negative balance means debt
    final used = -balance;
    if (used <= 0) return 0;
    return (used / creditLimit!).clamp(0.0, 1.0);
  }

  /// Whether credit card has exceeded warning threshold
  bool get isCreditOverThreshold {
    if (type != AccountType.creditCard) return false;
    return creditUsagePercentage >= warningThreshold;
  }

  /// Total debt for credit cards (absolute value)
  double get totalDebt {
    if (type != AccountType.creditCard) return 0;
    return balance < 0 ? -balance : 0;
  }
}
