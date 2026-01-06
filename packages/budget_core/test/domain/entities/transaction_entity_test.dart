import 'package:budget_core/budget_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TransactionEntity', () {
    group('isTransfer', () {
      test('returns true for transfer type', () {
        final transaction = TransactionEntity(
          id: '1',
          accountId: 'acc1',
          type: TransactionType.transfer,
          amount: 100,
          description: 'Transfer',
          date: DateTime.now(),
          toAccountId: 'acc2',
        );

        expect(transaction.isTransfer, true);
      });

      test('returns false for non-transfer types', () {
        final income = TransactionEntity(
          id: '1',
          accountId: 'acc1',
          type: TransactionType.income,
          amount: 100,
          description: 'Salary',
          date: DateTime.now(),
        );

        final expense = TransactionEntity(
          id: '2',
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 50,
          description: 'Groceries',
          date: DateTime.now(),
        );

        expect(income.isTransfer, false);
        expect(expense.isTransfer, false);
      });
    });

    group('isIncome', () {
      test('returns true for income type', () {
        final transaction = TransactionEntity(
          id: '1',
          accountId: 'acc1',
          type: TransactionType.income,
          amount: 100,
          description: 'Salary',
          date: DateTime.now(),
        );

        expect(transaction.isIncome, true);
      });

      test('returns false for non-income types', () {
        final expense = TransactionEntity(
          id: '1',
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 50,
          description: 'Groceries',
          date: DateTime.now(),
        );

        expect(expense.isIncome, false);
      });
    });

    group('isExpense', () {
      test('returns true for expense type', () {
        final transaction = TransactionEntity(
          id: '1',
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 50,
          description: 'Groceries',
          date: DateTime.now(),
        );

        expect(transaction.isExpense, true);
      });

      test('returns false for non-expense types', () {
        final income = TransactionEntity(
          id: '1',
          accountId: 'acc1',
          type: TransactionType.income,
          amount: 100,
          description: 'Salary',
          date: DateTime.now(),
        );

        expect(income.isExpense, false);
      });
    });

    group('signedAmount', () {
      test('returns positive amount for income', () {
        final transaction = TransactionEntity(
          id: '1',
          accountId: 'acc1',
          type: TransactionType.income,
          amount: 100,
          description: 'Salary',
          date: DateTime.now(),
        );

        expect(transaction.signedAmount, 100);
      });

      test('returns negative amount for expense', () {
        final transaction = TransactionEntity(
          id: '1',
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 50,
          description: 'Groceries',
          date: DateTime.now(),
        );

        expect(transaction.signedAmount, -50);
      });

      test('returns negative amount for transfer (outgoing)', () {
        final transaction = TransactionEntity(
          id: '1',
          accountId: 'acc1',
          type: TransactionType.transfer,
          amount: 200,
          description: 'Transfer',
          date: DateTime.now(),
          toAccountId: 'acc2',
        );

        expect(transaction.signedAmount, -200);
      });
    });

    group('equality', () {
      test('two transactions with same values are equal', () {
        final date = DateTime(2025, 1, 7);
        final transaction1 = TransactionEntity(
          id: '1',
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 50,
          description: 'Groceries',
          date: date,
        );

        final transaction2 = TransactionEntity(
          id: '1',
          accountId: 'acc1',
          type: TransactionType.expense,
          amount: 50,
          description: 'Groceries',
          date: date,
        );

        expect(transaction1, transaction2);
      });
    });
  });
}
