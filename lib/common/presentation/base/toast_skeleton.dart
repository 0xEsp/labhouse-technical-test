import 'package:flutter/material.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';

class ToastSkeleton extends StatelessWidget {
  // MARK: - Properties

  final bool contentPadding;
  final Widget content;

  // MARK: - Lifecycle

  const ToastSkeleton({
    super.key,
    required this.contentPadding,
    required this.content,
  });

  // MARK: - Body

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: contentPadding
              ? const EdgeInsets.symmetric(horizontal: 16, vertical: 24)
              : null,
          decoration: BoxDecoration(
            color: JGColors.primaryWhite,
            borderRadius: BorderRadius.circular(24),
          ),
          width: double.infinity,
          child: content,
        ),
      ),
    );
  }
}
