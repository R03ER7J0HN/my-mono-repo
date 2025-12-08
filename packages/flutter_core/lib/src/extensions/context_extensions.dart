import 'package:flutter/material.dart';

enum SnackBarType {
  defaultType,
  info,
  success,
  error,
}

extension SnackBarContextExtension on BuildContext {
  void showSnackBar(
    Widget content, {
    SnackBarType type = SnackBarType.defaultType,
  }) => ScaffoldMessenger.of(this).showSnackBar(
    SnackBar(
      content: content,
      backgroundColor: switch (type) {
        SnackBarType.info => Colors.blue,
        SnackBarType.success => Colors.green,
        SnackBarType.error => Colors.red,
        _ => null,
      },
    ),
  );
}
