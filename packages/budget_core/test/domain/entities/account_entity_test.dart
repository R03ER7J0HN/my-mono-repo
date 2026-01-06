import 'package:budget_core/budget_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AccountEntity', () {
    group('availableCredit', () {
      test('returns 0 for non-credit card accounts', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 1000,
        );

        expect(account.availableCredit, 0);
      });

      test('returns 0 for credit card without credit limit', () {
        const account = AccountEntity(
          id: '1',
          name: 'Credit Card',
          type: AccountType.creditCard,
          balance: -500,
        );

        expect(account.availableCredit, 0);
      });

      test('returns available credit for credit card with limit', () {
        const account = AccountEntity(
          id: '1',
          name: 'Credit Card',
          type: AccountType.creditCard,
          balance: -500, // 500 debt
          creditLimit: 10000,
        );

        // Available = limit + balance = 10000 + (-500) = 9500
        expect(account.availableCredit, 9500);
      });

      test('returns full limit when no debt', () {
        const account = AccountEntity(
          id: '1',
          name: 'Credit Card',
          type: AccountType.creditCard,
          creditLimit: 5000,
        );

        expect(account.availableCredit, 5000);
      });
    });

    group('budgetSpent', () {
      test('returns 0 when budgetLimit is null', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 500,
        );

        expect(account.budgetSpent, 0);
      });

      test('returns 0 when budgetLimit is 0', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 500,
          budgetLimit: 0,
        );

        expect(account.budgetSpent, 0);
      });

      test('calculates correct spent amount', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 700, // 300 spent from 1000 limit
          budgetLimit: 1000,
        );

        expect(account.budgetSpent, 300);
      });
    });

    group('budgetUsagePercentage', () {
      test('returns 0 when budgetLimit is null', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 500,
        );

        expect(account.budgetUsagePercentage, 0);
      });

      test('returns 0 when nothing is spent', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 1000,
          budgetLimit: 1000,
        );

        expect(account.budgetUsagePercentage, 0);
      });

      test('calculates correct percentage', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 500, // 500 spent from 1000 limit = 50%
          budgetLimit: 1000,
        );

        expect(account.budgetUsagePercentage, 0.5);
      });

      test('clamps to 1.0 when overspent', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: -200, // 1200 spent from 1000 limit
          budgetLimit: 1000,
        );

        expect(account.budgetUsagePercentage, 1.0);
      });
    });

    group('isOverThreshold', () {
      test('returns false when budgetLimit is null', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
        );

        expect(account.isOverThreshold, false);
      });

      test('returns false when under threshold', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 500, // 50% used, default threshold is 80%
          budgetLimit: 1000,
        );

        expect(account.isOverThreshold, false);
      });

      test('returns true when at threshold', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 200, // 80% used
          budgetLimit: 1000,
        );

        expect(account.isOverThreshold, true);
      });

      test('returns true when over threshold', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 100, // 90% used
          budgetLimit: 1000,
        );

        expect(account.isOverThreshold, true);
      });
    });

    group('creditUsagePercentage', () {
      test('returns 0 for non-credit card', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: -500,
          creditLimit: 1000,
        );

        expect(account.creditUsagePercentage, 0);
      });

      test('returns 0 when creditLimit is null', () {
        const account = AccountEntity(
          id: '1',
          name: 'Credit Card',
          type: AccountType.creditCard,
          balance: -500,
        );

        expect(account.creditUsagePercentage, 0);
      });

      test('returns 0 when creditLimit is 0', () {
        const account = AccountEntity(
          id: '1',
          name: 'Credit Card',
          type: AccountType.creditCard,
          balance: -500,
          creditLimit: 0,
        );

        expect(account.creditUsagePercentage, 0);
      });

      test('returns 0 when no debt', () {
        const account = AccountEntity(
          id: '1',
          name: 'Credit Card',
          type: AccountType.creditCard,
          creditLimit: 10000,
        );

        expect(account.creditUsagePercentage, 0);
      });

      test('calculates correct percentage', () {
        const account = AccountEntity(
          id: '1',
          name: 'Credit Card',
          type: AccountType.creditCard,
          balance: -5000, // 50% of 10000 limit
          creditLimit: 10000,
        );

        expect(account.creditUsagePercentage, 0.5);
      });

      test('clamps to 1.0 when over limit', () {
        const account = AccountEntity(
          id: '1',
          name: 'Credit Card',
          type: AccountType.creditCard,
          balance: -12000, // Over limit
          creditLimit: 10000,
        );

        expect(account.creditUsagePercentage, 1.0);
      });
    });

    group('isCreditOverThreshold', () {
      test('returns false for non-credit card', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: -9000,
          creditLimit: 10000,
        );

        expect(account.isCreditOverThreshold, false);
      });

      test('returns false when under threshold', () {
        const account = AccountEntity(
          id: '1',
          name: 'Credit Card',
          type: AccountType.creditCard,
          balance: -5000, // 50% used
          creditLimit: 10000,
        );

        expect(account.isCreditOverThreshold, false);
      });

      test('returns true when at threshold', () {
        const account = AccountEntity(
          id: '1',
          name: 'Credit Card',
          type: AccountType.creditCard,
          balance: -8000, // 80% used
          creditLimit: 10000,
        );

        expect(account.isCreditOverThreshold, true);
      });
    });

    group('totalDebt', () {
      test('returns 0 for non-credit card', () {
        const account = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: -500,
        );

        expect(account.totalDebt, 0);
      });

      test('returns 0 for credit card with no debt', () {
        const account = AccountEntity(
          id: '1',
          name: 'Credit Card',
          type: AccountType.creditCard,
        );

        expect(account.totalDebt, 0);
      });

      test('returns 0 for credit card with positive balance', () {
        const account = AccountEntity(
          id: '1',
          name: 'Credit Card',
          type: AccountType.creditCard,
          balance: 100, // Overpayment/credit
        );

        expect(account.totalDebt, 0);
      });

      test('returns absolute debt amount', () {
        const account = AccountEntity(
          id: '1',
          name: 'Credit Card',
          type: AccountType.creditCard,
          balance: -5000,
        );

        expect(account.totalDebt, 5000);
      });
    });

    group('equality', () {
      test('two accounts with same values are equal', () {
        const account1 = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 1000,
        );

        const account2 = AccountEntity(
          id: '1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 1000,
        );

        expect(account1, account2);
      });
    });
  });
}
