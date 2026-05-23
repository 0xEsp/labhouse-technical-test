import 'package:flutter/material.dart';

class NoInputBorder extends InputBorder {
  final BorderRadius borderRadius;

  const NoInputBorder({this.borderRadius = BorderRadius.zero})
    : super(borderSide: BorderSide.none);

  @override
  NoInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
  }) => NoInputBorder(borderRadius: borderRadius ?? this.borderRadius);

  @override
  bool get isOutline => false;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  NoInputBorder scale(double t) =>
      NoInputBorder(borderRadius: borderRadius * t);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.toRRect(rect));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.toRRect(rect));
  }

  @override
  void paintInterior(
    Canvas canvas,
    Rect rect,
    Paint paint, {
    TextDirection? textDirection,
  }) {
    canvas.drawRRect(borderRadius.toRRect(rect), paint);
  }

  @override
  bool get preferPaintInterior => true;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    // Do not paint.
  }
}
