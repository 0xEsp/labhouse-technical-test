import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_house/common/presentation/state/post_frame_load.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';
import 'package:lab_house/l10n/generated/app_localizations.dart';

class DefaultTextField extends StatefulWidget {
  /// Key for validate individual TextField inside Form & for retrieve value
  final GlobalKey<FormFieldState> fieldKey;

  /// Mark TextField as required
  final bool mandatory;

  /// TextField controller for handle some actions
  final TextEditingController? controller;

  /// TextField placeholder text
  final String? placeholder;

  /// TextField default background color
  final Color? color;

  /// Set leading icon inside TextField
  final Widget? prefixIcon;

  /// Set trailing icon inside TextField
  final Widget? suffixIcon;

  /// Required for retrieve value from [onCommit] & for focus to next TextField in Form
  final FocusNode? focusNode;

  /// Emit the value when lose focus
  final Function(String value)? onCommit;

  /// Emit the value when textfield content change
  final ValueChanged<String>? onChanged;

  /// Enable keyboard option for choose diferent type
  final TextInputType keyboardType;

  ///  Toggles the obscured mode for the input (replaces it with dots or asterisks).
  final bool obscureText;

  /// Change keyboard bottom-right call to action
  final TextInputAction? keyboardAction;

  /// For custom required validation
  final String? Function(String? value)? validator;

  /// Input formatters for custom text formatting (e.g., credit card, date masks)
  final List<TextInputFormatter>? inputFormatters;

  /// Enable or disable the TextField
  final bool enabled;

  /// Forced error text to display
  final String? forcedErrorText;

  const DefaultTextField({
    super.key,
    required this.fieldKey,
    this.mandatory = false,
    this.controller,
    this.placeholder,
    this.color,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.onCommit,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.keyboardAction,
    this.validator,
    this.inputFormatters,
    this.enabled = true,
    this.forcedErrorText,
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField>
    with LocaleManager, PostFrameMixin {
  // MARK: - Properties

  late final AppLocalizations _lc;

  // MARK: - Lifecycle

  @override
  void initState() {
    super.initState();

    postFrame(() => _lc = locale(context));

    if (widget.onCommit == null) return;

    widget.focusNode?.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();

    if (widget.onCommit == null) return;

    widget.focusNode?.removeListener(_onFocusChange);
    widget.focusNode?.dispose();
  }

  // MARK: - Build

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      controller: widget.controller,
      decoration: _decoration(),
      style: LabhouseTextTheme.regular(
        size: 16,
        color: JGColors.onSurface(context),
      ),
      focusNode: widget.focusNode,
      autocorrect: false,
      obscureText: widget.obscureText,
      enableInteractiveSelection: false,
      keyboardType: widget.keyboardType,
      textInputAction: widget.keyboardAction,
      forceErrorText: widget.forcedErrorText,
      validator: widget.validator ?? _defaultValidator,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      errorBuilder: (_, errorText) {
        return Container(
          padding: EdgeInsets.only(left: 6, right: 6, bottom: 1),
          decoration: BoxDecoration(
            color: JGColors.actionNegativeRed,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Text(
            errorText,
            style: LabhouseTextTheme.semibold(color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
      onChanged: widget.onChanged,
    );
  }

  // MARK: - Private Methods

  InputDecoration _decoration() => InputDecoration(
    labelText: widget.placeholder,
    prefixIcon: widget.prefixIcon != null
        ? Padding(
            padding: const EdgeInsetsDirectional.only(start: 16, end: 10),
            child: widget.prefixIcon,
          )
        : null,
    suffixIcon: widget.suffixIcon != null
        ? Padding(
            padding: const EdgeInsetsDirectional.only(start: 10, end: 16),
            child: widget.suffixIcon,
          )
        : null,
    fillColor: widget.color,
  );

  String? _defaultValidator(String? value) =>
      ((value?.isEmpty ?? true) && widget.mandatory)
      ? _lc.mandatory_field
      : null;

  void _onFocusChange() {
    final keyState = widget.fieldKey.currentState;
    // Marked with ! because if focusNode/onCommit it's null this listener never will created
    if (!widget.focusNode!.hasFocus && (keyState?.validate() ?? false)) {
      final value = keyState?.value;
      widget.onCommit!(value);
    }
  }
}
