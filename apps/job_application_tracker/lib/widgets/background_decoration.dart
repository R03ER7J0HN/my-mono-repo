import 'package:flutter/material.dart';

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        // Background Gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.primary.withValues(alpha: 0.15),
                colorScheme.surface,
                colorScheme.secondary.withValues(alpha: 0.1),
              ],
            ),
          ),
        ),
        // Decorative Circles
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withValues(alpha: 0.2),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(
                    alpha: 0.1,
                  ),
                  blurRadius: 50,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.secondary.withValues(alpha: 0.2),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.secondary.withValues(
                    alpha: 0.1,
                  ),
                  blurRadius: 50,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),
        ),
        child,
      ],
    );
  }
}
