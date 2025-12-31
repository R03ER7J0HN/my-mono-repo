import 'package:flutter/material.dart';

/// A gradient background decoration for screens
class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF0F172A),
                  const Color(0xFF1E1B4B),
                ]
              : [
                  colorScheme.primary.withValues(alpha: 0.05),
                  colorScheme.secondary.withValues(alpha: 0.05),
                ],
        ),
      ),
      child: child,
    );
  }
}
