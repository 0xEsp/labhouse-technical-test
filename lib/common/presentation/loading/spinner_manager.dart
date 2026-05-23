import 'package:flutter/material.dart';
import 'package:lab_house/common/presentation/loading/spinner.dart';
import 'package:lab_house/common/router/router_key.dart';

/// Need to be on global context due Stateless widget limitation using this mixin
/// with no-final variables modification at runtime
BuildContext? _spinnerContext;
bool _hideSpinnerDataraced = false;

mixin SpinnerManager {
  // MARK: - Public Methods

  void showSpinner({BuildContext? context, VoidCallback? completion}) async {
    assert(context != null || routerKey.currentContext != null);

    await showDialog(
      context: context ?? routerKey.currentContext!,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (dialogContext) {
        _spinnerContext = dialogContext;

        if (_hideSpinnerDataraced) {
          hideSpinner();
        }

        return const Spinner();
      },
    );

    if (completion != null) completion();
  }

  void hideSpinner({BuildContext? context}) {
    final resolvedContext = _spinnerContext ?? context;

    if (resolvedContext == null) {
      _hideSpinnerDataraced = true;
      return;
    }

    try {
      final navigator = Navigator.of(resolvedContext, rootNavigator: true);

      if (!navigator.canPop()) return;
      navigator.pop();

      _hideSpinnerDataraced = false;
    } catch (_) {
      _hideSpinnerDataraced = true;
      return;
    } finally {
      _spinnerContext = null;
    }
  }
}
