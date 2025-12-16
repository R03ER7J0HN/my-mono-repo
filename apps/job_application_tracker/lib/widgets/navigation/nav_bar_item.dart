import 'dart:async';

import 'package:flutter/material.dart';
import 'package:job_application_tracker/widgets/navigation/navigation_item.dart';

class NavBarItem extends StatefulWidget {
  const NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final NavigationItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  IconData get _iconData =>
      widget.isSelected ? widget.item.selectedIcon : widget.item.icon;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    unawaited(_controller.forward());
  }

  void _handleTapUp(TapUpDetails details) {
    unawaited(_controller.reverse());
    widget.onTap();
  }

  void _handleTapCancel() {
    unawaited(_controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: widget.isSelected ? 18 : 14,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            gradient: widget.isSelected
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primary.withValues(alpha: 0.2),
                      colorScheme.primary.withValues(alpha: 0.1),
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(20),
            border: widget.isSelected
                ? Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                  )
                : null,
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.2),
                      blurRadius: 12,
                      spreadRadius: -2,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAnimatedIcon(context),
              _buildAnimatedLabel(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      child: TweenAnimationBuilder<double>(
        tween: Tween(
          begin: 0,
          end: widget.isSelected ? 1 : 0,
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(
            scale: 1 + (value * 0.15),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.isSelected
                      ? [
                          colorScheme.primary,
                          colorScheme.primary.withValues(alpha: 0.8),
                        ]
                      : [
                          (isDark ? Colors.white : colorScheme.onSurface)
                              .withValues(alpha: 0.5),
                          (isDark ? Colors.white : colorScheme.onSurface)
                              .withValues(alpha: 0.4),
                        ],
                ).createShader(bounds);
              },
              child: Icon(
                _iconData,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedLabel(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: widget.isSelected ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: widget.isSelected
            ? Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.item.label,
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
