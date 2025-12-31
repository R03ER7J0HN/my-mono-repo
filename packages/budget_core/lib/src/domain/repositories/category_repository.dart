import 'package:budget_core/src/domain/entities/category_entity.dart';
import 'package:flutter_core/flutter_core.dart';

/// Repository contract for category operations
abstract class CategoryRepository {
  /// Save a category (create or update)
  FutureResult<void> save(CategoryEntity category);

  /// Delete a category by ID
  FutureResult<void> delete(String categoryId);

  /// Get all categories
  FutureResult<List<CategoryEntity>> getAll();

  /// Get a category by ID
  FutureResult<CategoryEntity> getById(String categoryId);

  /// Watch all categories as a stream
  Stream<List<CategoryEntity>> watchAll();
}
