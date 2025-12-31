import 'dart:async';

import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/installments/cubit/installments_state.dart';
import 'package:flutter_core/flutter_core.dart';

class InstallmentsCubit extends Cubit<InstallmentsState> with SafeEmitMixin {
  InstallmentsCubit({
    required InstallmentRepository installmentRepository,
    required AccountRepository accountRepository,
  }) : _installmentRepository = installmentRepository,
       _accountRepository = accountRepository,
       super(const InstallmentsState()) {
    _init();
  }

  final InstallmentRepository _installmentRepository;
  final AccountRepository _accountRepository;
  StreamSubscription<List<InstallmentEntity>>? _installmentSubscription;
  StreamSubscription<List<AccountEntity>>? _accountSubscription;

  void _init() {
    _installmentSubscription = _installmentRepository.watchAll().listen(
      (installments) {
        safeEmit(
          state.copyWith(
            installments: installments,
            isLoading: false,
          ),
        );
      },
      onError: (Object error) {
        safeEmit(
          state.copyWith(
            error: error.toString(),
            isLoading: false,
          ),
        );
      },
    );

    _accountSubscription = _accountRepository.watchAll().listen(
      (accounts) {
        safeEmit(state.copyWith(accounts: accounts));
      },
    );
  }

  void setFilterAccountId(String? accountId) {
    safeEmit(state.copyWith(filterAccountId: accountId));
  }

  Future<void> markPaymentMade(String installmentId) async {
    final installment = state.installments.firstWhere(
      (i) => i.id == installmentId,
    );

    final updated = installment.copyWith(
      paidInstallments: installment.paidInstallments + 1,
    );

    final result = await _installmentRepository.save(updated);
    result.fold(
      onFailure: (failure) {
        safeEmit(state.copyWith(error: failure.message));
      },
      onSuccess: (_) {},
    );
  }

  Future<void> deleteInstallment(String id) async {
    final result = await _installmentRepository.delete(id);
    result.fold(
      onFailure: (failure) {
        safeEmit(state.copyWith(error: failure.message));
      },
      onSuccess: (_) {},
    );
  }

  @override
  Future<void> close() async {
    await _installmentSubscription?.cancel();
    await _accountSubscription?.cancel();
    return super.close();
  }
}
