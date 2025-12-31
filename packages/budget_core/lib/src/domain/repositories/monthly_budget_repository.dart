import 'package:budget_core/src/domain/entities/monthly_budget_entity.dart';
import 'package:flutter_core/flutter_core.dart';

/// Repository contract for monthly budget operations
abstract class MonthlyBudgetRepository {
  /// Save a monthly budget (create or update)
  FutureResult<void> save(MonthlyBudgetEntity budget);

  /// Delete a monthly budget by ID
  FutureResult<void> delete(String budgetId);

  /// Get all monthly budgets
  FutureResult<List<MonthlyBudgetEntity>> getAll();

  /// Get a monthly budget by ID
  FutureResult<MonthlyBudgetEntity> getById(String budgetId);

  /// Get budget for a specific month
  FutureResult<MonthlyBudgetEntity?> getByMonth(int year, int month);

  /// Get current month's budget
  FutureResult<MonthlyBudgetEntity?> getCurrentMonthBudget();

  /// Update spent amount for a budget
  FutureResult<void> updateSpentAmount(String budgetId, double amount);

  /// Watch all monthly budgets as a stream
  Stream<List<MonthlyBudgetEntity>> watchAll();

  /// Watch current month's budget
  Stream<MonthlyBudgetEntity?> watchCurrentMonth();
}
