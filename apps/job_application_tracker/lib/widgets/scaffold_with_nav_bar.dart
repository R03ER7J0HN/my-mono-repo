import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationItem {
  const NavigationItem({
    required this.routePath,
    required this.routeName,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final String routePath;
  final String routeName;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: colorScheme.onSurface.withValues(alpha: 0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = index == selectedIndex;

                return _NavBarItem(
                  item: item,
                  isSelected: isSelected,
                  onTap: () => context.goNamed(item.routeName),
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

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final NavigationItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = isSelected
        ? colorScheme.primary
        : colorScheme.onSurface.withValues(alpha: 0.5);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? item.selectedIcon : item.icon,
              color: color,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                item.label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
