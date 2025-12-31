import 'dart:async';

import 'package:budget_core/src/data/datasources/local_data_source.dart';
import 'package:budget_core/src/data/models/monthly_budget_model.dart';
import 'package:budget_core/src/domain/entities/monthly_budget_entity.dart';
import 'package:budget_core/src/domain/repositories/monthly_budget_repository.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sqflite/sqflite.dart';

/// SQLite implementation of MonthlyBudgetRepository
class MonthlyBudgetRepositoryImpl implements MonthlyBudgetRepository {
  MonthlyBudgetRepositoryImpl(this._dataSource);

  final LocalDataSource _dataSource;

  final _controller = StreamController<List<MonthlyBudgetEntity>>.broadcast();
  final _currentMonthController =
      StreamController<MonthlyBudgetEntity?>.broadcast();

  Database get _db => _dataSource.database;

  @override
  FutureResult<void> save(MonthlyBudgetEntity budget) async {
    try {
      final data = MonthlyBudgetModel.fromEntity(budget).toJson();

      await _db.insert(
        LocalDataSource.tableMonthlyBudgets,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      _notifyListeners();
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<void> delete(String budgetId) async {
    try {
      await _db.delete(
        LocalDataSource.tableMonthlyBudgets,
        where: 'id = ?',
        whereArgs: [budgetId],
      );

      _notifyListeners();
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<List<MonthlyBudgetEntity>> getAll() async {
    try {
      final maps = await _db.query(
        LocalDataSource.tableMonthlyBudgets,
        orderBy: 'year DESC, month DESC',
      );
      final entities = maps
          .map((m) => MonthlyBudgetModel.fromJson(m).toEntity())
          .toList();
      return Result.success(entities);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<MonthlyBudgetEntity> getById(String budgetId) async {
    try {
      final maps = await _db.query(
        LocalDataSource.tableMonthlyBudgets,
        where: 'id = ?',
        whereArgs: [budgetId],
      );

      if (maps.isEmpty) {
        return Result.failure(const GenericFailure('Budget not found'));
      }

      return Result.success(MonthlyBudgetModel.fromJson(maps.first).toEntity());
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<MonthlyBudgetEntity?> getByMonth(int year, int month) async {
    try {
      final maps = await _db.query(
        LocalDataSource.tableMonthlyBudgets,
        where: 'year = ? AND month = ?',
        whereArgs: [year, month],
      );

      if (maps.isEmpty) {
        return Result.success(null);
      }

      return Result.success(MonthlyBudgetModel.fromJson(maps.first).toEntity());
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<MonthlyBudgetEntity?> getCurrentMonthBudget() async {
    final now = DateTime.now();
    return getByMonth(now.year, now.month);
  }

  @override
  FutureResult<void> updateSpentAmount(String budgetId, double amount) async {
    try {
      await _db.update(
        LocalDataSource.tableMonthlyBudgets,
        {
          'spent_amount': amount,
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [budgetId],
      );

      _notifyListeners();
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  Stream<List<MonthlyBudgetEntity>> watchAll() {
    _notifyListeners();
    return _controller.stream;
  }

  @override
  Stream<MonthlyBudgetEntity?> watchCurrentMonth() {
    _notifyCurrentMonth();
    return _currentMonthController.stream;
  }

  void _notifyListeners() {
    unawaited(
      Future.microtask(() async {
        try {
          final maps = await _db.query(
            LocalDataSource.tableMonthlyBudgets,
            orderBy: 'year DESC, month DESC',
          );
          final entities = maps
              .map((m) => MonthlyBudgetModel.fromJson(m).toEntity())
              .toList();
          _controller.add(entities);
          _notifyCurrentMonth();
        } on Exception {
          // Ignore errors in notification
        }
      }),
    );
  }

  void _notifyCurrentMonth() {
    unawaited(
      Future.microtask(() async {
        try {
          final now = DateTime.now();
          final maps = await _db.query(
            LocalDataSource.tableMonthlyBudgets,
            where: 'year = ? AND month = ?',
            whereArgs: [now.year, now.month],
          );

          if (maps.isEmpty) {
            _currentMonthController.add(null);
          } else {
            _currentMonthController.add(
              MonthlyBudgetModel.fromJson(maps.first).toEntity(),
            );
          }
        } on Exception {
          // Ignore errors in notification
        }
      }),
    );
  }

  void dispose() {
    unawaited(_controller.close());
    unawaited(_currentMonthController.close());
  }
}
