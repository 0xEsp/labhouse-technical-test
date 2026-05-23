part of 'api_response_error.m.dart';

@JsonEnum()
enum ARPErrorType {
  @JsonValue('INTERNAL_ERROR')
  internal,
  @JsonValue('INVALID_REQUEST')
  invalidRequest,
  @JsonValue('AUTHENTICATION')
  authentication,
  @JsonValue('RATE_LIMIT')
  rateLimit,
}
