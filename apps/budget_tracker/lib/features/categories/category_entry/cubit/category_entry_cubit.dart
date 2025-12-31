import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/categories/category_entry/cubit/category_entry_state.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:uuid/uuid.dart';

class CategoryEntryCubit extends Cubit<CategoryEntryState> with SafeEmitMixin {
  CategoryEntryCubit({
    required CategoryRepository categoryRepository,
    CategoryEntity? existingCategory,
  }) : _categoryRepository = categoryRepository,
       super(
         existingCategory != null
             ? CategoryEntryState(
                 name: existingCategory.name,
                 iconCodePoint: existingCategory.iconCodePoint,
                 colorHex: existingCategory.colorHex,
                 existingCategory: existingCategory,
                 isValid: true,
               )
             : const CategoryEntryState(),
       );

  final CategoryRepository _categoryRepository;

  void setName(String name) {
    safeEmit(
      state.copyWith(
        name: name,
        isValid: _validate(name: name),
        error: null,
      ),
    );
  }

  void setIcon(int codePoint) {
    safeEmit(
      state.copyWith(
        iconCodePoint: codePoint,
        error: null,
      ),
    );
  }

  void setColor(String colorHex) {
    safeEmit(
      state.copyWith(
        colorHex: colorHex,
        error: null,
      ),
    );
  }

  bool _validate({String? name}) {
    final checkName = name ?? state.name;
    return checkName.trim().isNotEmpty;
  }

  Future<bool> save() async {
    if (!state.isValid) return false;

    safeEmit(state.copyWith(isSaving: true, error: null));

    final category = CategoryEntity(
      id: state.existingCategory?.id ?? const Uuid().v4(),
      name: state.name.trim(),
      iconCodePoint: state.iconCodePoint,
      colorHex: state.colorHex,
      isSystem: state.existingCategory?.isSystem ?? false,
      createdAt: state.existingCategory?.createdAt ?? DateTime.now(),
    );

    final result = await _categoryRepository.save(category);

    return result.fold(
      onFailure: (failure) {
        safeEmit(
          state.copyWith(
            isSaving: false,
            error: failure.message,
          ),
        );
        return false;
      },
      onSuccess: (_) {
        safeEmit(state.copyWith(isSaving: false));
        return true;
      },
    );
  }
}
