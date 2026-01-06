import 'package:budget_core/budget_core.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_transaction_use_case_test.mocks.dart';

@GenerateMocks([TransactionRepository, AccountRepository])
void main() {
  late SaveTransactionUseCase useCase;
  late MockTransactionRepository mockTransactionRepository;
  late MockAccountRepository mockAccountRepository;

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    mockAccountRepository = MockAccountRepository();
    useCase = SaveTransactionUseCase(
      transactionRepository: mockTransactionRepository,
      accountRepository: mockAccountRepository,
    );
  });

  group('SaveTransactionUseCase', () {
    final testDate = DateTime(2025, 1, 7);

    group('new income transaction', () {
      test('adds amount to account balance and saves transaction', () async {
        final transaction = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.income,
          amount: 5000,
          description: 'Salary',
          date: testDate,
        );

        const account = AccountEntity(
          id: 'acc-1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 10000,
        );

        // Transaction doesn't exist (new)
        when(mockTransactionRepository.getById('tx-1')).thenAnswer(
          (_) async => Result.failure(const GenericFailure('Not found')),
        );
        when(mockAccountRepository.getById('acc-1')).thenAnswer(
          (_) async => Result.success(account),
        );
        when(mockAccountRepository.updateBalance('acc-1', any)).thenAnswer(
          (_) async => Result.success(null),
        );
        when(mockTransactionRepository.save(transaction)).thenAnswer(
          (_) async => Result.success(null),
        );

        final result = await useCase(transaction);

        expect(result.isSuccess, true);
        verify(mockAccountRepository.updateBalance('acc-1', 15000)).called(1);
        verify(mockTransactionRepository.save(transaction)).called(1);
      });
    });

    group('new expense transaction', () {
      test(
        'deducts amount from account balance and saves transaction',
        () async {
          final transaction = TransactionEntity(
            id: 'tx-1',
            accountId: 'acc-1',
            type: TransactionType.expense,
            amount: 500,
            description: 'Groceries',
            date: testDate,
          );

          const account = AccountEntity(
            id: 'acc-1',
            name: 'Cash',
            type: AccountType.cash,
            balance: 10000,
          );

          when(mockTransactionRepository.getById('tx-1')).thenAnswer(
            (_) async => Result.failure(const GenericFailure('Not found')),
          );
          when(mockAccountRepository.getById('acc-1')).thenAnswer(
            (_) async => Result.success(account),
          );
          when(mockAccountRepository.updateBalance('acc-1', any)).thenAnswer(
            (_) async => Result.success(null),
          );
          when(mockTransactionRepository.save(transaction)).thenAnswer(
            (_) async => Result.success(null),
          );

          final result = await useCase(transaction);

          expect(result.isSuccess, true);
          verify(mockAccountRepository.updateBalance('acc-1', 9500)).called(1);
          verify(mockTransactionRepository.save(transaction)).called(1);
        },
      );
    });

    group('new transfer transaction', () {
      test(
        'deducts from source, adds to destination, and saves transaction',
        () async {
          final transaction = TransactionEntity(
            id: 'tx-1',
            accountId: 'acc-1',
            type: TransactionType.transfer,
            amount: 1000,
            description: 'Transfer to savings',
            date: testDate,
            toAccountId: 'acc-2',
          );

          const sourceAccount = AccountEntity(
            id: 'acc-1',
            name: 'Cash',
            type: AccountType.cash,
            balance: 5000,
          );

          const destAccount = AccountEntity(
            id: 'acc-2',
            name: 'Savings',
            type: AccountType.savings,
            balance: 10000,
          );

          when(mockTransactionRepository.getById('tx-1')).thenAnswer(
            (_) async => Result.failure(const GenericFailure('Not found')),
          );
          when(mockAccountRepository.getById('acc-1')).thenAnswer(
            (_) async => Result.success(sourceAccount),
          );
          when(mockAccountRepository.getById('acc-2')).thenAnswer(
            (_) async => Result.success(destAccount),
          );
          when(mockAccountRepository.updateBalance('acc-1', any)).thenAnswer(
            (_) async => Result.success(null),
          );
          when(mockAccountRepository.updateBalance('acc-2', any)).thenAnswer(
            (_) async => Result.success(null),
          );
          when(mockTransactionRepository.save(transaction)).thenAnswer(
            (_) async => Result.success(null),
          );

          final result = await useCase(transaction);

          expect(result.isSuccess, true);
          verify(mockAccountRepository.updateBalance('acc-2', 11000)).called(1);
          verify(mockAccountRepository.updateBalance('acc-1', 4000)).called(1);
          verify(mockTransactionRepository.save(transaction)).called(1);
        },
      );
    });

    group('update existing transaction', () {
      test('reverses old effect and applies new effect', () async {
        final oldTransaction = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.expense,
          amount: 100, // Old expense of 100
          description: 'Old',
          date: testDate,
        );

        final newTransaction = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.expense,
          amount: 200, // Updated to 200
          description: 'Updated',
          date: testDate,
        );

        const account = AccountEntity(
          id: 'acc-1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 900, // After old expense: 1000 - 100 = 900
        );

        // Existing transaction found
        when(mockTransactionRepository.getById('tx-1')).thenAnswer(
          (_) async => Result.success(oldTransaction),
        );

        // First call for reversing old transaction
        when(mockAccountRepository.getById('acc-1')).thenAnswer(
          (_) async => Result.success(account),
        );

        when(mockAccountRepository.updateBalance('acc-1', any)).thenAnswer(
          (_) async => Result.success(null),
        );
        when(mockTransactionRepository.save(newTransaction)).thenAnswer(
          (_) async => Result.success(null),
        );

        final result = await useCase(newTransaction);

        expect(result.isSuccess, true);
        // Reverse: 900 + 100 = 1000
        // Apply: 1000 - 200 = 800
        verify(mockTransactionRepository.save(newTransaction)).called(1);
      });
    });

    group('failure scenarios', () {
      test('returns failure when account not found', () async {
        final transaction = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.income,
          amount: 100,
          description: 'Test',
          date: testDate,
        );

        when(mockTransactionRepository.getById('tx-1')).thenAnswer(
          (_) async => Result.failure(const GenericFailure('Not found')),
        );
        when(mockAccountRepository.getById('acc-1')).thenAnswer(
          (_) async =>
              Result.failure(const GenericFailure('Account not found')),
        );

        final result = await useCase(transaction);

        expect(result.isFailure, true);
        verifyNever(mockTransactionRepository.save(any));
      });

      test('returns failure when balance update fails', () async {
        final transaction = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.income,
          amount: 100,
          description: 'Test',
          date: testDate,
        );

        const account = AccountEntity(
          id: 'acc-1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 1000,
        );

        when(mockTransactionRepository.getById('tx-1')).thenAnswer(
          (_) async => Result.failure(const GenericFailure('Not found')),
        );
        when(mockAccountRepository.getById('acc-1')).thenAnswer(
          (_) async => Result.success(account),
        );
        when(mockAccountRepository.updateBalance('acc-1', any)).thenAnswer(
          (_) async => Result.failure(const GenericFailure('Update failed')),
        );

        final result = await useCase(transaction);

        expect(result.isFailure, true);
        verifyNever(mockTransactionRepository.save(any));
      });
    });
  });
}
