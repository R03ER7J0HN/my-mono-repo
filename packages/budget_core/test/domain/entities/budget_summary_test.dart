import 'package:budget_core/budget_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BudgetSummary', () {
    group('netWorth', () {
      test('calculates correct net worth', () {
        const summary = BudgetSummary(
          totalBalance: 50000,
          totalDebt: 10000,
        );

        expect(summary.netWorth, 40000);
      });

      test('returns negative when debt exceeds balance', () {
        const summary = BudgetSummary(
          totalBalance: 5000,
          totalDebt: 15000,
        );

        expect(summary.netWorth, -10000);
      });

      test('returns totalBalance when no debt', () {
        const summary = BudgetSummary(
          totalBalance: 50000,
        );

        expect(summary.netWorth, 50000);
      });
    });

    group('hasWarnings', () {
      test('returns false when no warnings', () {
        const summary = BudgetSummary(
          
        );

        expect(summary.hasWarnings, false);
      });

      test('returns true when accountsOverThreshold > 0', () {
        const summary = BudgetSummary(
          accountsOverThreshold: 1,
        );

        expect(summary.hasWarnings, true);
      });

      test('returns true when creditCardsOverThreshold > 0', () {
        const summary = BudgetSummary(
          creditCardsOverThreshold: 2,
        );

        expect(summary.hasWarnings, true);
      });

      test('returns true when both have warnings', () {
        const summary = BudgetSummary(
          accountsOverThreshold: 1,
          creditCardsOverThreshold: 2,
        );

        expect(summary.hasWarnings, true);
      });
    });

    group('totalWarnings', () {
      test('returns 0 when no warnings', () {
        const summary = BudgetSummary(
          
        );

        expect(summary.totalWarnings, 0);
      });

      test('sums all warnings', () {
        const summary = BudgetSummary(
          accountsOverThreshold: 2,
          creditCardsOverThreshold: 3,
        );

        expect(summary.totalWarnings, 5);
      });
    });

    group('default values', () {
      test('all default values are 0', () {
        const summary = BudgetSummary();

        expect(summary.totalBalance, 0);
        expect(summary.totalDebt, 0);
        expect(summary.totalAvailableCredit, 0);
        expect(summary.monthlyIncome, 0);
        expect(summary.monthlyExpenses, 0);
        expect(summary.monthlySavings, 0);
        expect(summary.monthlyInstallments, 0);
        expect(summary.accountsOverThreshold, 0);
        expect(summary.creditCardsOverThreshold, 0);
      });
    });

    group('equality', () {
      test('two summaries with same values are equal', () {
        const summary1 = BudgetSummary(
          totalBalance: 50000,
          totalDebt: 10000,
          monthlyIncome: 5000,
          monthlyExpenses: 3000,
        );

        const summary2 = BudgetSummary(
          totalBalance: 50000,
          totalDebt: 10000,
          monthlyIncome: 5000,
          monthlyExpenses: 3000,
        );

        expect(summary1, summary2);
      });
    });
  });
}
