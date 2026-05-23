import 'package:json_annotation/json_annotation.dart';

part 'api_response_error_type.m.dart';
part 'api_response_error_code.m.dart';

class ARPError implements Exception {
  final ARPErrorType type;
  final String reason;
  final ARPErrorCode? code;
  final Map<String, String>? extra;

  ARPError({required this.type, required this.reason, this.code, this.extra});

  ARPError copyWith({Map<String, String>? extra}) {
    return ARPError(type: type, reason: reason, code: code, extra: extra);
  }

  @override
  String toString() {
    return "[CODE]: $code || [TYPE]: $type || [REASON]: $reason)";
  }
}
