import 'package:budget_core/budget_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InstallmentEntity', () {
    group('monthlyAmount', () {
      test('calculates correct monthly amount', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          startDate: DateTime(2025),
        );

        expect(installment.monthlyAmount, 1000);
      });

      test('returns 0 when totalInstallments is 0', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Item',
          totalAmount: 12000,
          totalInstallments: 0,
          startDate: DateTime(2025),
        );

        expect(installment.monthlyAmount, 0);
      });

      test('handles non-divisible amounts', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Item',
          totalAmount: 1000,
          totalInstallments: 3,
          startDate: DateTime(2025),
        );

        expect(installment.monthlyAmount, closeTo(333.33, 0.01));
      });
    });

    group('remainingInstallments', () {
      test('calculates correct remaining installments', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          paidInstallments: 5,
          startDate: DateTime(2025),
        );

        expect(installment.remainingInstallments, 7);
      });

      test('returns 0 when fully paid', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          paidInstallments: 12,
          startDate: DateTime(2025),
        );

        expect(installment.remainingInstallments, 0);
      });
    });

    group('remainingAmount', () {
      test('calculates correct remaining amount', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          paidInstallments: 4,
          startDate: DateTime(2025),
        );

        // 8 remaining x 1000 each = 8000
        expect(installment.remainingAmount, 8000);
      });
    });

    group('paidAmount', () {
      test('calculates correct paid amount', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          paidInstallments: 4,
          startDate: DateTime(2025),
        );

        // 4 paid x 1000 each = 4000
        expect(installment.paidAmount, 4000);
      });
    });

    group('isFullyPaid', () {
      test('returns false when not fully paid', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          paidInstallments: 5,
          startDate: DateTime(2025),
        );

        expect(installment.isFullyPaid, false);
      });

      test('returns true when fully paid', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          paidInstallments: 12,
          startDate: DateTime(2025),
        );

        expect(installment.isFullyPaid, true);
      });

      test('returns true when overpaid', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          paidInstallments: 15,
          startDate: DateTime(2025),
        );

        expect(installment.isFullyPaid, true);
      });
    });

    group('endDate', () {
      test('calculates correct end date for monthly frequency', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          startDate: DateTime(2025, 1, 15),
        );

        expect(installment.endDate, DateTime(2026, 1, 15));
      });

      test('calculates correct end date for quarterly frequency', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Item',
          totalAmount: 4000,
          totalInstallments: 4,
          startDate: DateTime(2025, 1, 15),
          frequency: InstallmentFrequency.quarterly,
        );

        // 4 quarters = 12 months
        expect(installment.endDate, DateTime(2026, 1, 15));
      });

      test('calculates correct end date for yearly frequency', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Car',
          totalAmount: 60000,
          totalInstallments: 5,
          startDate: DateTime(2025, 3, 10),
          frequency: InstallmentFrequency.yearly,
        );

        expect(installment.endDate, DateTime(2030, 3, 10));
      });
    });

    group('progressPercentage', () {
      test('returns 0 when no installments paid', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          startDate: DateTime(2025),
        );

        expect(installment.progressPercentage, 0);
      });

      test('returns correct percentage', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          paidInstallments: 6,
          startDate: DateTime(2025),
        );

        expect(installment.progressPercentage, 0.5);
      });

      test('returns 1.0 when fully paid', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          paidInstallments: 12,
          startDate: DateTime(2025),
        );

        expect(installment.progressPercentage, 1.0);
      });

      test('clamps to 1.0 when overpaid', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          paidInstallments: 15,
          startDate: DateTime(2025),
        );

        expect(installment.progressPercentage, 1.0);
      });

      test('returns 0 when totalInstallments is 0', () {
        final installment = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Item',
          totalAmount: 1000,
          totalInstallments: 0,
          startDate: DateTime(2025),
        );

        expect(installment.progressPercentage, 0);
      });
    });

    group('equality', () {
      test('two installments with same values are equal', () {
        final date = DateTime(2025);
        final installment1 = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          startDate: date,
        );

        final installment2 = InstallmentEntity(
          id: '1',
          accountId: 'acc1',
          description: 'Laptop',
          totalAmount: 12000,
          totalInstallments: 12,
          startDate: date,
        );

        expect(installment1, installment2);
      });
    });
  });
}
