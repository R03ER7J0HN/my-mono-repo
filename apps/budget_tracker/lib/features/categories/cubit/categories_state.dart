import 'package:budget_core/budget_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_state.freezed.dart';

@freezed
sealed class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    @Default([]) List<CategoryEntity> categories,
    @Default(false) bool isLoading,
    String? error,
  }) = _CategoriesState;
}
