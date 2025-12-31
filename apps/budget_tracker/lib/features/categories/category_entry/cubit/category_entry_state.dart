import 'package:budget_core/budget_core.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entry_state.freezed.dart';

@freezed
sealed class CategoryEntryState with _$CategoryEntryState {
  const factory CategoryEntryState({
    @Default('') String name,
    @Default(0xe08f) int iconCodePoint, // Icons.category default
    @Default('#2196F3') String colorHex, // Blue
    @Default(false) bool isSaving,
    @Default(false) bool isValid,
    String? error,
    CategoryEntity? existingCategory,
  }) = _CategoryEntryState;

  const CategoryEntryState._();

  bool get isEditing => existingCategory != null;

  IconData get iconData => IconData(
    iconCodePoint,
    fontFamily: 'MaterialIcons',
  );

  Color get color => _parseColor(colorHex);

  static Color _parseColor(String hex) {
    final cleanHex = hex.replaceFirst('#', '');
    if (cleanHex.length == 6) {
      return Color(int.parse('FF$cleanHex', radix: 16));
    }
    return Color(int.parse(cleanHex, radix: 16));
  }
}
