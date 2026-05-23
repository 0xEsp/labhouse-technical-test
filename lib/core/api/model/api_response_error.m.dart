import 'package:json_annotation/json_annotation.dart';
import 'package:lab_house/core/api/model/api_response.m.dart';

part 'api_response_error_type.m.dart';
part 'api_response_error_code.m.dart';

class ARPError implements Exception {
  final ARPErrorType type;
  final String reason;
  final ARPErrorCode? code;
  final Map<String, String>? extra;

  ARPError({required this.type, required this.reason, this.code, this.extra});

  factory ARPError.create({
    required ARPErrorType type,
    required ARPErrorInfo info,
    Map<String, String>? extra,
  }) {
    return ARPError(
      type: type,
      reason: info.reason,
      code: info.internalCode,
      extra: extra,
    );
  }

  ARPError copyWith({Map<String, String>? extra}) {
    return ARPError(type: type, reason: reason, code: code, extra: extra);
  }

  @override
  String toString() {
    return "[CODE]: $code || [TYPE]: $type || [REASON]: $reason)";
  }
}
