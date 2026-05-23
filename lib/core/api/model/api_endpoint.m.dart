part of '../../data_service.dart';

enum ApiEndpoint {
  responses('/responses');

  final String path;

  const ApiEndpoint(this.path);
}
