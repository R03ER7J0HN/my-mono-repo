import 'dart:async';

import 'package:budget_core/src/data/datasources/local_data_source.dart';
import 'package:budget_core/src/data/models/account_model.dart';
import 'package:budget_core/src/domain/entities/account_entity.dart';
import 'package:budget_core/src/domain/repositories/account_repository.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sqflite/sqflite.dart';

/// SQLite implementation of AccountRepository
class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(this._dataSource);

  final LocalDataSource _dataSource;

  final _controller = StreamController<List<AccountEntity>>.broadcast();

  Database get _db => _dataSource.database;

  @override
  FutureResult<void> save(AccountEntity account) async {
    try {
      final data = AccountModel.fromEntity(account).toJson();

      await _db.insert(
        LocalDataSource.tableAccounts,
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
  FutureResult<void> delete(String accountId) async {
    try {
      await _db.delete(
        LocalDataSource.tableAccounts,
        where: 'id = ?',
        whereArgs: [accountId],
      );

      _notifyListeners();
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<List<AccountEntity>> getAll() async {
    try {
      final maps = await _db.query(LocalDataSource.tableAccounts);
      final entities = maps
          .map((m) => AccountModel.fromJson(m).toEntity())
          .toList();
      return Result.success(entities);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<AccountEntity> getById(String accountId) async {
    try {
      final maps = await _db.query(
        LocalDataSource.tableAccounts,
        where: 'id = ?',
        whereArgs: [accountId],
      );

      if (maps.isEmpty) {
        return Result.failure(const GenericFailure('Account not found'));
      }

      return Result.success(AccountModel.fromJson(maps.first).toEntity());
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  Stream<List<AccountEntity>> watchAll() {
    // Emit current state immediately
    _notifyListeners();
    return _controller.stream;
  }

  @override
  FutureResult<void> updateBalance(String accountId, double newBalance) async {
    try {
      await _db.update(
        LocalDataSource.tableAccounts,
        {'balance': newBalance},
        where: 'id = ?',
        whereArgs: [accountId],
      );

      _notifyListeners();
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  void _notifyListeners() {
    unawaited(
      Future.microtask(() async {
        try {
          final maps = await _db.query(LocalDataSource.tableAccounts);
          final entities = maps
              .map((m) => AccountModel.fromJson(m).toEntity())
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
