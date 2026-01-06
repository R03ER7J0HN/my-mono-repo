import 'package:json_annotation/json_annotation.dart';

/// Converts a boolean to/from an integer for SQLite storage.
///
/// SQLite stores booleans as integers where 0 = false and 1 = true.
/// Use this converter with `@JsonKey` or as a type converter.
///
/// Example:
/// ```dart
/// @BoolToIntConverter()
/// final bool isActive;
/// ```
class BoolToIntConverter implements JsonConverter<bool, int> {
  /// Creates a new [BoolToIntConverter].
  const BoolToIntConverter();

  @override
  bool fromJson(int json) => json == 1;

  @override
  int toJson(bool object) => object ? 1 : 0;
}

/// Converts a nullable boolean to/from a nullable integer for SQLite storage.
///
/// SQLite stores booleans as integers where 0 = false and 1 = true.
///
/// Example:
/// ```dart
/// @NullableBoolToIntConverter()
/// final bool? isOptional;
/// ```
class NullableBoolToIntConverter implements JsonConverter<bool?, int?> {
  /// Creates a new [NullableBoolToIntConverter].
  const NullableBoolToIntConverter();

  @override
  bool? fromJson(int? json) => json == null ? null : json == 1;

  @override
  int? toJson(bool? object) => object == null ? null : (object ? 1 : 0);
}
