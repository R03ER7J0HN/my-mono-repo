import 'dart:async';

import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/installments/installment_entry/cubit/installment_entry_state.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:uuid/uuid.dart';

class InstallmentEntryCubit extends Cubit<InstallmentEntryState>
    with SafeEmitMixin {
  InstallmentEntryCubit({
    required InstallmentRepository installmentRepository,
    required AccountRepository accountRepository,
    InstallmentEntity? existingInstallment,
  }) : _installmentRepository = installmentRepository,
       _accountRepository = accountRepository,
       super(
         existingInstallment != null
             ? InstallmentEntryState(
                 description: existingInstallment.description,
                 totalAmount: existingInstallment.totalAmount,
                 totalInstallments: existingInstallment.totalInstallments,
                 paidInstallments: existingInstallment.paidInstallments,
                 frequency: existingInstallment.frequency,
                 startDate: existingInstallment.startDate,
                 accountId: existingInstallment.accountId,
                 isValid: true,
                 existingInstallment: existingInstallment,
               )
             : const InstallmentEntryState(),
       ) {
    _init();
  }

  final InstallmentRepository _installmentRepository;
  final AccountRepository _accountRepository;
  StreamSubscription<List<AccountEntity>>? _subscription;

  void _init() {
    _subscription = _accountRepository.watchAll().listen(
      (accounts) {
        final creditCards = accounts
            .where((a) => a.type == AccountType.creditCard)
            .toList();
        safeEmit(
          state.copyWith(
            creditCardAccounts: creditCards,
            accountId: state.accountId ?? creditCards.firstOrNull?.id,
          ),
        );
      },
    );
  }

  void setDescription(String description) {
    safeEmit(
      state.copyWith(
        description: description,
        isValid: _validate(description: description),
      ),
    );
  }

  void setTotalAmount(double amount) {
    safeEmit(
      state.copyWith(
        totalAmount: amount,
        isValid: _validate(totalAmount: amount),
      ),
    );
  }

  void setTotalInstallments(int count) {
    safeEmit(
      state.copyWith(
        totalInstallments: count,
        isValid: _validate(totalInstallments: count),
      ),
    );
  }

  void setPaidInstallments(int count) {
    safeEmit(
      state.copyWith(
        paidInstallments: count.clamp(0, state.totalInstallments),
      ),
    );
  }

  void setFrequency(InstallmentFrequency frequency) {
    safeEmit(state.copyWith(frequency: frequency));
  }

  void setStartDate(DateTime date) {
    safeEmit(state.copyWith(startDate: date));
  }

  void setAccountId(String? accountId) {
    safeEmit(
      state.copyWith(
        accountId: accountId,
        isValid: _validate(accountId: accountId),
      ),
    );
  }

  bool _validate({
    String? description,
    double? totalAmount,
    int? totalInstallments,
    String? accountId,
  }) {
    final desc = description ?? state.description;
    final amount = totalAmount ?? state.totalAmount;
    final installments = totalInstallments ?? state.totalInstallments;
    final accId = accountId ?? state.accountId;

    if (desc.trim().isEmpty) return false;
    if (amount <= 0) return false;
    if (installments <= 0) return false;
    if (accId == null) return false;

    return true;
  }

  Future<bool> save() async {
    if (!state.isValid) return false;

    safeEmit(state.copyWith(isSaving: true, error: null));

    final installment = InstallmentEntity(
      id: state.existingInstallment?.id ?? const Uuid().v4(),
      accountId: state.accountId!,
      description: state.description.trim(),
      totalAmount: state.totalAmount,
      totalInstallments: state.totalInstallments,
      paidInstallments: state.paidInstallments,
      frequency: state.frequency,
      startDate: state.installmentStartDate,
      createdAt: state.existingInstallment?.createdAt ?? DateTime.now(),
    );

    final result = await _installmentRepository.save(installment);

    return result.fold(
      onFailure: (failure) {
        safeEmit(
          state.copyWith(
            isSaving: false,
            error: failure.message,
          ),
        );
        return false;
      },
      onSuccess: (_) {
        safeEmit(state.copyWith(isSaving: false));
        return true;
      },
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
