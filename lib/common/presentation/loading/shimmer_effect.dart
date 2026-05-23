import 'package:flutter/material.dart';
import 'package:lab_house/common/presentation/loading/shimmer.dart';
import 'package:lab_house/extensions/numeric/num_operators.dart';

class ShimmerEffect extends StatelessWidget {
  final Color? baseColor;
  final Color? shimmerColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final bool active;
  final Widget? child;

  const ShimmerEffect({
    super.key,
    this.baseColor,
    this.shimmerColor,
    this.width = double.infinity,
    this.height,
    this.borderRadius = 20,
    this.active = true,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return active
        ? Shimmer.fromColors(
            baseColor: baseColor ?? Colors.grey.shade300,
            highlightColor:
                shimmerColor ?? Colors.grey[350] ?? Colors.grey.shade400,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: Colors.white,
              ),
              child: (height > 0) ? null : IgnorePointer(child: child),
            ),
          )
        : child ?? const SizedBox.shrink();
  }
}
