import 'dart:async';

import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/accounts/cubit/accounts_state.dart';
import 'package:flutter_core/flutter_core.dart';

class AccountsCubit extends Cubit<AccountsState> with SafeEmitMixin {
  AccountsCubit({
    required AccountRepository accountRepository,
    required TransactionRepository transactionRepository,
  }) : _accountRepository = accountRepository,
       _transactionRepository = transactionRepository,
       super(const AccountsState()) {
    _init();
  }

  final AccountRepository _accountRepository;
  final TransactionRepository _transactionRepository;
  StreamSubscription<List<AccountEntity>>? _accountSubscription;
  StreamSubscription<List<TransactionEntity>>? _transactionSubscription;

  void _init() {
    _accountSubscription = _accountRepository.watchAll().listen(
      (accounts) {
        safeEmit(
          state.copyWith(
            accounts: accounts,
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

    _transactionSubscription = _transactionRepository.watchAll().listen(
      (transactions) {
        safeEmit(state.copyWith(transactions: transactions));
      },
    );
  }

  void setFilter(AccountType? type) {
    safeEmit(state.copyWith(filterType: type));
  }

  Future<void> deleteAccount(String id) async {
    final result = await _accountRepository.delete(id);
    result.fold(
      onFailure: (failure) {
        safeEmit(state.copyWith(error: failure.message));
      },
      onSuccess: (_) {},
    );
  }

  @override
  Future<void> close() async {
    await _accountSubscription?.cancel();
    await _transactionSubscription?.cancel();
    return super.close();
  }
}
