import 'package:flutter/material.dart';

/// Provides a curated list of colors for category customization
class CategoryColors {
  CategoryColors._();

  /// Returns a list of predefined colors for categories
  static List<Color> get all => [
    // Reds
    Colors.red,
    Colors.redAccent,
    Colors.pink,
    Colors.pinkAccent,

    // Oranges
    Colors.orange,
    Colors.orangeAccent,
    Colors.deepOrange,
    Colors.deepOrangeAccent,

    // Yellows
    Colors.amber,
    Colors.amberAccent,
    Colors.yellow,
    Colors.yellowAccent,

    // Greens
    Colors.lightGreen,
    Colors.green,
    Colors.greenAccent,
    Colors.teal,
    Colors.tealAccent,

    // Blues
    Colors.cyan,
    Colors.cyanAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.blue,
    Colors.blueAccent,

    // Purples
    Colors.indigo,
    Colors.indigoAccent,
    Colors.purple,
    Colors.purpleAccent,
    Colors.deepPurple,
    Colors.deepPurpleAccent,

    // Neutrals
    Colors.brown,
    Colors.blueGrey,
    Colors.grey,
  ];

  /// Converts a Color to a hex string
  static String toHex(Color color) {
    // Color.value is deprecated but the replacement (component access) is more
    // complex for simple hex string conversion.
    // ignore: deprecated_member_use
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  /// Parses a hex string to a Color
  static Color fromHex(String hex) {
    final cleanHex = hex.replaceFirst('#', '');
    if (cleanHex.length == 6) {
      return Color(int.parse('FF$cleanHex', radix: 16));
    }
    return Color(int.parse(cleanHex, radix: 16));
  }

  /// Returns a contrasting color (black or white) for text on a given color
  static Color contrastColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
