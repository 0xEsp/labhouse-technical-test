import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lab_house/core/api/model/api_response_error.m.dart';

part 'api_response.m.g.dart';

// ARP == ApiResponse

@JsonSerializable(genericArgumentFactories: true)
class ARP<T> extends Equatable {
  final String? responseId;
  final bool success;
  final int status;
  final T? data;
  @JsonKey(unknownEnumValue: ARPErrorType.internal)
  final ARPErrorType? error;
  final ARPErrorInfo? errorInfo;

  const ARP({
    this.responseId,
    required this.success,
    required this.status,
    this.data,
    this.error,
    this.errorInfo,
  });

  /// Connect the generated [_$ARPFromJson] function to the `fromJson`
  /// factory.
  factory ARP.fromJson(
    Map<String, dynamic> json, {
    T Function(Object? json)? fromJsonT,
  }) => _$ARPFromJson(json, fromJsonT ?? (json) => null as T);

  /// Connect the generated [_$ARPToJson] function to the `toJson` method.
  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$ARPToJson(this, toJsonT);

  @override
  List<Object?> get props => [responseId, success, status, error, errorInfo];
}

@JsonSerializable()
class ARPErrorInfo extends Equatable {
  final String reason;
  final String? additionalInfo;
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final ARPErrorCode? internalCode;

  const ARPErrorInfo({
    required this.reason,
    this.additionalInfo,
    this.internalCode,
  });

  /// Connect the generated [_$ARPErrorInfoFromJson] function to the `fromJson` factory.
  factory ARPErrorInfo.fromJson(Map<String, dynamic> json) =>
      _$ARPErrorInfoFromJson(json);

  /// Connect the generated [_$ARPErrorInfoToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ARPErrorInfoToJson(this);

  @override
  List<Object?> get props => [reason, additionalInfo, internalCode];
}
