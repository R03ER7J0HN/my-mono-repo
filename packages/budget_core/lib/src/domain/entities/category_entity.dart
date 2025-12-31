import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';

/// Represents a transaction category with icon and color
@freezed
sealed class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    required String id,

    /// Category name (e.g., "Food", "Transportation")
    required String name,

    /// Flutter icon code point (e.g., Icons.restaurant.codePoint)
    required int iconCodePoint,

    /// Icon color as hex string (e.g., "#FF5733")
    required String colorHex,

    /// Whether this is a system/default category (cannot be deleted)
    @Default(false) bool isSystem,

    /// Creation timestamp
    DateTime? createdAt,
  }) = _CategoryEntity;

  const CategoryEntity._();

  /// Parse color hex to int for Flutter Color
  int get colorValue {
    final hex = colorHex.replaceFirst('#', '');
    if (hex.length == 6) {
      return int.parse('FF$hex', radix: 16);
    }
    return int.parse(hex, radix: 16);
  }
}
