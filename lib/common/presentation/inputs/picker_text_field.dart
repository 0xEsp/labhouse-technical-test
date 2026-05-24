import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_house/common/presentation/border/labhouse_outline_input_border.dart';
import 'package:lab_house/common/presentation/border/no_input_border.dart';
import 'package:lab_house/common/presentation/state/life_cycle_handler.dart';
import 'package:lab_house/common/presentation/state/post_frame_load.dart';
import 'package:lab_house/common/utils.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/extensions/string/string_similarity.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';
import 'package:lab_house/l10n/generated/app_localizations.dart';

class PickerTextField extends StatefulWidget {
  /// Key for validate individual TextField inside Form & for retrieve value
  final GlobalKey<FormFieldState> fieldKey;

  /// TextField picker options
  final List<String> items;

  /// Mark TextField as required
  final bool mandatory;

  /// TextField picker default initial value
  final String? value;

  /// TextField placeholder text
  final String? placeholder;

  /// TextField default background color
  final Color color;

  /// Set leading icon inside TextField
  final Widget? prefixIcon;

  /// Set trailing icon inside TextField
  final Widget? suffixIcon;

  /// Set to true if you want to display a text input for searching inside list. Default to false
  final bool haveSearch;

  /// Emit the value when lose focus
  final Function(String item)? onCommit;

  const PickerTextField({
    super.key,
    required this.fieldKey,
    required this.items,
    this.mandatory = false,
    this.value,
    this.placeholder,
    this.color = Colors.white,
    this.prefixIcon,
    this.suffixIcon,
    this.haveSearch = false,
    this.onCommit,
  });

  @override
  State<PickerTextField> createState() => _PickerTextFieldState();
}

class _PickerTextFieldState extends State<PickerTextField>
    with LocaleManager, PostFrameMixin {
  // MARK: - Properties

  List<String> _itemsFound = [];

  late final AppLocalizations _lc;

  // MARK: - Lifecycle

  @override
  void initState() {
    super.initState();

    postFrame(() => _lc = locale(context));

    _itemsFound = widget.items;
  }

  // MARK: - Build

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      decoration: _decoration(),
      initialValue: widget.value,
      style: LabhouseTextTheme.regular(size: 16, color: JGColors.nightAtDisco),
      autocorrect: false,
      readOnly: true,
      validator: _validator,
      onTap: () => _displayPicker(context),
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
    border: WidgetStateInputBorder.resolveWith((states) {
      final borderRadius = const BorderRadius.all(Radius.circular(15));

      if (states.contains(WidgetState.error)) {
        return LabhouseOutlineInputBorder(
          borderSide: BorderSide(color: JGColors.actionNegativeRed),
          borderRadius: borderRadius,
        );
      }

      return NoInputBorder(borderRadius: borderRadius);
    }),
  );

  String? _validator(String? value) =>
      ((value?.isEmpty ?? true) && widget.mandatory)
      ? _lc.mandatory_field
      : null;

  void _displayPicker(BuildContext context) {
    final initialIndex = widget.items.indexOf(widget.value ?? '');
    final controller = FixedExtentScrollController(initialItem: initialIndex);

    showCupertinoModalPopup(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => LifeCycleHandler(
        onVisibilityLost: () {
          _itemsFound = widget.items;

          if (widget.onCommit != null) {
            final value = widget.fieldKey.currentState?.value;
            widget.onCommit!(value);
          }
        },
        child: StatefulBuilder(
          builder: (context, setState) {
            return CupertinoActionSheet(
              actions: [
                if (widget.haveSearch) ...{
                  CupertinoSearchTextField(
                    placeholder: _lc.search,
                    onChanged: (value) => _handleOnChangeInput(value, setState),
                  ),
                },
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  // The Bottom margin is provided to align the popup above the system navigation bar.
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  color: CupertinoColors.extraLightBackgroundGray,
                  // Use a SafeArea widget to avoid system overlaps.
                  child: CupertinoPicker(
                    magnification: 1.2,
                    squeeze: 1,
                    useMagnifier: true,
                    itemExtent: 32,
                    scrollController: controller,
                    onSelectedItemChanged: (int selectedItem) {
                      final keyState = widget.fieldKey.currentState;
                      keyState?.didChange(_itemsFound[selectedItem]);
                    },
                    children: List<Widget>.generate(_itemsFound.length, (
                      int index,
                    ) {
                      return Center(
                        child: GestureDetector(
                          onTap: () => controller.animateToItem(
                            index,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.decelerate,
                          ),
                          child: Text(
                            _itemsFound[index],
                            style: LabhouseTextTheme.regular(
                              color: JGColors.nightAtDisco,
                              size: 16,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleOnChangeInput(
    String value,
    void Function(void Function()) setState,
  ) {
    final searchedText = Utils.removeDiacritics(value).toLowerCase();

    final itemsSearched = widget.items.where((String item) {
      final seekingText = Utils.removeDiacritics(item).toLowerCase();

      return seekingText.contains(searchedText)
          ? true
          : seekingText.similarityTo(searchedText) > 0.85;
    }).toList();

    setState(
      () => _itemsFound = itemsSearched.isEmpty ? widget.items : itemsSearched,
    );

    final keyState = widget.fieldKey.currentState;
    keyState?.didChange(_itemsFound[0]);
  }
}
