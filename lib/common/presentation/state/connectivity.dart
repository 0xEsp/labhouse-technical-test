import 'package:flutter/material.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/managers/connection_manager.dart';

class Connectivity extends StatelessWidget {
  // MARK: - Properties

  final _connectionManager = container.get<ConnectionManager>();

  final Widget onConnected;
  final Widget onDisconnected;

  // MARK: - Lifecycle

  Connectivity({
    super.key,
    required this.onConnected,
    required this.onDisconnected,
  });

  // MARK: - Build

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: _connectionManager.hasConnection,
      stream: _connectionManager.broadcast,
      builder: (context, snapshot) =>
          snapshot.data == true ? onConnected : onDisconnected,
    );
  }
}
