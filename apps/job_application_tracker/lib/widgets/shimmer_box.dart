import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.child,
    this.baseColor,
    this.highlightColor,
  });

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final Widget? child;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: 'Loading',
      child: Shimmer.fromColors(
        baseColor: baseColor ?? colorScheme.secondary.withValues(alpha: 0.5),
        highlightColor:
            highlightColor ?? colorScheme.primary.withValues(alpha: 0.2),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: shape,
            borderRadius: shape == BoxShape.rectangle
                ? (borderRadius ?? BorderRadius.circular(12))
                : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
