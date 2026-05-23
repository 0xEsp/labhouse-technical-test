import 'dart:async';

class DebouncerHandler {
  // MARK: - Properties

  /// Busy state stream
  Stream<bool> get busyStream => _busyController.stream;

  final StreamController<bool> _busyController;

  // MARK: - Lifecycle

  DebouncerHandler() : _busyController = StreamController<bool>()..add(false);

  // MARK: - Public Methods

  /// Dispose resources
  void dispose() => unawaited(_busyController.close());

  /// Process onTap function
  Future<void> onTap(Future<void> Function() function) async {
    try {
      _add(true);

      await function();
    } finally {
      _add(false);
    }
  }

  // MARK: - Private Methods

  void _add(bool value) {
    if (_busyController.isClosed) return;

    _busyController.add(value);
  }
}
