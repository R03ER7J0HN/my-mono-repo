import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:job_application_tracker/widgets/navigation/nav_bar_item.dart';
import 'package:job_application_tracker/widgets/navigation/navigation_item.dart';

/// Constants for the bottom navigation bar dimensions.
abstract final class NavBarDimensions {
  /// Height of the navigation bar itself.
  static const double height = 72;

  /// Bottom padding below the navigation bar.
  static const double bottomPadding = 24;

  /// Horizontal padding around the navigation bar.
  static const double horizontalPadding = 20;

  /// Total height occupied by the navigation bar (height + bottom padding).
  static const double totalHeight = height + bottomPadding;
}

/// Extension to easily get bottom padding for screens with the glass nav bar.
extension NavBarPadding on BuildContext {
  /// Returns the total bottom padding needed to avoid content being
  /// hidden behind the floating navigation bar.
  ///
  /// Usage in your screen:
  /// ```dart
  /// Padding(
  ///   padding: EdgeInsets.only(bottom: context.navBarPadding),
  ///   child: YourContent(),
  /// )
  /// ```
  ///
  /// Or with a ListView/CustomScrollView:
  /// ```dart
  /// ListView(
  ///   padding: EdgeInsets.only(bottom: context.navBarPadding),
  ///   children: [...],
  /// )
  /// ```
  double get navBarPadding => NavBarDimensions.totalHeight;
}

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.child,
    required this.items,
    super.key,
  });

  final Widget child;
  final List<NavigationItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: _GlassBottomNavBar(items: items),
    );
  }
}

class _GlassBottomNavBar extends StatelessWidget {
  const _GlassBottomNavBar({required this.items});

  final List<NavigationItem> items;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = _calculateSelectedIndex(location);
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: NavBarDimensions.bottomPadding,
        left: NavBarDimensions.horizontalPadding,
        right: NavBarDimensions.horizontalPadding,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: NavBarDimensions.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        colorScheme.surface.withValues(alpha: 0.6),
                        colorScheme.surface.withValues(alpha: 0.4),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.8),
                        Colors.white.withValues(alpha: 0.6),
                      ],
              ),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                width: 1.5,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.8),
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.05),
                  blurRadius: 20,
                  spreadRadius: -5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = index == selectedIndex;

                return NavBarItem(
                  item: item,
                  isSelected: isSelected,
                  onTap: () {
                    unawaited(HapticFeedback.lightImpact());
                    context.goNamed(item.routeName);
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  int _calculateSelectedIndex(String location) {
    final index = items.indexWhere(
      (item) => location.startsWith(item.routePath),
    );
    return index != -1 ? index : 0;
  }
}
