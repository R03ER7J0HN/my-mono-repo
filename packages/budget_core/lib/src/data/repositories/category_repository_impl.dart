import 'dart:async';

import 'package:budget_core/src/data/datasources/local_data_source.dart';
import 'package:budget_core/src/data/models/category_model.dart';
import 'package:budget_core/src/domain/entities/category_entity.dart';
import 'package:budget_core/src/domain/repositories/category_repository.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:sqflite/sqflite.dart';

/// SQLite implementation of CategoryRepository
class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._dataSource);

  final LocalDataSource _dataSource;

  final _controller = StreamController<List<CategoryEntity>>.broadcast();

  Database get _db => _dataSource.database;

  @override
  FutureResult<void> save(CategoryEntity category) async {
    try {
      final data = CategoryModel.fromEntity(category).toJson();

      await _db.insert(
        LocalDataSource.tableCategories,
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
  FutureResult<void> delete(String categoryId) async {
    try {
      // Check if it's a system category
      final maps = await _db.query(
        LocalDataSource.tableCategories,
        where: 'id = ?',
        whereArgs: [categoryId],
      );

      if (maps.isNotEmpty && maps.first['is_system'] == 1) {
        return Result.failure(
          const GenericFailure('Cannot delete system categories'),
        );
      }

      await _db.delete(
        LocalDataSource.tableCategories,
        where: 'id = ?',
        whereArgs: [categoryId],
      );

      _notifyListeners();
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<List<CategoryEntity>> getAll() async {
    try {
      final maps = await _db.query(
        LocalDataSource.tableCategories,
        orderBy: 'is_system DESC, name ASC',
      );
      final entities = maps
          .map((m) => CategoryModel.fromJson(m).toEntity())
          .toList();
      return Result.success(entities);
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  FutureResult<CategoryEntity> getById(String categoryId) async {
    try {
      final maps = await _db.query(
        LocalDataSource.tableCategories,
        where: 'id = ?',
        whereArgs: [categoryId],
      );

      if (maps.isEmpty) {
        return Result.failure(const GenericFailure('Category not found'));
      }

      return Result.success(CategoryModel.fromJson(maps.first).toEntity());
    } on Exception catch (e) {
      return Result.failure(GenericFailure(e.toString()));
    }
  }

  @override
  Stream<List<CategoryEntity>> watchAll() {
    _notifyListeners();
    return _controller.stream;
  }

  void _notifyListeners() {
    unawaited(
      Future.microtask(() async {
        try {
          final maps = await _db.query(
            LocalDataSource.tableCategories,
            orderBy: 'is_system DESC, name ASC',
          );
          final entities = maps
              .map((m) => CategoryModel.fromJson(m).toEntity())
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
