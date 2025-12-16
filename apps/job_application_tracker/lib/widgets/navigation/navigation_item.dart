import 'package:flutter/material.dart';

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
