import 'package:budget_core/budget_core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_database_helper.dart';

void main() {
  late LocalDataSource dataSource;
  late MonthlyBudgetRepositoryImpl repository;

  setUpAll(initializeTestDatabase);

  setUp(() async {
    final database = await createInMemoryDatabase();
    dataSource = LocalDataSource(database);
    repository = MonthlyBudgetRepositoryImpl(dataSource);
  });

  tearDown(() async {
    await dataSource.database.close();
  });

  group('MonthlyBudgetRepositoryImpl', () {
    group('save', () {
      test('saves a new budget successfully', () async {
        const budget = MonthlyBudgetEntity(
          id: 'budget-1',
          year: 2025,
          month: 1,
          totalBudget: 50000,
        );

        final result = await repository.save(budget);

        expect(result.isSuccess, true);

        final getResult = await repository.getById('budget-1');
        expect(getResult.isSuccess, true);
        expect(getResult.getSuccess().totalBudget, 50000);
        expect(getResult.getSuccess().year, 2025);
        expect(getResult.getSuccess().month, 1);
      });

      test('updates existing budget when id exists', () async {
        const budget = MonthlyBudgetEntity(
          id: 'budget-1',
          year: 2025,
          month: 1,
          totalBudget: 50000,
        );

        await repository.save(budget);

        const updated = MonthlyBudgetEntity(
          id: 'budget-1',
          year: 2025,
          month: 1,
          totalBudget: 60000,
          spentAmount: 15000,
        );

        await repository.save(updated);

        final getResult = await repository.getById('budget-1');
        expect(getResult.getSuccess().totalBudget, 60000);
        expect(getResult.getSuccess().spentAmount, 15000);
      });

      test('saves budget with optional fields', () async {
        const budget = MonthlyBudgetEntity(
          id: 'budget-1',
          year: 2025,
          month: 1,
          totalBudget: 50000,
          dailyBudget: 1500,
          notes: 'January budget with savings goal',
        );

        await repository.save(budget);

        final getResult = await repository.getById('budget-1');
        expect(getResult.isSuccess, true);
        expect(getResult.getSuccess().dailyBudget, 1500);
        expect(
          getResult.getSuccess().notes,
          'January budget with savings goal',
        );
      });
    });

    group('delete', () {
      test('deletes an existing budget', () async {
        const budget = MonthlyBudgetEntity(
          id: 'budget-1',
          year: 2025,
          month: 1,
          totalBudget: 50000,
        );

        await repository.save(budget);
        final deleteResult = await repository.delete('budget-1');

        expect(deleteResult.isSuccess, true);

        final getResult = await repository.getById('budget-1');
        expect(getResult.isFailure, true);
      });
    });

    group('getAll', () {
      test('returns empty list when no budgets', () async {
        final result = await repository.getAll();

        expect(result.isSuccess, true);
        expect(result.getSuccess(), isEmpty);
      });

      test('returns all budgets ordered by year and month DESC', () async {
        const budget1 = MonthlyBudgetEntity(
          id: 'budget-1',
          year: 2025,
          month: 1,
          totalBudget: 50000,
        );
        const budget2 = MonthlyBudgetEntity(
          id: 'budget-2',
          year: 2025,
          month: 2,
          totalBudget: 55000,
        );
        const budget3 = MonthlyBudgetEntity(
          id: 'budget-3',
          year: 2024,
          month: 12,
          totalBudget: 45000,
        );

        await repository.save(budget1);
        await repository.save(budget2);
        await repository.save(budget3);

        final result = await repository.getAll();

        expect(result.isSuccess, true);
        expect(result.getSuccess().length, 3);
        // Should be ordered: Feb 2025, Jan 2025, Dec 2024
        expect(result.getSuccess().first.month, 2);
        expect(result.getSuccess().last.year, 2024);
      });
    });

    group('getById', () {
      test('returns budget when exists', () async {
        const budget = MonthlyBudgetEntity(
          id: 'budget-1',
          year: 2025,
          month: 1,
          totalBudget: 50000,
        );

        await repository.save(budget);

        final result = await repository.getById('budget-1');

        expect(result.isSuccess, true);
        expect(result.getSuccess().id, 'budget-1');
      });

      test('returns failure when budget not found', () async {
        final result = await repository.getById('non-existent');

        expect(result.isFailure, true);
        expect(result.getFailure().message, 'Budget not found');
      });
    });

    group('getByMonth', () {
      test('returns budget for specific month', () async {
        const budget = MonthlyBudgetEntity(
          id: 'budget-1',
          year: 2025,
          month: 6,
          totalBudget: 50000,
        );

        await repository.save(budget);

        final result = await repository.getByMonth(2025, 6);

        expect(result.isSuccess, true);
        expect(result.getSuccess(), isNotNull);
        expect(result.getSuccess()!.month, 6);
        expect(result.getSuccess()!.year, 2025);
      });

      test('returns null when no budget for month', () async {
        final result = await repository.getByMonth(2025, 12);

        expect(result.isSuccess, true);
        expect(result.getSuccess(), isNull);
      });
    });

    group('updateSpentAmount', () {
      test('updates spent amount successfully', () async {
        const budget = MonthlyBudgetEntity(
          id: 'budget-1',
          year: 2025,
          month: 1,
          totalBudget: 50000,
        );

        await repository.save(budget);

        final result = await repository.updateSpentAmount('budget-1', 25000);

        expect(result.isSuccess, true);

        final getResult = await repository.getById('budget-1');
        expect(getResult.getSuccess().spentAmount, 25000);
      });

      test('updates updatedAt timestamp', () async {
        const budget = MonthlyBudgetEntity(
          id: 'budget-1',
          year: 2025,
          month: 1,
          totalBudget: 50000,
        );

        await repository.save(budget);

        await repository.updateSpentAmount('budget-1', 15000);

        final getResult = await repository.getById('budget-1');
        expect(getResult.getSuccess().updatedAt, isNotNull);
      });
    });

    group('watchAll', () {
      test('returns a stream', () {
        final stream = repository.watchAll();

        expect(stream, isA<Stream<List<MonthlyBudgetEntity>>>());
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
