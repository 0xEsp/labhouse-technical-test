import 'package:flutter/material.dart';
import 'package:lab_house/common/presentation/button/labhouse_button.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';

class SettingsOption<T> {
  final T value;
  final String label;

  const SettingsOption({required this.value, required this.label});
}

class SettingsOptionToast<T> extends StatefulWidget {
  // MARK: - Properties

  final String title;
  final String confirmLabel;
  final List<SettingsOption<T>> options;
  final T current;
  final ValueChanged<T> onConfirm;

  // MARK: - Lifecycle

  const SettingsOptionToast({
    super.key,
    required this.title,
    required this.confirmLabel,
    required this.options,
    required this.current,
    required this.onConfirm,
  });

  @override
  State<SettingsOptionToast<T>> createState() => _SettingsOptionToastState<T>();
}

class _SettingsOptionToastState<T> extends State<SettingsOptionToast<T>> {
  // MARK: - Properties

  late T _selected = widget.current;

  // MARK: - Build

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: LabhouseTextTheme.semibold(
            color: JGColors.onSurface(context),
            size: 22,
          ),
        ),
        const SizedBox(height: 16),
        ...widget.options.map(_optionRow),
        const SizedBox(height: 24),
        LabhouseButton(
          text: widget.confirmLabel,
          onPressed: () {
            widget.onConfirm(_selected);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  // MARK: - Private Methods

  Widget _optionRow(SettingsOption<T> option) {
    final isSelected = option.value == _selected;

    return InkWell(
      onTap: () => setState(() => _selected = option.value),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected
                  ? JGColors.primaryTurquoise
                  : JGColors.primaryGrey50,
            ),
            const SizedBox(width: 12),
            Text(
              option.label,
              style: LabhouseTextTheme.medium(
                size: 16,
                color: JGColors.onSurface(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
