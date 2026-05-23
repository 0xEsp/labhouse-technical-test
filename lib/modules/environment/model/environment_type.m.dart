part of '../shared/environment.dart';

enum EnvironmentType {
  technical;

  Color envColor() => Colors.cyan;

  String baseUrl() => switch (this) {
    EnvironmentType.technical => 'https://mybackend.com',
  };
}
