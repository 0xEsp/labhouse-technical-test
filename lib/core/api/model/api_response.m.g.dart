// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.m.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ARP<T> _$ARPFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ARP<T>(
  responseId: json['responseId'] as String?,
  success: json['success'] as bool,
  status: (json['status'] as num).toInt(),
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
  error: $enumDecodeNullable(
    _$ARPErrorTypeEnumMap,
    json['error'],
    unknownValue: ARPErrorType.internal,
  ),
  errorInfo: json['errorInfo'] == null
      ? null
      : ARPErrorInfo.fromJson(json['errorInfo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ARPToJson<T>(
  ARP<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'responseId': instance.responseId,
  'success': instance.success,
  'status': instance.status,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
  'error': _$ARPErrorTypeEnumMap[instance.error],
  'errorInfo': instance.errorInfo,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

const _$ARPErrorTypeEnumMap = {ARPErrorType.internal: 'INTERNAL_ERROR'};

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

ARPErrorInfo _$ARPErrorInfoFromJson(Map<String, dynamic> json) => ARPErrorInfo(
  reason: json['reason'] as String,
  additionalInfo: json['additionalInfo'] as String?,
  internalCode: $enumDecodeNullable(
    _$ARPErrorCodeEnumMap,
    json['internalCode'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
);

Map<String, dynamic> _$ARPErrorInfoToJson(ARPErrorInfo instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'additionalInfo': instance.additionalInfo,
      'internalCode': _$ARPErrorCodeEnumMap[instance.internalCode],
    };

const _$ARPErrorCodeEnumMap = {ARPErrorCode.requestInvalidParamFormat: 50023};
