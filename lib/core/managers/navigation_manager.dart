import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_house/common/presentation/base/sheet_skeleton.dart';
import 'package:lab_house/common/presentation/base/toast_skeleton.dart';
import 'package:lab_house/common/router/router_key.dart';
import 'package:lab_house/common/router/routes.m.dart';

mixin NavigationManager {
  Routes? get baseRoute => null;

  /// Delete previous route from memory and initialize destination as new base route.
  /// Using this navigation you cannot try to `context.pop()` for fallback to previous route.
  /// Remember that there is no previous route, `context.go()` deinit all previous routes.
  void go(
    BuildContext? context, {
    required Routes to,
    bool forceNewInitialRoute = false,
    Object? object,
    List<Routes> extra = const [],
    Map<String, dynamic> queryParams = const {},
  }) {
    final baseUrl = (forceNewInitialRoute || baseRoute == null)
        ? ''
        : '${baseRoute!.path}/';
    final extraPaths = _extraPaths(extra);
    final route = baseUrl + to.path + extraPaths;
    final url = _url(route, queryParams);

    if (context != null) {
      context.go(url, extra: object);
    } else {
      router.go(url, extra: object);
    }
  }

  /// Add new route to nagivation stack, similar to ios `navigationController.pushViewController()`.
  /// If you want to fallback to previous route you can use `context.pop()`.
  /// `context.pushReplacement` will pop last route on navigation and present new one.
  Future<T?> push<T extends Object?>(
    BuildContext context, {
    List<Routes> previous = const [],
    required Routes to,
    bool forceNewInitialRoute = false,
    bool replaceOldRoute = false,
    Object? object,
    List<Routes> extra = const [],
    Map<String, dynamic> queryParams = const {},
  }) async {
    final previousUrl = previous.map((item) => '${item.path}/').join('');
    final baseUrl = (forceNewInitialRoute || baseRoute == null)
        ? ''
        : '${baseRoute!.path}/';
    final extraPaths = _extraPaths(extra);
    final route = previousUrl + baseUrl + to.path + extraPaths;
    final url = _url(route, queryParams);

    if (replaceOldRoute) {
      context.pushReplacement(url, extra: object);

      return null;
    }

    return await context.push<T>(url, extra: object);
  }

  /// Same as [push] but using named routes.
  Future<T?> pushNamed<T extends Object?>(
    BuildContext context, {
    required Routes to,
    bool replaceOldRoute = false,
    Object? object,
    Map<String, dynamic> queryParams = const {},
    Map<String, String> pathParams = const {},
  }) async {
    if (replaceOldRoute) {
      context.pushReplacementNamed(
        to.name,
        queryParameters: queryParams,
        pathParameters: pathParams,
        extra: object,
      );

      return null;
    }

    return await context.pushNamed<T>(
      to.name,
      queryParameters: queryParams,
      pathParameters: pathParams,
      extra: object,
    );
  }

  void pushNativeSheet(BuildContext context, {required Widget child}) {
    Navigator.of(context).push(CupertinoPageRoute<void>(builder: (_) => child));
  }

  void popUntil(BuildContext context, {Routes? route, bool initial = false}) {
    assert(
      initial || route != null,
      'if initial is false route cannot be empty',
    );

    final navigator = Navigator.of(context);
    final canNavigate = navigator.widget.pages.any(
      (page) => page.name == route?.name,
    );

    if (route != null && canNavigate) {
      navigator.popUntil(ModalRoute.withName(route.name));

      return;
    }

    if (initial) {
      Navigator.of(context).popUntil((navRoute) => navRoute.isFirst);

      return;
    }

    if (navigator.canPop()) {
      navigator.pop();
    }
  }

  void popNativeSheet(BuildContext context) {
    CupertinoSheetRoute.popSheet(context);
  }

  void nativeSheet<T>(
    BuildContext context, {
    bool useNestedNavigation = false,
    bool enableDrag = true,
    void Function(T? result)? onDismiss,
    required Widget child,
  }) async {
    final result = await showCupertinoSheet<T>(
      context: context,
      useNestedNavigation: useNestedNavigation,
      enableDrag: enableDrag,
      builder: (_) => child,
    );

    onDismiss?.call(result);
  }

  void sheet(
    BuildContext context, {
    bool isScrollControlled = true,
    bool enableDrag = true,
    bool isDismissible = true,
    double? heightFactor = 0.9,
    bool handleKeyboard = false,
    bool bottomSafeArea = true,
    void Function()? onDismiss,
    required Widget child,
  }) async {
    final baseWidget = SheetSkeleton(
      content: child,
      handleKeyboard: handleKeyboard,
      bottomSafeArea: bottomSafeArea,
    );
    final Widget component = heightFactor == null
        ? IntrinsicHeight(child: baseWidget)
        : FractionallySizedBox(heightFactor: heightFactor, child: baseWidget);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: component,
      ),
    );

    onDismiss?.call();
  }

  void toast<T>(
    BuildContext context, {
    bool handleKeyboard = false,
    bool contentPadding = true,
    bool isDismissible = true,
    bool enableDrag = true,
    void Function(T? result)? onDismiss,
    required Widget child,
  }) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: handleKeyboard
                ? MediaQuery.of(context).viewInsets.bottom
                : 0,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: ToastSkeleton(
              contentPadding: contentPadding,
              content: child,
            ),
          ),
        ),
      ),
    );

    onDismiss?.call(result);
  }

  // MARK: - Private Methods

  String _extraPaths(List<Routes> extra) {
    return extra.isNotEmpty
        ? '/${extra.map((route) => route.path).join('/')}'
        : '';
  }

  String _url(String route, Map<String, dynamic> queryParams) {
    return queryParams.isNotEmpty
        ? Uri(path: route, queryParameters: queryParams).toString()
        : route;
  }
}
