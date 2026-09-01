import 'package:dio/dio.dart';

import 'package:quizzerg/network/error/api_error_code.dart';
import 'package:quizzerg/network/error/api_exception.dart';
import 'package:quizzerg/network/error/problem_details_dto.dart';

/// Превращает [DioException] в типизированное [ApiException].
///
/// Решение принимается по `code` из problem+json, а не по `title`:
/// заголовок сервер может менять свободно, код — контракт.
abstract final class ApiErrorMapper {
  static ApiException map(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.connectionError ||
      DioExceptionType.badCertificate =>
        NetworkUnavailable(
          message: exception.message,
          parentException: exception,
          stackTrace: exception.stackTrace,
        ),
      DioExceptionType.cancel => RequestCancelled(message: exception.message),
      DioExceptionType.badResponse => _fromResponse(exception),
      DioExceptionType.unknown => _fromUnknown(exception),
    };
  }

  static ApiException _fromUnknown(DioException exception) {
    // Dio кладёт сюда и обрывы соединения — для клиента это офлайн.
    final error = exception.error;
    if (error is Exception && exception.response == null) {
      return NetworkUnavailable(
        message: exception.message,
        parentException: exception,
        stackTrace: exception.stackTrace,
      );
    }
    return UnknownApiException(
      message: exception.message,
      parentException: exception,
      stackTrace: exception.stackTrace,
    );
  }

  static ApiException _fromResponse(DioException exception) {
    final response = exception.response;
    final status = response?.statusCode;
    final problem = _parseProblem(response?.data);
    final code = problem?.code;
    final message = problem?.detail ?? problem?.title ?? exception.message;
    final requestId = problem?.requestId;

    final byCode = _byCode(
      code: code,
      status: status,
      message: message,
      requestId: requestId,
      problem: problem,
      response: response,
    );
    if (byCode != null) return byCode;

    return _byStatus(
      status: status,
      code: code,
      message: message,
      requestId: requestId,
      response: response,
    );
  }

  static ApiException? _byCode({
    required String? code,
    required int? status,
    required String? message,
    required String? requestId,
    required ProblemDetailsDto? problem,
    required Response<Object?>? response,
  }) {
    return switch (code) {
      ApiErrorCode.authMissingToken => AuthMissingToken(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      ApiErrorCode.authInvalidToken ||
      ApiErrorCode.authExpiredToken =>
        AuthInvalidToken(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      ApiErrorCode.authForbidden => AuthForbidden(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      ApiErrorCode.validationInvalidField ||
      ApiErrorCode.validationMalformedBody =>
        ValidationFailed(
          errors: problem?.errors ?? const [],
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      ApiErrorCode.resourceNotFound => ApiNotFound(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      ApiErrorCode.resourceConflict => ApiConflict(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      ApiErrorCode.importTooLarge => ImportTooLarge(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      ApiErrorCode.importParseError => ImportParseError(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      ApiErrorCode.rateLimitExceeded => RateLimited(
          retryAfter: retryAfterOf(response),
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      ApiErrorCode.serverInternal ||
      ApiErrorCode.serverUnavailable =>
        ApiServerError(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      _ => null,
    };
  }

  /// Фолбэк, когда сервер не прислал `code` (прокси, балансировщик, 502).
  static ApiException _byStatus({
    required int? status,
    required String? code,
    required String? message,
    required String? requestId,
    required Response<Object?>? response,
  }) {
    return switch (status) {
      401 => AuthInvalidToken(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      403 => AuthForbidden(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      400 => ValidationFailed(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      404 => ApiNotFound(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      409 => ApiConflict(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      413 => ImportTooLarge(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      422 => ImportParseError(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      429 => RateLimited(
          retryAfter: retryAfterOf(response),
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      final int value when value >= 500 => ApiServerError(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
      _ => UnknownApiException(
          code: code,
          statusCode: status,
          requestId: requestId,
          message: message,
        ),
    };
  }

  /// Читает заголовок `Retry-After` (сейчас сервер его не шлёт, но контракт есть).
  static Duration? retryAfterOf(Response<Object?>? response) {
    final raw = response?.headers.value('retry-after');
    if (raw == null) return null;

    final seconds = int.tryParse(raw.trim());
    return seconds == null ? null : Duration(seconds: seconds);
  }

  static ProblemDetailsDto? _parseProblem(Object? data) {
    if (data is! Map) return null;

    try {
      return ProblemDetailsDto.fromJson(Map<String, dynamic>.from(data));
    } on Object {
      return null;
    }
  }
}
