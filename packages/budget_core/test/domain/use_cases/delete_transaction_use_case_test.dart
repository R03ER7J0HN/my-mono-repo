import 'package:budget_core/budget_core.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_transaction_use_case_test.mocks.dart';

@GenerateMocks([TransactionRepository, AccountRepository])
void main() {
  late DeleteTransactionUseCase useCase;
  late MockTransactionRepository mockTransactionRepository;
  late MockAccountRepository mockAccountRepository;

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    mockAccountRepository = MockAccountRepository();
    useCase = DeleteTransactionUseCase(
      transactionRepository: mockTransactionRepository,
      accountRepository: mockAccountRepository,
    );
  });

  group('DeleteTransactionUseCase', () {
    final testDate = DateTime(2025, 1, 7);

    group('delete income transaction', () {
      test('reverses income effect and deletes transaction', () async {
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
          balance: 15000, // After income was applied
        );

        when(mockTransactionRepository.getById('tx-1')).thenAnswer(
          (_) async => Result.success(transaction),
        );
        when(mockAccountRepository.getById('acc-1')).thenAnswer(
          (_) async => Result.success(account),
        );
        when(mockAccountRepository.updateBalance('acc-1', any)).thenAnswer(
          (_) async => Result.success(null),
        );
        when(mockTransactionRepository.delete('tx-1')).thenAnswer(
          (_) async => Result.success(null),
        );

        final result = await useCase('tx-1');

        expect(result.isSuccess, true);
        // Reverse income: 15000 - 5000 = 10000
        verify(mockAccountRepository.updateBalance('acc-1', 10000)).called(1);
        verify(mockTransactionRepository.delete('tx-1')).called(1);
      });
    });

    group('delete expense transaction', () {
      test('reverses expense effect and deletes transaction', () async {
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
          balance: 9500, // After expense was applied
        );

        when(mockTransactionRepository.getById('tx-1')).thenAnswer(
          (_) async => Result.success(transaction),
        );
        when(mockAccountRepository.getById('acc-1')).thenAnswer(
          (_) async => Result.success(account),
        );
        when(mockAccountRepository.updateBalance('acc-1', any)).thenAnswer(
          (_) async => Result.success(null),
        );
        when(mockTransactionRepository.delete('tx-1')).thenAnswer(
          (_) async => Result.success(null),
        );

        final result = await useCase('tx-1');

        expect(result.isSuccess, true);
        // Reverse expense: 9500 + 500 = 10000
        verify(mockAccountRepository.updateBalance('acc-1', 10000)).called(1);
        verify(mockTransactionRepository.delete('tx-1')).called(1);
      });
    });

    group('delete transfer transaction', () {
      test(
        'reverses transfer on both accounts and deletes transaction',
        () async {
          final transaction = TransactionEntity(
            id: 'tx-1',
            accountId: 'acc-1',
            type: TransactionType.transfer,
            amount: 1000,
            description: 'Transfer',
            date: testDate,
            toAccountId: 'acc-2',
          );

          const sourceAccount = AccountEntity(
            id: 'acc-1',
            name: 'Cash',
            type: AccountType.cash,
            balance: 4000, // After transfer: 5000 - 1000
          );

          const destAccount = AccountEntity(
            id: 'acc-2',
            name: 'Savings',
            type: AccountType.savings,
            balance: 11000, // After transfer: 10000 + 1000
          );

          when(mockTransactionRepository.getById('tx-1')).thenAnswer(
            (_) async => Result.success(transaction),
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
          when(mockTransactionRepository.delete('tx-1')).thenAnswer(
            (_) async => Result.success(null),
          );

          final result = await useCase('tx-1');

          expect(result.isSuccess, true);
          // Reverse source: 4000 + 1000 = 5000
          verify(mockAccountRepository.updateBalance('acc-1', 5000)).called(1);
          // Reverse destination: 11000 - 1000 = 10000
          verify(mockAccountRepository.updateBalance('acc-2', 10000)).called(1);
          verify(mockTransactionRepository.delete('tx-1')).called(1);
        },
      );

      test(
        'handles transfer with missing destination account gracefully',
        () async {
          final transaction = TransactionEntity(
            id: 'tx-1',
            accountId: 'acc-1',
            type: TransactionType.transfer,
            amount: 1000,
            description: 'Transfer',
            date: testDate,
            toAccountId: 'acc-2',
          );

          const sourceAccount = AccountEntity(
            id: 'acc-1',
            name: 'Cash',
            type: AccountType.cash,
            balance: 4000,
          );

          when(mockTransactionRepository.getById('tx-1')).thenAnswer(
            (_) async => Result.success(transaction),
          );
          when(mockAccountRepository.getById('acc-1')).thenAnswer(
            (_) async => Result.success(sourceAccount),
          );
          when(mockAccountRepository.getById('acc-2')).thenAnswer(
            (_) async =>
                Result.failure(const GenericFailure('Account not found')),
          );
          when(mockAccountRepository.updateBalance('acc-1', any)).thenAnswer(
            (_) async => Result.success(null),
          );
          when(mockTransactionRepository.delete('tx-1')).thenAnswer(
            (_) async => Result.success(null),
          );

          final result = await useCase('tx-1');

          expect(result.isSuccess, true);
          // Source still reversed
          verify(mockAccountRepository.updateBalance('acc-1', 5000)).called(1);
          // Destination not updated (account not found)
          verifyNever(mockAccountRepository.updateBalance('acc-2', any));
          verify(mockTransactionRepository.delete('tx-1')).called(1);
        },
      );
    });

    group('failure scenarios', () {
      test('returns failure when transaction not found', () async {
        when(mockTransactionRepository.getById('tx-1')).thenAnswer(
          (_) async =>
              Result.failure(const GenericFailure('Transaction not found')),
        );

        final result = await useCase('tx-1');

        expect(result.isFailure, true);
        expect(result.getFailure().message, 'Transaction not found');
        verifyNever(mockAccountRepository.getById(any));
        verifyNever(mockTransactionRepository.delete(any));
      });

      test('returns failure when account not found for reversal', () async {
        final transaction = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.expense,
          amount: 100,
          description: 'Test',
          date: testDate,
        );

        when(mockTransactionRepository.getById('tx-1')).thenAnswer(
          (_) async => Result.success(transaction),
        );
        when(mockAccountRepository.getById('acc-1')).thenAnswer(
          (_) async =>
              Result.failure(const GenericFailure('Account not found')),
        );

        final result = await useCase('tx-1');

        expect(result.isFailure, true);
        verifyNever(mockTransactionRepository.delete(any));
      });

      test('returns failure when balance update fails', () async {
        final transaction = TransactionEntity(
          id: 'tx-1',
          accountId: 'acc-1',
          type: TransactionType.expense,
          amount: 100,
          description: 'Test',
          date: testDate,
        );

        const account = AccountEntity(
          id: 'acc-1',
          name: 'Cash',
          type: AccountType.cash,
          balance: 900,
        );

        when(mockTransactionRepository.getById('tx-1')).thenAnswer(
          (_) async => Result.success(transaction),
        );
        when(mockAccountRepository.getById('acc-1')).thenAnswer(
          (_) async => Result.success(account),
        );
        when(mockAccountRepository.updateBalance('acc-1', any)).thenAnswer(
          (_) async => Result.failure(const GenericFailure('Update failed')),
        );

        final result = await useCase('tx-1');

        expect(result.isFailure, true);
        verifyNever(mockTransactionRepository.delete(any));
      });
    });
  });
}
