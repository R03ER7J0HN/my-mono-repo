import 'package:flutter/material.dart';

enum SnackBarType {
  defaultType,
  info,
  success,
  error,
}

extension SnackBarContextExtension on BuildContext {
  void showSnackBar(
    String message, {
    SnackBarType type = SnackBarType.defaultType,
  }) => ScaffoldMessenger.of(this).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: switch (type) {
        SnackBarType.info => Colors.blue,
        SnackBarType.success => Colors.green,
        SnackBarType.error => Colors.red,
        _ => null,
      },
    ),
  );
}
