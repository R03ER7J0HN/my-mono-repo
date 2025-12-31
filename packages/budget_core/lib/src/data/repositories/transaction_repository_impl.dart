import 'dart:async';

import 'package:budget_core/src/data/datasources/local_data_source.dart';
import 'package:budget_core/src/data/models/transaction_model.dart';
import 'package:budget_core/src/domain/entities/transaction_entity.dart';
import 'package:budget_core/src/domain/repositories/transaction_repository.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sqflite/sqflite.dart';

/// SQLite implementation of TransactionRepository
class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl(this._dataSource);

  final LocalDataSource _dataSource;

  final _controller = StreamController<List<TransactionEntity>>.broadcast();

  Database get _db => _dataSource.database;

  @override
  FutureResult<void> save(TransactionEntity transaction) async {
    try {
      final data = TransactionModel.fromEntity(transaction).toJson();

      await _db.insert(
        LocalDataSource.tableTransactions,
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
  FutureResult<void> delete(String transactionId) async {
    try {
      await _db.delete(
        LocalDataSource.tableTransactions,
        where: 'id = ?',
        whereArgs: [transactionId],
      );

      _notifyListeners();
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<List<TransactionEntity>> getAll() async {
    try {
      final maps = await _db.query(
        LocalDataSource.tableTransactions,
        orderBy: 'date DESC',
      );
      final entities = maps
          .map((m) => TransactionModel.fromJson(m).toEntity())
          .toList();
      return Result.success(entities);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<TransactionEntity> getById(String transactionId) async {
    try {
      final maps = await _db.query(
        LocalDataSource.tableTransactions,
        where: 'id = ?',
        whereArgs: [transactionId],
      );

      if (maps.isEmpty) {
        return Result.failure(const GenericFailure('Transaction not found'));
      }

      return Result.success(TransactionModel.fromJson(maps.first).toEntity());
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<List<TransactionEntity>> getByAccount(String accountId) async {
    try {
      final maps = await _db.query(
        LocalDataSource.tableTransactions,
        where: 'account_id = ? OR to_account_id = ?',
        whereArgs: [accountId, accountId],
        orderBy: 'date DESC',
      );
      final entities = maps
          .map((m) => TransactionModel.fromJson(m).toEntity())
          .toList();
      return Result.success(entities);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  Stream<List<TransactionEntity>> watchAll() {
    _notifyListeners();
    return _controller.stream;
  }

  void _notifyListeners() {
    unawaited(
      Future.microtask(() async {
        try {
          final maps = await _db.query(
            LocalDataSource.tableTransactions,
            orderBy: 'date DESC',
          );
          final entities = maps
              .map((m) => TransactionModel.fromJson(m).toEntity())
              .toList();
          _controller.add(entities);
        } on Exception {
          // Ignore errors in notification
        }
      }),
    );
  }

  void dispose() {
    unawaited(_controller.close());
  }
}
