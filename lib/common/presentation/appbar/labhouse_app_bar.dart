import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LabhouseAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Primary widget displayed in the app bar.
  /// Becomes the middle component of the [NavigationToolbar] built by this widget.
  /// Typically a [Text] widget that contains a description of the current contents of the app.
  final String? title;

  /// Extra option for replace [title] widget if you want to display a custom object instead of basic text.
  final Widget? customTitle;

  /// Set the width of leading widget.
  final double? leadingWidth;

  /// Extra option for replace default leading [Icon] if you want to display a custom object.
  final Widget? customLeading;

  /// Callback for handle back button, default pop to previous screen.
  final Function()? leadingBackAction;

  /// Right widget's for custom actions like share, dropdown, profile, etc...
  final List<Widget>? actions;

  /// Set a true if you want to remove the current style for use a transparency app bar.
  final bool transparency;

  const LabhouseAppBar({
    super.key,
    this.title,
    this.customTitle,
    this.leadingWidth,
    this.customLeading,
    this.leadingBackAction,
    this.actions,
    this.transparency = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final canPop = ModalRoute.of(context)?.canPop ?? false;

    return AppBar(
      leadingWidth: leadingWidth,
      leading: canPop
          ? GestureDetector(
              onTap: () {
                if (leadingBackAction != null) {
                  leadingBackAction!();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child:
                  customLeading ??
                  SvgPicture.asset(
                    'assets/images/common/arrow_left_black.svg',
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
            )
          : customLeading,
      title: customTitle ?? (title != null ? Text(title!) : null),
      actions: actions,
      forceMaterialTransparency: transparency,
    );
  }
}
