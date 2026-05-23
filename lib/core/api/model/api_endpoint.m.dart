part of '../../data_service.dart';

enum ApiEndpoint {
  startup('/config/startup');

  final String path;

  const ApiEndpoint(this.path);
}
