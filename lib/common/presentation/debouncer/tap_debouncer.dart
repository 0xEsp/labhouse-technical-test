import 'package:flutter/widgets.dart';
import 'package:lab_house/common/presentation/debouncer/debouncer_handler.dart';

typedef TapDebouncerFunc = Future<void> Function();

class TapDebouncer extends StatefulWidget {
  /// Function that builds button
  /// context is current context
  /// onTap is function to pass to SomeButton or InkWell
  final Widget Function(BuildContext context, TapDebouncerFunc? onTap) builder;

  /// Function that builds special button in wait state
  /// context is current context
  /// child is widget returning from builder method with onTap equal null
  final Widget Function(BuildContext context, Widget child)? waitBuilder;

  /// Function to call on tap
  final Future<void> Function()? onTap;

  /// Cooldown duration - delay after onTap executed (successfully or not)
  final Duration? cooldown;

  const TapDebouncer({
    super.key,
    required this.builder,
    this.waitBuilder,
    this.onTap,
    this.cooldown = const Duration(seconds: 1),
  });

  @override
  State<TapDebouncer> createState() => _TapDebouncerState();
}

class _TapDebouncerState extends State<TapDebouncer> {
  // MARK: - Properties
  final DebouncerHandler _tapDebouncerHandler = DebouncerHandler();

  // MARK: - Lifecycle

  @override
  void dispose() {
    _tapDebouncerHandler.dispose();

    super.dispose();
  }

  // MARK: - Build

  @override
  Widget build(BuildContext context) => StreamBuilder<bool>(
    initialData: false,
    stream: _tapDebouncerHandler.busyStream,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      if (snapshot.hasError) {
        throw StateError(
          '_tapDebouncerHandler.busy has error=${snapshot.error}',
        );
      }

      final isBusy = snapshot.data ?? true;

      if (!isBusy) {
        final onTap = widget.onTap;

        return widget.builder(
          context,
          onTap == null
              ? null
              : () async => _tapDebouncerHandler.onTap(() async {
                  await onTap();

                  final cooldown = widget.cooldown;

                  if (cooldown != null) {
                    await Future<void>.delayed(cooldown);
                  }
                }),
        );
      }

      final disabledChild = widget.builder(context, null);

      if (widget.waitBuilder == null) {
        return disabledChild;
      } else {
        return widget.waitBuilder!(context, disabledChild);
      }
    },
  );
}
