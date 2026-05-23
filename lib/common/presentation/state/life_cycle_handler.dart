import 'package:flutter/widgets.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Fires callbacks every time the widget appears or disappears from the screen.
class LifeCycleHandler extends StatefulWidget {
  /// Called when the widget becomes visible or enters foreground while visible.
  /// Triggered when either [onVisibilityGained] or [onForegroundGained] is called.
  /// Equivalent to onResume() on Android or viewDidAppear() on iOS.
  final VoidCallback? onFocusGained;

  /// Called when the widget becomes invisible or enters background while visible.
  /// Triggered when either [onVisibilityLost] or [onForegroundLost] is called.
  /// Equivalent to onPause() on Android or viewDidDisappear() on iOS.
  final VoidCallback? onFocusLost;

  /// Called when the widget becomes visible.
  /// It means the widget is now visible within your app.
  final VoidCallback? onVisibilityGained;

  /// Called when the widget becomes invisible.
  /// It means the widget is no longer visible within your app.
  final VoidCallback? onVisibilityLost;

  /// Called when the app entered the foreground while the widget is visible.
  /// It means, for example, that the user switched back to your app or turned
  /// the device\'s screen back on while your widget was visible.
  final VoidCallback? onForegroundGained;

  /// Called when the app is sent to background while the widget was visible.
  /// It means, for example, that the user sent your app to the background
  /// by opening another app or turned off the device's screen while your widget was visible.
  final VoidCallback? onForegroundLost;

  /// Set Visibility Detector Update Interval to Duration.zero if true or default to 100 milliseconds.
  final bool isWidgetTest;

  /// The widget below this widget in the tree.
  final Widget child;

  const LifeCycleHandler({
    super.key,
    this.onFocusGained,
    this.onFocusLost,
    this.onVisibilityGained,
    this.onVisibilityLost,
    this.onForegroundGained,
    this.onForegroundLost,
    this.isWidgetTest = false,
    required this.child,
  });

  @override
  LifeCycleHandlerState createState() => LifeCycleHandlerState();
}

class LifeCycleHandlerState extends State<LifeCycleHandler>
    with WidgetsBindingObserver {
  // MARK: - Properties

  final _visibilityDetectorKey = UniqueKey();

  /// Whether this widget is currently visible within the app.
  bool _isWidgetVisible = false;

  /// Whether the app is in the foreground.
  bool _isAppInForeground = true;

  // MARK: - Lifecycle

  @override
  void initState() {
    VisibilityDetectorController.instance.updateInterval = widget.isWidgetTest
        ? const Duration(milliseconds: 100)
        : Duration.zero;

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _notifyPlaneTransition(state);
  }

  // MARK: - Build

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityDetectorKey,
      onVisibilityChanged: (info) =>
          _notifyVisibilityStatusChange(info.visibleFraction),
      child: widget.child,
    );
  }

  // MARK: - Private Methods

  /// Notifies app's transitions to/from the foreground.
  void _notifyPlaneTransition(AppLifecycleState state) {
    if (!_isWidgetVisible) return;

    final isAppResumed = state == AppLifecycleState.resumed;
    final wasResumed = _isAppInForeground;

    if (isAppResumed && !wasResumed) {
      _isAppInForeground = true;
      _notifyFocusGain();
      _notifyForegroundGain();

      return;
    }

    final isAppPaused = state == AppLifecycleState.paused;
    if (isAppPaused && wasResumed) {
      _isAppInForeground = false;
      _notifyFocusLoss();
      _notifyForegroundLoss();
    }
  }

  /// Notifies changes in the widget's visibility.
  void _notifyVisibilityStatusChange(double newVisibleFraction) {
    if (!_isAppInForeground) return;

    final wasFullyVisible = _isWidgetVisible;
    final isFullyVisible = newVisibleFraction == 1;
    if (!wasFullyVisible && isFullyVisible) {
      _isWidgetVisible = true;
      _notifyFocusGain();
      _notifyVisibilityGain();
    }

    final isFullyInvisible = newVisibleFraction == 0;
    if (wasFullyVisible && isFullyInvisible) {
      _isWidgetVisible = false;
      _notifyFocusLoss();
      _notifyVisibilityLoss();
    }
  }

  void _notifyFocusGain() {
    final onFocusGained = widget.onFocusGained;

    if (onFocusGained != null) onFocusGained();
  }

  void _notifyFocusLoss() {
    final onFocusLost = widget.onFocusLost;

    if (onFocusLost != null) onFocusLost();
  }

  void _notifyVisibilityGain() {
    final onVisibilityGained = widget.onVisibilityGained;

    if (onVisibilityGained != null) onVisibilityGained();
  }

  void _notifyVisibilityLoss() {
    final onVisibilityLost = widget.onVisibilityLost;

    if (onVisibilityLost != null) onVisibilityLost();
  }

  void _notifyForegroundGain() {
    final onForegroundGained = widget.onForegroundGained;

    if (onForegroundGained != null) onForegroundGained();
  }

  void _notifyForegroundLoss() {
    final onForegroundLost = widget.onForegroundLost;

    if (onForegroundLost != null) onForegroundLost();
  }
}
