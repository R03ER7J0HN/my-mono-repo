import 'dart:async';

import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/categories/cubit/categories_state.dart';
import 'package:flutter_core/flutter_core.dart';

class CategoriesCubit extends Cubit<CategoriesState> with SafeEmitMixin {
  CategoriesCubit({
    required CategoryRepository categoryRepository,
  }) : _categoryRepository = categoryRepository,
       super(const CategoriesState()) {
    _init();
  }

  final CategoryRepository _categoryRepository;
  StreamSubscription<List<CategoryEntity>>? _subscription;

  void _init() {
    safeEmit(state.copyWith(isLoading: true));

    _subscription = _categoryRepository.watchAll().listen(
      (categories) {
        safeEmit(
          state.copyWith(
            categories: categories,
            isLoading: false,
            error: null,
          ),
        );
      },
      onError: (Object error) {
        safeEmit(
          state.copyWith(
            isLoading: false,
            error: error.toString(),
          ),
        );
      },
    );
  }

  Future<void> deleteCategory(CategoryEntity category) async {
    if (category.isSystem) {
      safeEmit(
        state.copyWith(error: 'System categories cannot be deleted'),
      );
      return;
    }

    final result = await _categoryRepository.delete(category.id);
    result.fold(
      onFailure: (failure) {
        safeEmit(state.copyWith(error: failure.message));
      },
      onSuccess: (_) {
        // Deletion handled by stream
      },
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
