import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/accounts/account_entry/cubit/account_entry_state.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:uuid/uuid.dart';

class AccountEntryCubit extends Cubit<AccountEntryState> with SafeEmitMixin {
  AccountEntryCubit({
    required AccountRepository accountRepository,
    AccountEntity? existingAccount,
  }) : _accountRepository = accountRepository,
       super(
         existingAccount != null
             ? AccountEntryState(
                 name: existingAccount.name,
                 type: existingAccount.type,
                 balance: existingAccount.balance,
                 creditLimit: existingAccount.creditLimit,
                 budgetLimit: existingAccount.budgetLimit,
                 isValid: true,
                 existingAccount: existingAccount,
               )
             : const AccountEntryState(),
       );

  final AccountRepository _accountRepository;

  void setName(String name) {
    safeEmit(
      state.copyWith(
        name: name,
        isValid: _validate(name: name),
      ),
    );
  }

  void setType(AccountType type) {
    safeEmit(
      state.copyWith(
        type: type,
        creditLimit: type == AccountType.creditCard ? state.creditLimit : null,
      ),
    );
  }

  void setBalance(double balance) {
    safeEmit(state.copyWith(balance: balance));
  }

  void setCreditLimit(double? limit) {
    safeEmit(state.copyWith(creditLimit: limit));
  }

  void setBudgetLimit(double? limit) {
    safeEmit(state.copyWith(budgetLimit: limit));
  }

  bool _validate({String? name}) {
    final accountName = name ?? state.name;
    return accountName.trim().isNotEmpty;
  }

  Future<bool> save() async {
    if (!state.isValid) return false;

    safeEmit(state.copyWith(isSaving: true, error: null));

    final account = AccountEntity(
      id: state.existingAccount?.id ?? const Uuid().v4(),
      name: state.name.trim(),
      type: state.type,
      balance: state.balance,
      creditLimit: state.type == AccountType.creditCard
          ? state.creditLimit
          : null,
      budgetLimit: state.budgetLimit,
      createdAt: state.existingAccount?.createdAt ?? DateTime.now(),
    );

    final result = await _accountRepository.save(account);

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
}
