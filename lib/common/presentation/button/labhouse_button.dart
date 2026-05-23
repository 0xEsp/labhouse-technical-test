import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_house/common/presentation/debouncer/tap_debouncer.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';

part 'labhouse_button_style.dart';

class LabhouseButton extends StatelessWidget {
  final String text;
  final Widget? leadingIcon, trailingIcon;
  final LabhouseButtonStyle style;
  final bool textCenter;
  final TextStyle? textStyle;
  final bool useAutoWidth;
  final Function()? onPressed;

  const LabhouseButton({
    super.key,
    required this.text,
    this.leadingIcon,
    this.trailingIcon,
    this.style = LabhouseButtonStyle.main,
    this.textCenter = true,
    this.textStyle,
    this.useAutoWidth = false,
    required this.onPressed,
  }) : assert(
         !useAutoWidth || !textCenter,
         'if button fit his content with useAutoWidth property, you cannot use textCenter, there is nothing to center',
       );

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      textAlign: TextAlign.center,
      softWrap: true,
      style:
          textStyle ?? style.textStyle ?? LabhouseTextTheme.semibold(size: 18),
    );
    final button = TapDebouncer(
      onTap: onPressed == null
          ? null
          : () async {
              HapticFeedback.mediumImpact();
              onPressed!();
            },
      builder: (_, onTap) => ElevatedButton(
        onPressed: onPressed == null ? onTap : (onTap ?? () {}),
        style: style.theme,
        child: Row(
          mainAxisSize: useAutoWidth ? MainAxisSize.min : MainAxisSize.max,
          children: [
            if (leadingIcon != null) ...{
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: leadingIcon!,
              ),
            } else if (trailingIcon != null && textCenter) ...{
              const SizedBox(height: 24, width: 24),
            },
            Flexible(
              child: textCenter ? Center(child: textWidget) : textWidget,
            ),
            if (trailingIcon != null) ...{
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: trailingIcon!,
              ),
            } else if (leadingIcon != null && textCenter) ...{
              const SizedBox(height: 24, width: 24),
            },
          ],
        ),
      ),
    );

    return SizedBox(
      width: useAutoWidth ? null : double.infinity,
      child: style.hasShadow
          ? DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: LabhouseElevatedButtonTheme.defaultRadius,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.black.withValues(alpha: .03),
                    blurRadius: 1.5,
                  ),
                  BoxShadow(
                    offset: Offset(0, 4),
                    color: Colors.black.withValues(alpha: .1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: button,
            )
          : button,
    );
  }
}
