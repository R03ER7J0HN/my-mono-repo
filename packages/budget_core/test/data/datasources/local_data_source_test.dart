import 'package:budget_core/budget_core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_database_helper.dart';

void main() {
  late LocalDataSource dataSource;

  setUpAll(initializeTestDatabase);

  setUp(() async {
    final database = await createInMemoryDatabase();
    dataSource = LocalDataSource(database);
  });

  tearDown(() async {
    await dataSource.database.close();
  });

  group('LocalDataSource', () {
    group('database', () {
      test('returns the database instance', () {
        expect(dataSource.database, isNotNull);
        expect(dataSource.database.isOpen, true);
      });
    });

    group('tables', () {
      test('creates accounts table', () async {
        final tables = await dataSource.database.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
          [LocalDataSource.tableAccounts],
        );
        expect(tables.length, 1);
      });

      test('creates transactions table', () async {
        final tables = await dataSource.database.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
          [LocalDataSource.tableTransactions],
        );
        expect(tables.length, 1);
      });

      test('creates installments table', () async {
        final tables = await dataSource.database.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
          [LocalDataSource.tableInstallments],
        );
        expect(tables.length, 1);
      });

      test('creates categories table', () async {
        final tables = await dataSource.database.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
          [LocalDataSource.tableCategories],
        );
        expect(tables.length, 1);
      });

      test('creates monthly_budgets table', () async {
        final tables = await dataSource.database.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
          [LocalDataSource.tableMonthlyBudgets],
        );
        expect(tables.length, 1);
      });
    });

    group('clearAllData', () {
      test('clears all tables', () async {
        // Insert data into each table
        await dataSource.database.insert(LocalDataSource.tableAccounts, {
          'id': 'acc-1',
          'name': 'Test Account',
          'type': 'cash',
          'balance': 1000.0,
        });

        await dataSource.database.insert(LocalDataSource.tableCategories, {
          'id': 'cat-custom',
          'name': 'Custom Category',
          'icon_code_point': 12345,
          'color_hex': '#FF0000',
          'is_system': 0,
        });

        await dataSource.database.insert(LocalDataSource.tableMonthlyBudgets, {
          'id': 'budget-1',
          'year': 2025,
          'month': 1,
          'total_budget': 50000.0,
          'spent_amount': 0.0,
        });

        // Clear all data
        await dataSource.clearAllData();

        // Verify tables are empty
        final accounts = await dataSource.database.query(
          LocalDataSource.tableAccounts,
        );
        expect(accounts, isEmpty);

        final transactions = await dataSource.database.query(
          LocalDataSource.tableTransactions,
        );
        expect(transactions, isEmpty);

        final installments = await dataSource.database.query(
          LocalDataSource.tableInstallments,
        );
        expect(installments, isEmpty);

        final budgets = await dataSource.database.query(
          LocalDataSource.tableMonthlyBudgets,
        );
        expect(budgets, isEmpty);
      });

      test('re-inserts default categories after clear', () async {
        // Clear all data
        await dataSource.clearAllData();

        // Check that default categories are re-inserted
        final categories = await dataSource.database.query(
          LocalDataSource.tableCategories,
          where: 'is_system = ?',
          whereArgs: [1],
        );

        // Should have default system categories
        expect(categories, isNotEmpty);
        expect(
          categories.any((c) => c['id'] == 'cat_food'),
          true,
        );
        expect(
          categories.any((c) => c['id'] == 'cat_transport'),
          true,
        );
        expect(
          categories.any((c) => c['id'] == 'cat_shopping'),
          true,
        );
        expect(
          categories.any((c) => c['id'] == 'cat_entertainment'),
          true,
        );
        expect(
          categories.any((c) => c['id'] == 'cat_bills'),
          true,
        );
        expect(
          categories.any((c) => c['id'] == 'cat_health'),
          true,
        );
        expect(
          categories.any((c) => c['id'] == 'cat_salary'),
          true,
        );
        expect(
          categories.any((c) => c['id'] == 'cat_other'),
          true,
        );
      });
    });

    group('close', () {
      test('closes the database connection', () async {
        final database = await createInMemoryDatabase();
        final ds = LocalDataSource(database);

        expect(ds.database.isOpen, true);

        await ds.close();

        expect(ds.database.isOpen, false);
      });
    });
  });
}
