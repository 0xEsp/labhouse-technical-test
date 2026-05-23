import 'package:flutter/material.dart';
import 'package:lab_house/common/presentation/button/labhouse_button.dart';
import 'package:lab_house/common/presentation/inputs/default_text_field.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';

class ApiKeyToast extends StatefulWidget {
  // MARK: - Properties

  final String maskedApiKey;
  final bool hasApiKey;
  final ValueChanged<String> onSave;

  // MARK: - Lifecycle

  const ApiKeyToast({
    super.key,
    required this.maskedApiKey,
    required this.hasApiKey,
    required this.onSave,
  });

  @override
  State<ApiKeyToast> createState() => _ApiKeyToastState();
}

class _ApiKeyToastState extends State<ApiKeyToast> with LocaleManager {
  // MARK: - Properties

  final _controller = TextEditingController();
  final _fieldKey = GlobalKey<FormFieldState>();

  // MARK: - Lifecycle

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // MARK: - Build

  @override
  Widget build(BuildContext context) {
    final lc = locale(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lc.settings_api_key,
          style: LabhouseTextTheme.semibold(
            color: JGColors.nightAtDisco,
            size: 22,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          lc.api_key_current_label,
          style: LabhouseTextTheme.regular(
            size: 13,
            color: JGColors.primaryGrey50,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.hasApiKey ? widget.maskedApiKey : lc.api_key_empty,
          style: LabhouseTextTheme.semibold(
            size: 16,
            color: JGColors.nightAtDisco,
          ),
        ),
        const SizedBox(height: 20),
        DefaultTextField(
          fieldKey: _fieldKey,
          controller: _controller,
          placeholder: lc.api_key_input_placeholder,
        ),
        const SizedBox(height: 24),
        LabhouseButton(text: lc.save, onPressed: _save),
      ],
    );
  }

  // MARK: - Private Methods

  void _save() {
    final value = _controller.text.trim();

    if (value.isEmpty) return;

    widget.onSave(value);
    Navigator.of(context).pop();
  }
}
