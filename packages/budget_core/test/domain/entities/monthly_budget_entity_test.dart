import 'package:budget_core/budget_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MonthlyBudgetEntity', () {
    group('remainingBudget', () {
      test('calculates correct remaining budget', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: 10000,
          spentAmount: 3000,
        );

        expect(budget.remainingBudget, 7000);
      });

      test('returns negative when overspent', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: 10000,
          spentAmount: 12000,
        );

        expect(budget.remainingBudget, -2000);
      });
    });

    group('spentPercentage', () {
      test('returns 0 when totalBudget is 0', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: 0,
        );

        expect(budget.spentPercentage, 0);
      });

      test('returns 0 when totalBudget is negative', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: -1000,
          spentAmount: 500,
        );

        expect(budget.spentPercentage, 0);
      });

      test('calculates correct percentage', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: 10000,
          spentAmount: 5000,
        );

        expect(budget.spentPercentage, 0.5);
      });

      test('clamps to 1.0 when overspent', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: 10000,
          spentAmount: 15000,
        );

        expect(budget.spentPercentage, 1.0);
      });
    });

    group('isExceeded', () {
      test('returns false when under budget', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: 10000,
          spentAmount: 8000,
        );

        expect(budget.isExceeded, false);
      });

      test('returns false when at budget', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: 10000,
          spentAmount: 10000,
        );

        expect(budget.isExceeded, false);
      });

      test('returns true when over budget', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: 10000,
          spentAmount: 10001,
        );

        expect(budget.isExceeded, true);
      });
    });

    group('startDate', () {
      test('returns first day of month', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 6,
          totalBudget: 10000,
        );

        expect(budget.startDate, DateTime(2025, 6));
      });
    });

    group('endDate', () {
      test('returns last day of month for January', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: 10000,
        );

        expect(budget.endDate, DateTime(2025, 1, 31));
      });

      test('returns last day of month for February (non-leap year)', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 2,
          totalBudget: 10000,
        );

        expect(budget.endDate, DateTime(2025, 2, 28));
      });

      test('returns last day of month for February (leap year)', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2024,
          month: 2,
          totalBudget: 10000,
        );

        expect(budget.endDate, DateTime(2024, 2, 29));
      });

      test('returns last day of month for December', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 12,
          totalBudget: 10000,
        );

        expect(budget.endDate, DateTime(2025, 12, 31));
      });
    });

    group('daysInMonth', () {
      test('returns 31 for January', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: 10000,
        );

        expect(budget.daysInMonth, 31);
      });

      test('returns 28 for February (non-leap year)', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 2,
          totalBudget: 10000,
        );

        expect(budget.daysInMonth, 28);
      });

      test('returns 29 for February (leap year)', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2024,
          month: 2,
          totalBudget: 10000,
        );

        expect(budget.daysInMonth, 29);
      });

      test('returns 30 for April', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 4,
          totalBudget: 10000,
        );

        expect(budget.daysInMonth, 30);
      });
    });

    group('calculatedDailyBudget', () {
      test('returns dailyBudget if set', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: 10000,
          dailyBudget: 500,
        );

        expect(budget.calculatedDailyBudget, 500);
      });

      test('calculates from totalBudget when dailyBudget is null', () {
        const budget = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1, // 31 days
          totalBudget: 3100,
        );

        expect(budget.calculatedDailyBudget, 100);
      });
    });

    group('equality', () {
      test('two budgets with same values are equal', () {
        const budget1 = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: 10000,
          spentAmount: 5000,
        );

        const budget2 = MonthlyBudgetEntity(
          id: '1',
          year: 2025,
          month: 1,
          totalBudget: 10000,
          spentAmount: 5000,
        );

        expect(budget1, budget2);
      });
    });
  });
}
