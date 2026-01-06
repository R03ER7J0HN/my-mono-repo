import 'package:budget_core/budget_core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_database_helper.dart';

void main() {
  late LocalDataSource dataSource;
  late TransactionRepositoryImpl repository;

  setUpAll(initializeTestDatabase);

  setUp(() async {
    final database = await createInMemoryDatabase();
    dataSource = LocalDataSource(database);
    repository = TransactionRepositoryImpl(dataSource);
  });

  tearDown(() async {
    await dataSource.database.close();
  });

  group('TransactionRepositoryImpl', () {
    final testDate = DateTime(2025, 1, 7, 12, 30);

    group('save', () {
      test('saves a new transaction successfully', () async {
        final transaction = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.expense,
          amount: 150,
          description: 'Groceries',
          date: testDate,
        );

        final result = await repository.save(transaction);

        expect(result.isSuccess, true);

        final getResult = await repository.getById('tx-1');
        expect(getResult.isSuccess, true);
        expect(getResult.getSuccess().description, 'Groceries');
        expect(getResult.getSuccess().amount, 150);
      });

      test('updates existing transaction when id exists', () async {
        final transaction = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.expense,
          amount: 150,
          description: 'Groceries',
          date: testDate,
        );

        await repository.save(transaction);

        final updated = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.expense,
          amount: 200,
          description: 'Updated Groceries',
          date: testDate,
        );

        await repository.save(updated);

        final getResult = await repository.getById('tx-1');
        expect(getResult.getSuccess().amount, 200);
        expect(getResult.getSuccess().description, 'Updated Groceries');
      });

      test('saves transfer with toAccountId', () async {
        final transaction = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.transfer,
          amount: 500,
          description: 'Transfer to savings',
          date: testDate,
          toAccountId: 'acc-2',
        );

        await repository.save(transaction);

        final getResult = await repository.getById('tx-1');
        expect(getResult.isSuccess, true);
        expect(getResult.getSuccess().type, TransactionType.transfer);
        expect(getResult.getSuccess().toAccountId, 'acc-2');
      });

      test('saves income transaction', () async {
        final transaction = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.income,
          amount: 50000,
          description: 'Salary',
          date: testDate,
        );

        await repository.save(transaction);

        final getResult = await repository.getById('tx-1');
        expect(getResult.isSuccess, true);
        expect(getResult.getSuccess().type, TransactionType.income);
      });
    });

    group('delete', () {
      test('deletes an existing transaction', () async {
        final transaction = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.expense,
          amount: 150,
          description: 'Groceries',
          date: testDate,
        );

        await repository.save(transaction);
        final deleteResult = await repository.delete('tx-1');

        expect(deleteResult.isSuccess, true);

        final getResult = await repository.getById('tx-1');
        expect(getResult.isFailure, true);
      });
    });

    group('getAll', () {
      test('returns empty list when no transactions', () async {
        final result = await repository.getAll();

        expect(result.isSuccess, true);
        expect(result.getSuccess(), isEmpty);
      });

      test('returns all transactions ordered by date DESC', () async {
        final tx1 = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.expense,
          amount: 100,
          description: 'First',
          date: DateTime(2025, 1, 5),
        );
        final tx2 = TransactionEntity(
          id: 'tx-2',
          accountId: 'acc-1',
          type: TransactionType.expense,
          amount: 200,
          description: 'Second',
          date: DateTime(2025, 1, 10),
        );

        await repository.save(tx1);
        await repository.save(tx2);

        final result = await repository.getAll();

        expect(result.isSuccess, true);
        expect(result.getSuccess().length, 2);
        // Should be ordered by date DESC
        expect(result.getSuccess().first.id, 'tx-2');
      });
    });

    group('getById', () {
      test('returns transaction when exists', () async {
        final transaction = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.expense,
          amount: 150,
          description: 'Groceries',
          date: testDate,
        );

        await repository.save(transaction);

        final result = await repository.getById('tx-1');

        expect(result.isSuccess, true);
        expect(result.getSuccess().id, 'tx-1');
      });

      test('returns failure when transaction not found', () async {
        final result = await repository.getById('non-existent');

        expect(result.isFailure, true);
        expect(result.getFailure().message, 'Transaction not found');
      });
    });

    group('getByAccount', () {
      test('returns transactions for specific account', () async {
        final tx1 = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.expense,
          amount: 100,
          description: 'Account 1 expense',
          date: testDate,
        );
        final tx2 = TransactionEntity(
          id: 'tx-2',
          accountId: 'acc-2',
          type: TransactionType.expense,
          amount: 200,
          description: 'Account 2 expense',
          date: testDate,
        );

        await repository.save(tx1);
        await repository.save(tx2);

        final result = await repository.getByAccount('acc-1');

        expect(result.isSuccess, true);
        expect(result.getSuccess().length, 1);
        expect(result.getSuccess().first.accountId, 'acc-1');
      });

      test('includes transfers where account is destination', () async {
        final transfer = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.transfer,
          amount: 500,
          description: 'Transfer',
          date: testDate,
          toAccountId: 'acc-2',
        );

        await repository.save(transfer);

        // Should appear for both source and destination accounts
        final result1 = await repository.getByAccount('acc-1');
        final result2 = await repository.getByAccount('acc-2');

        expect(result1.getSuccess().length, 1);
        expect(result2.getSuccess().length, 1);
      });
    });

    group('watchAll', () {
      test('returns a stream', () {
        final stream = repository.watchAll();

        expect(stream, isA<Stream<List<TransactionEntity>>>());
      });

      test('stream can be listened to', () async {
        final stream = repository.watchAll();
        final subscription = stream.listen((_) {});

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await subscription.cancel();
      });
    });
  });
}
