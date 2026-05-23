import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionManager {
  // MARK: - Properties

  bool hasConnection = true;
  Stream<bool> get broadcast => _connectionSC.stream.asBroadcastStream();

  final StreamController<bool> _connectionSC = StreamController.broadcast();
  final Connectivity _connectivity = Connectivity();

  // MARK: - Lifecycle

  ConnectionManager() {
    _connectivity.onConnectivityChanged.listen(_checkConnection);
  }

  // MARK: - Public Methods

  void forceConnectionStatus(bool connected) {
    if (connected == hasConnection) return;

    hasConnection = connected;

    _connectionSC.add(connected);
  }

  void dispose() {
    _connectionSC.close();
  }

  // MARK: - Private Methods

  void _checkConnection(List<ConnectivityResult> results) async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } catch (_) {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      _connectionSC.add(hasConnection);
    }
  }
}
