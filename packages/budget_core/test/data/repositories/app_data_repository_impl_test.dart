import 'package:budget_core/budget_core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_database_helper.dart';

void main() {
  late LocalDataSource dataSource;
  late AppDataRepositoryImpl repository;

  setUpAll(initializeTestDatabase);

  setUp(() async {
    final database = await createInMemoryDatabase();
    dataSource = LocalDataSource(database);
    repository = AppDataRepositoryImpl(dataSource);
  });

  tearDown(() async {
    await dataSource.database.close();
  });

  group('AppDataRepositoryImpl', () {
    group('clearAllData', () {
      test('clears all accounts', () async {
        // Add some accounts
        final accountRepo = AccountRepositoryImpl(dataSource);
        const account = AccountEntity(
          id: 'acc-1',
          name: 'Test Account',
          balance: 1000,
          type: AccountType.cash,
        );
        await accountRepo.save(account);

        // Verify account exists
        var accounts = await accountRepo.getAll();
        expect(accounts.getSuccess().length, 1);

        // Clear all data
        await repository.clearAllData();

        // Verify account is cleared
        accounts = await accountRepo.getAll();
        expect(accounts.getSuccess(), isEmpty);
      });

      test('clears all transactions', () async {
        // Add account first (required for transaction)
        final accountRepo = AccountRepositoryImpl(dataSource);
        const account = AccountEntity(
          id: 'acc-1',
          name: 'Test Account',
          balance: 1000,
          type: AccountType.cash,
        );
        await accountRepo.save(account);

        // Add transaction
        final transactionRepo = TransactionRepositoryImpl(dataSource);
        final transaction = TransactionEntity(
          id: 'tx-1',
          amount: 100,
          type: TransactionType.expense,
          accountId: 'acc-1',
          description: 'Test expense',
          date: DateTime.now(),
        );
        await transactionRepo.save(transaction);

        // Verify transaction exists
        var transactions = await transactionRepo.getAll();
        expect(transactions.getSuccess().length, 1);

        // Clear all data
        await repository.clearAllData();

        // Verify transaction is cleared
        transactions = await transactionRepo.getAll();
        expect(transactions.getSuccess(), isEmpty);
      });

      test('clears all categories', () async {
        final categoryRepo = CategoryRepositoryImpl(dataSource);
        const category = CategoryEntity(
          id: 'cat-1',
          name: 'Test Category',
          iconCodePoint: 0xe59c,
          colorHex: '#FF5733',
        );
        await categoryRepo.save(category);

        // Verify category exists
        var categories = await categoryRepo.getAll();
        expect(categories.getSuccess().length, 1);

        // Clear all data
        await repository.clearAllData();

        // Verify user category is cleared (but default categories exist)
        categories = await categoryRepo.getAll();
        expect(
          categories.getSuccess().any((c) => c.id == 'cat-1'),
          false,
        );
      });

      test('clears all installments', () async {
        // Add account first (required for installment)
        final accountRepo = AccountRepositoryImpl(dataSource);
        const account = AccountEntity(
          id: 'acc-1',
          name: 'Test Account',
          balance: 1000,
          type: AccountType.cash,
        );
        await accountRepo.save(account);

        final installmentRepo = InstallmentRepositoryImpl(dataSource);
        final installment = InstallmentEntity(
          id: 'inst-1',
          description: 'Monthly Payment',
          accountId: 'acc-1',
          totalAmount: 12000,
          totalInstallments: 12,
          startDate: DateTime.now(),
        );
        await installmentRepo.save(installment);

        // Verify installment exists
        var installments = await installmentRepo.getAll();
        expect(installments.getSuccess().length, 1);

        // Clear all data
        await repository.clearAllData();

        // Verify installment is cleared
        installments = await installmentRepo.getAll();
        expect(installments.getSuccess(), isEmpty);
      });

      test('clears all monthly budgets', () async {
        final budgetRepo = MonthlyBudgetRepositoryImpl(dataSource);
        const budget = MonthlyBudgetEntity(
          id: 'budget-1',
          year: 2025,
          month: 1,
          totalBudget: 50000,
        );
        await budgetRepo.save(budget);

        // Verify budget exists
        var budgets = await budgetRepo.getAll();
        expect(budgets.getSuccess().length, 1);

        // Clear all data
        await repository.clearAllData();

        // Verify budget is cleared
        budgets = await budgetRepo.getAll();
        expect(budgets.getSuccess(), isEmpty);
      });

      test('clears all data types at once', () async {
        // Setup repositories
        final accountRepo = AccountRepositoryImpl(dataSource);
        final transactionRepo = TransactionRepositoryImpl(dataSource);
        final categoryRepo = CategoryRepositoryImpl(dataSource);
        final installmentRepo = InstallmentRepositoryImpl(dataSource);
        final budgetRepo = MonthlyBudgetRepositoryImpl(dataSource);

        // Add test data
        const account = AccountEntity(
          id: 'acc-1',
          name: 'Test Account',
          balance: 1000,
          type: AccountType.cash,
        );
        await accountRepo.save(account);

        final transaction = TransactionEntity(
          id: 'tx-1',
          amount: 100,
          type: TransactionType.expense,
          accountId: 'acc-1',
          description: 'Test expense',
          date: DateTime.now(),
        );
        await transactionRepo.save(transaction);

        const category = CategoryEntity(
          id: 'cat-1',
          name: 'Test Category',
          iconCodePoint: 0xe59c,
          colorHex: '#FF5733',
        );
        await categoryRepo.save(category);

        final installment = InstallmentEntity(
          id: 'inst-1',
          description: 'Monthly Payment',
          accountId: 'acc-1',
          totalAmount: 12000,
          totalInstallments: 12,
          startDate: DateTime.now(),
        );
        await installmentRepo.save(installment);

        const budget = MonthlyBudgetEntity(
          id: 'budget-1',
          year: 2025,
          month: 1,
          totalBudget: 50000,
        );
        await budgetRepo.save(budget);

        // Clear all data
        await repository.clearAllData();

        // Verify all data is cleared
        expect((await accountRepo.getAll()).getSuccess(), isEmpty);
        expect((await transactionRepo.getAll()).getSuccess(), isEmpty);
        expect((await installmentRepo.getAll()).getSuccess(), isEmpty);
        expect((await budgetRepo.getAll()).getSuccess(), isEmpty);
        // Categories have default system categories re-inserted
        expect(
          (await categoryRepo.getAll()).getSuccess().any(
            (c) => c.id == 'cat-1',
          ),
          false,
        );
      });
    });
  });
}
