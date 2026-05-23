part of 'api_response_error.m.dart';

@JsonEnum()
enum ARPErrorCode {
  // MARK: - OpenAI error codes
  @JsonValue('invalid_api_key')
  invalidApiKey,
  @JsonValue('insufficient_quota')
  insufficientQuota,
  @JsonValue('rate_limit_exceeded')
  rateLimitExceeded,
  @JsonValue('model_not_found')
  modelNotFound,
  @JsonValue('context_length_exceeded')
  contextLengthExceeded,
  @JsonValue('content_policy_violation')
  contentPolicyViolation,
  @JsonValue('server_error')
  serverError,
  @JsonValue('unsupported_country_region_territory')
  unsupportedRegion,
}
