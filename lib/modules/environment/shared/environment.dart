import 'package:flutter/material.dart';

part '../model/environment_type.m.dart';

class Environment {
  // MARK: - Properties

  String baseUrl;
  EnvironmentType type;

  // MARK: - Lifecycle

  Environment()
    : baseUrl = EnvironmentType.technical.baseUrl(),
      type = EnvironmentType.technical;

  // MARK: - Public Methods

  void update(EnvironmentType newEnv) {
    baseUrl = newEnv.baseUrl();
    type = newEnv;
  }
}
