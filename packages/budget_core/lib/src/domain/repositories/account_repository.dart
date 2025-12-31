import 'package:budget_core/src/domain/entities/account_entity.dart';
import 'package:flutter_core/flutter_core.dart';

/// Repository contract for account operations
abstract class AccountRepository {
  /// Save (create or update) an account
  FutureResult<void> save(AccountEntity account);

  /// Delete an account by ID
  FutureResult<void> delete(String accountId);

  /// Get all accounts
  FutureResult<List<AccountEntity>> getAll();

  /// Get account by ID
  FutureResult<AccountEntity> getById(String accountId);

  /// Watch all accounts (real-time stream)
  Stream<List<AccountEntity>> watchAll();

  /// Update account balance
  FutureResult<void> updateBalance(String accountId, double newBalance);
}
