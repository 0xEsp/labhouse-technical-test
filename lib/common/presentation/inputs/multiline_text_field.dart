import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_house/common/presentation/state/post_frame_load.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';
import 'package:lab_house/l10n/generated/app_localizations.dart';

class MultilineTextField extends StatefulWidget {
  /// Key for validate individual TextField inside Form & for retrieve value
  final GlobalKey<FormFieldState>? fieldKey;

  /// Mark TextField as required
  final bool mandatory;

  /// TextField controller for handle some actions
  final TextEditingController? controller;

  /// TextField placeholder text
  final String? placeholder;

  /// TextField default background color
  final Color color;

  /// Set leading icon inside TextField
  final Widget? prefixIcon;

  /// Set trailing icon inside TextField
  final Widget? suffixIcon;

  // Set max limit for text lenght
  final int? maxLimit;

  /// mandatory for retrieve value from [onCommit] when lose focus & for focus to next TextField in Form
  final FocusNode? focusNode;

  /// Emit the value when value in TextField change
  /// If you combine this property with [focusNode] the value will be emitted when lose focus instead.
  final Function(String? value)? onCommit;

  /// For custom mandatory validation
  final String? Function(String?)? validator;

  const MultilineTextField({
    super.key,
    required this.fieldKey,
    this.mandatory = false,
    this.controller,
    this.placeholder,
    this.color = Colors.white,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLimit,
    this.focusNode,
    this.onCommit,
    this.validator,
  });

  @override
  State<MultilineTextField> createState() => _MultilineTextFieldState();
}

class _MultilineTextFieldState extends State<MultilineTextField>
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
      decoration: _decoration(),
      controller: widget.controller,
      style: LabhouseTextTheme.regular(size: 16, color: JGColors.nightAtDisco),
      focusNode: widget.focusNode,
      autocorrect: false,
      enableInteractiveSelection: false,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      maxLength: widget.maxLimit,
      maxLengthEnforcement: MaxLengthEnforcement.none,
      onChanged: (value) {
        if (widget.onCommit == null || widget.focusNode != null) return;

        widget.onCommit!(
          value.length > (widget.maxLimit ?? value.length) ? null : value,
        );
      },
      validator: widget.validator ?? _defaultValidator,
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
          ),
        );
      },
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
    suffixIcon: widget.prefixIcon != null
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
    final keyState = widget.fieldKey?.currentState;
    // Marked with ! because if focusNode/onCommit it's null this listener never will created
    if (!widget.focusNode!.hasFocus && (keyState?.validate() ?? false)) {
      final value = keyState?.value;
      widget.onCommit!(value);
    }
  }
}
