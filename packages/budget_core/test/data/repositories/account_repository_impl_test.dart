import 'package:budget_core/budget_core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_database_helper.dart';

void main() {
  late LocalDataSource dataSource;
  late AccountRepositoryImpl repository;

  setUpAll(initializeTestDatabase);

  setUp(() async {
    final database = await createInMemoryDatabase();
    dataSource = LocalDataSource(database);
    repository = AccountRepositoryImpl(dataSource);
  });

  tearDown(() async {
    await dataSource.database.close();
  });

  group('AccountRepositoryImpl', () {
    group('save', () {
      test('saves a new account successfully', () async {
        const account = AccountEntity(
          id: 'acc-1',
          name: 'Cash Wallet',
          type: AccountType.cash,
          balance: 1000,
        );

        final result = await repository.save(account);

        expect(result.isSuccess, true);

        // Verify it was saved
        final getResult = await repository.getById('acc-1');
        expect(getResult.isSuccess, true);
        expect(getResult.getSuccess().name, 'Cash Wallet');
        expect(getResult.getSuccess().balance, 1000);
      });

      test('updates existing account when id exists', () async {
        const account = AccountEntity(
          id: 'acc-1',
          name: 'Cash Wallet',
          type: AccountType.cash,
          balance: 1000,
        );

        await repository.save(account);

        const updatedAccount = AccountEntity(
          id: 'acc-1',
          name: 'Updated Wallet',
          type: AccountType.cash,
          balance: 2000,
        );

        final result = await repository.save(updatedAccount);

        expect(result.isSuccess, true);

        final getResult = await repository.getById('acc-1');
        expect(getResult.getSuccess().name, 'Updated Wallet');
        expect(getResult.getSuccess().balance, 2000);
      });

      test('saves credit card with credit limit', () async {
        const account = AccountEntity(
          id: 'cc-1',
          name: 'My Credit Card',
          type: AccountType.creditCard,
          balance: -5000,
          creditLimit: 50000,
        );

        await repository.save(account);

        final getResult = await repository.getById('cc-1');
        expect(getResult.isSuccess, true);
        expect(getResult.getSuccess().type, AccountType.creditCard);
        expect(getResult.getSuccess().creditLimit, 50000);
        expect(getResult.getSuccess().balance, -5000);
      });
    });

    group('delete', () {
      test('deletes an existing account', () async {
        const account = AccountEntity(
          id: 'acc-1',
          name: 'Cash Wallet',
          type: AccountType.cash,
          balance: 1000,
        );

        await repository.save(account);
        final deleteResult = await repository.delete('acc-1');

        expect(deleteResult.isSuccess, true);

        final getResult = await repository.getById('acc-1');
        expect(getResult.isFailure, true);
      });

      test('succeeds even when account does not exist', () async {
        final result = await repository.delete('non-existent');
        expect(result.isSuccess, true);
      });
    });

    group('getAll', () {
      test('returns empty list when no accounts', () async {
        final result = await repository.getAll();

        expect(result.isSuccess, true);
        expect(result.getSuccess(), isEmpty);
      });

      test('returns all saved accounts', () async {
        const account1 = AccountEntity(
          id: 'acc-1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 1000,
        );
        const account2 = AccountEntity(
          id: 'acc-2',
          name: 'Card',
          type: AccountType.debitCard,
          balance: 5000,
        );

        await repository.save(account1);
        await repository.save(account2);

        final result = await repository.getAll();

        expect(result.isSuccess, true);
        expect(result.getSuccess().length, 2);
      });
    });

    group('getById', () {
      test('returns account when exists', () async {
        const account = AccountEntity(
          id: 'acc-1',
          name: 'Cash Wallet',
          type: AccountType.cash,
          balance: 1000,
        );

        await repository.save(account);

        final result = await repository.getById('acc-1');

        expect(result.isSuccess, true);
        expect(result.getSuccess().id, 'acc-1');
        expect(result.getSuccess().name, 'Cash Wallet');
      });

      test('returns failure when account not found', () async {
        final result = await repository.getById('non-existent');

        expect(result.isFailure, true);
        expect(result.getFailure().message, 'Account not found');
      });
    });

    group('updateBalance', () {
      test('updates balance successfully', () async {
        const account = AccountEntity(
          id: 'acc-1',
          name: 'Cash Wallet',
          type: AccountType.cash,
          balance: 1000,
        );

        await repository.save(account);

        final result = await repository.updateBalance('acc-1', 2500);

        expect(result.isSuccess, true);

        final getResult = await repository.getById('acc-1');
        expect(getResult.getSuccess().balance, 2500);
      });

      test('succeeds with negative balance', () async {
        const account = AccountEntity(
          id: 'acc-1',
          name: 'Credit Card',
          type: AccountType.creditCard,
        );

        await repository.save(account);

        final result = await repository.updateBalance('acc-1', -5000);

        expect(result.isSuccess, true);

        final getResult = await repository.getById('acc-1');
        expect(getResult.getSuccess().balance, -5000);
      });
    });

    group('watchAll', () {
      test('returns a stream', () {
        final stream = repository.watchAll();

        expect(stream, isA<Stream<List<AccountEntity>>>());
      });

      test('stream can be listened to', () async {
        final stream = repository.watchAll();
        final subscription = stream.listen((_) {});

        // Give time for initial emission
        await Future<void>.delayed(const Duration(milliseconds: 100));

        await subscription.cancel();
      });
    });
  });
}
