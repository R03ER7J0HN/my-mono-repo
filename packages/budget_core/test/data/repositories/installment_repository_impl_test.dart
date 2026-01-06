import 'package:budget_core/budget_core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_database_helper.dart';

void main() {
  late LocalDataSource dataSource;
  late InstallmentRepositoryImpl repository;

  setUpAll(initializeTestDatabase);

  setUp(() async {
    final database = await createInMemoryDatabase();
    dataSource = LocalDataSource(database);
    repository = InstallmentRepositoryImpl(dataSource);
  });

  tearDown(() async {
    await dataSource.database.close();
  });

  group('InstallmentRepositoryImpl', () {
    final startDate = DateTime(2025);

    group('save', () {
      test('saves a new installment successfully', () async {
        final installment = InstallmentEntity(
          id: 'inst-1',
          accountId: 'acc-1',
          description: 'Laptop Purchase',
          totalAmount: 60000,
          totalInstallments: 12,
          startDate: startDate,
        );

        final result = await repository.save(installment);

        expect(result.isSuccess, true);

        final getResult = await repository.getById('inst-1');
        expect(getResult.isSuccess, true);
        expect(getResult.getSuccess().description, 'Laptop Purchase');
        expect(getResult.getSuccess().totalAmount, 60000);
        expect(getResult.getSuccess().totalInstallments, 12);
      });

      test('updates existing installment when id exists', () async {
        final installment = InstallmentEntity(
          id: 'inst-1',
          accountId: 'acc-1',
          description: 'Laptop',
          totalAmount: 60000,
          totalInstallments: 12,
          startDate: startDate,
        );

        await repository.save(installment);

        final updated = InstallmentEntity(
          id: 'inst-1',
          accountId: 'acc-1',
          description: 'Updated Laptop',
          totalAmount: 65000,
          totalInstallments: 12,
          paidInstallments: 3,
          startDate: startDate,
        );

        await repository.save(updated);

        final getResult = await repository.getById('inst-1');
        expect(getResult.getSuccess().description, 'Updated Laptop');
        expect(getResult.getSuccess().totalAmount, 65000);
        expect(getResult.getSuccess().paidInstallments, 3);
      });

      test('saves installment with different frequencies', () async {
        final quarterly = InstallmentEntity(
          id: 'inst-q',
          accountId: 'acc-1',
          description: 'Quarterly Payment',
          totalAmount: 12000,
          totalInstallments: 4,
          startDate: startDate,
          frequency: InstallmentFrequency.quarterly,
        );

        await repository.save(quarterly);

        final getResult = await repository.getById('inst-q');
        expect(getResult.isSuccess, true);
        expect(
          getResult.getSuccess().frequency,
          InstallmentFrequency.quarterly,
        );
      });
    });

    group('delete', () {
      test('deletes an existing installment', () async {
        final installment = InstallmentEntity(
          id: 'inst-1',
          accountId: 'acc-1',
          description: 'Laptop',
          totalAmount: 60000,
          totalInstallments: 12,
          startDate: startDate,
        );

        await repository.save(installment);
        final deleteResult = await repository.delete('inst-1');

        expect(deleteResult.isSuccess, true);

        final getResult = await repository.getById('inst-1');
        expect(getResult.isFailure, true);
      });
    });

    group('getAll', () {
      test('returns empty list when no installments', () async {
        final result = await repository.getAll();

        expect(result.isSuccess, true);
        expect(result.getSuccess(), isEmpty);
      });

      test('returns all installments', () async {
        final inst1 = InstallmentEntity(
          id: 'inst-1',
          accountId: 'acc-1',
          description: 'Laptop',
          totalAmount: 60000,
          totalInstallments: 12,
          startDate: startDate,
        );
        final inst2 = InstallmentEntity(
          id: 'inst-2',
          accountId: 'acc-1',
          description: 'Phone',
          totalAmount: 30000,
          totalInstallments: 6,
          startDate: startDate,
        );

        await repository.save(inst1);
        await repository.save(inst2);

        final result = await repository.getAll();

        expect(result.isSuccess, true);
        expect(result.getSuccess().length, 2);
      });
    });

    group('getById', () {
      test('returns installment when exists', () async {
        final installment = InstallmentEntity(
          id: 'inst-1',
          accountId: 'acc-1',
          description: 'Laptop',
          totalAmount: 60000,
          totalInstallments: 12,
          startDate: startDate,
        );

        await repository.save(installment);

        final result = await repository.getById('inst-1');

        expect(result.isSuccess, true);
        expect(result.getSuccess().id, 'inst-1');
      });

      test('returns failure when installment not found', () async {
        final result = await repository.getById('non-existent');

        expect(result.isFailure, true);
        expect(result.getFailure().message, 'Installment not found');
      });
    });

    group('getByAccount', () {
      test('returns installments for specific account', () async {
        final inst1 = InstallmentEntity(
          id: 'inst-1',
          accountId: 'acc-1',
          description: 'Laptop',
          totalAmount: 60000,
          totalInstallments: 12,
          startDate: startDate,
        );
        final inst2 = InstallmentEntity(
          id: 'inst-2',
          accountId: 'acc-2',
          description: 'Phone',
          totalAmount: 30000,
          totalInstallments: 6,
          startDate: startDate,
        );

        await repository.save(inst1);
        await repository.save(inst2);

        final result = await repository.getByAccount('acc-1');

        expect(result.isSuccess, true);
        expect(result.getSuccess().length, 1);
        expect(result.getSuccess().first.accountId, 'acc-1');
      });

      test('returns empty list when account has no installments', () async {
        final result = await repository.getByAccount('acc-no-inst');

        expect(result.isSuccess, true);
        expect(result.getSuccess(), isEmpty);
      });
    });

    group('watchAll', () {
      test('returns a stream', () {
        final stream = repository.watchAll();

        expect(stream, isA<Stream<List<InstallmentEntity>>>());
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
