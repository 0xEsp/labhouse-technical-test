import 'package:flutter/material.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';

class SheetSkeleton extends StatelessWidget {
  // MARK: - Properties

  final Widget content;
  final bool handleKeyboard;
  final bool bottomSafeArea;

  // MARK: - Lifecycle

  const SheetSkeleton({
    super.key,
    required this.content,
    this.handleKeyboard = false,
    required this.bottomSafeArea,
  });

  // MARK: - Body

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: handleKeyboard ? MediaQuery.of(context).viewInsets.bottom : 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        color: JGColors.primaryWhite,
      ),
      width: double.infinity,
      child: SafeArea(top: false, bottom: bottomSafeArea, child: content),
    );
  }
}
