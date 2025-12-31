import 'package:budget_core/src/domain/entities/installment_entity.dart';
import 'package:flutter_core/flutter_core.dart';

/// Repository contract for installment operations
abstract class InstallmentRepository {
  /// Save (create or update) an installment plan
  FutureResult<void> save(InstallmentEntity installment);

  /// Delete an installment by ID
  FutureResult<void> delete(String installmentId);

  /// Get all installments
  FutureResult<List<InstallmentEntity>> getAll();

  /// Get installment by ID
  FutureResult<InstallmentEntity> getById(String installmentId);

  /// Get installments for a specific account (credit card)
  FutureResult<List<InstallmentEntity>> getByAccount(String accountId);

  /// Watch all installments (real-time stream)
  Stream<List<InstallmentEntity>> watchAll();
}
