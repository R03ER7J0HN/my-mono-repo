import 'package:flutter/material.dart';

enum SnackBarType {
  defaultType,
  info,
  success,
  error,
}

extension SnackBarContextExtension on BuildContext {
  void clearSnackBars() => ScaffoldMessenger.of(this).clearSnackBars();

  void showSnackBar(
    String message, {
    SnackBarType type = SnackBarType.defaultType,
    SnackBarAction? action,
    Duration? duration,
  }) => ScaffoldMessenger.of(this).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: switch (type) {
        SnackBarType.info => Colors.blue,
        SnackBarType.success => Colors.green,
        SnackBarType.error => Colors.red,
        _ => null,
      },
      duration: duration ?? const Duration(seconds: 3),
      action: action,
    ),
  );
}
