extension StringExtension on String {
  /// Capitalizes the first letter of the string.
  /// Example: "hello" -> "Hello"
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Converts camelCase or snake_case to Title Case.
  /// Example: "fullTime" -> "Full Time"
  /// Example: "full_time" -> "Full Time"
  String get toTitleCase {
    if (isEmpty) return this;

    // 1. Replace underscores with spaces
    // 2. Insert space before capital letters (for camelCase)
    // 3. Split into words
    // 4. Capitalize each word
    // 5. Join with spaces
    return replaceAll(
      RegExp('(_)|(?=[A-Z])'),
      ' ',
    ).trim().split(RegExp(r'\s+')).map((word) => word.capitalize).join(' ');
  }
}
