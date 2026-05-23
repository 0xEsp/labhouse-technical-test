import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_house/common/presentation/debouncer/tap_debouncer.dart';

class PlainButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Widget? leadingIcon;
  final Function() onPressed;

  const PlainButton({
    super.key,
    required this.text,
    required this.textStyle,
    this.leadingIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TapDebouncer(
      onTap: () async {
        HapticFeedback.lightImpact();

        onPressed();
      },
      builder: (_, onTap) => ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(Colors.transparent),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          elevation: WidgetStateProperty.all(0),
          enableFeedback: true,
          alignment: Alignment.center,
          padding: WidgetStateProperty.all(EdgeInsets.zero),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leadingIcon != null) ...{
              leadingIcon!,
              const SizedBox(width: 8),
            },
            Text(text, softWrap: true, style: textStyle),
          ],
        ),
      ),
    );
  }
}
