import 'dart:async';

import 'package:budget_core/src/data/datasources/local_data_source.dart';
import 'package:budget_core/src/data/models/installment_model.dart';
import 'package:budget_core/src/domain/entities/installment_entity.dart';
import 'package:budget_core/src/domain/repositories/installment_repository.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sqflite/sqflite.dart';

/// SQLite implementation of InstallmentRepository
class InstallmentRepositoryImpl implements InstallmentRepository {
  InstallmentRepositoryImpl(this._dataSource);

  final LocalDataSource _dataSource;

  final _controller = StreamController<List<InstallmentEntity>>.broadcast();

  Database get _db => _dataSource.database;

  @override
  FutureResult<void> save(InstallmentEntity installment) async {
    try {
      final data = InstallmentModel.fromEntity(installment).toJson();

      await _db.insert(
        LocalDataSource.tableInstallments,
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
  FutureResult<void> delete(String installmentId) async {
    try {
      await _db.delete(
        LocalDataSource.tableInstallments,
        where: 'id = ?',
        whereArgs: [installmentId],
      );

      _notifyListeners();
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<List<InstallmentEntity>> getAll() async {
    try {
      final maps = await _db.query(LocalDataSource.tableInstallments);
      final entities = maps
          .map((m) => InstallmentModel.fromJson(m).toEntity())
          .toList();
      return Result.success(entities);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<InstallmentEntity> getById(String installmentId) async {
    try {
      final maps = await _db.query(
        LocalDataSource.tableInstallments,
        where: 'id = ?',
        whereArgs: [installmentId],
      );

      if (maps.isEmpty) {
        return Result.failure(const GenericFailure('Installment not found'));
      }

      return Result.success(InstallmentModel.fromJson(maps.first).toEntity());
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<List<InstallmentEntity>> getByAccount(String accountId) async {
    try {
      final maps = await _db.query(
        LocalDataSource.tableInstallments,
        where: 'account_id = ?',
        whereArgs: [accountId],
      );
      final entities = maps
          .map((m) => InstallmentModel.fromJson(m).toEntity())
          .toList();
      return Result.success(entities);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  Stream<List<InstallmentEntity>> watchAll() {
    _notifyListeners();
    return _controller.stream;
  }

  void _notifyListeners() {
    unawaited(
      Future.microtask(() async {
        try {
          final maps = await _db.query(LocalDataSource.tableInstallments);
          final entities = maps
              .map((m) => InstallmentModel.fromJson(m).toEntity())
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
