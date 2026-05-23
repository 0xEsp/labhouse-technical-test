import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lab_house/common/presentation/button/labhouse_button.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';

class ToastBase extends StatelessWidget with LocaleManager {
  // MARK: - Properties

  final Widget content;
  final VoidCallback? ctaTapped;

  // MARK: - Lifecycle

  const ToastBase({super.key, required this.content, this.ctaTapped});

  @override
  Widget build(BuildContext context) {
    final lc = locale(context);

    // TODO: Rehacer diseño

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              lc.a_problem_has_appear,
              style: LabhouseTextTheme.semibold(
                color: JGColors.nightAtDisco,
                size: 22,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: SvgPicture.asset('assets/images/common/cancel_grey.svg'),
            ),
          ],
        ),
        SizedBox(height: 8),
        content,
        SizedBox(height: 32),
        LabhouseButton(
          text: lc.accept,
          onPressed: () {
            if (ctaTapped != null) ctaTapped!();

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
