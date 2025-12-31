/// Utility class for JSON serialization converters.
///
/// Provides static methods for converting between Dart types and
/// JSON-compatible types used in SQLite storage.
class JsonConverters {
  const JsonConverters._();

  /// Converts an integer (0 or 1) to a boolean.
  ///
  /// SQLite stores booleans as integers where 0 = false and 1 = true.
  static bool boolFromInt(int value) => value == 1;

  /// Converts a boolean to an integer (0 or 1).
  ///
  /// SQLite stores booleans as integers where 0 = false and 1 = true.
  static int boolToInt(bool value) => value ? 1 : 0;

  /// Converts a nullable integer to a nullable boolean.
  static bool? boolFromIntNullable(int? value) =>
      value == null ? null : value == 1;

  /// Converts a nullable boolean to a nullable integer.
  static int? boolToIntNullable(bool? value) =>
      value == null ? null : (value ? 1 : 0);
}
