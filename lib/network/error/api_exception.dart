import 'package:quizzerg/core/feature/core/failure.dart';
import 'package:quizzerg/network/error/problem_details_dto.dart';

/// Ошибка обращения к API.
///
/// Наследуется от [Failure], поэтому доходит до бизнес-логики без
/// дополнительного маппинга.
sealed class ApiException extends Failure {
  /// Машинночитаемый код из problem+json.
  final String? code;

  /// HTTP-статус ответа.
  final int? statusCode;

  /// Идентификатор запроса — тащим в логи, по нему ищут на бэке.
  final String? requestId;

  @override
  List<Object?> get props => [...super.props, code, statusCode, requestId];

  const ApiException({
    this.code,
    this.statusCode,
    this.requestId,
    super.message,
    super.parentException,
    super.stackTrace,
  });
}

/// 401, токен не передан.
final class AuthMissingToken extends ApiException {
  const AuthMissingToken({
    super.code,
    super.statusCode,
    super.requestId,
    super.message,
  });
}

/// 401, токен невалиден или просрочен. Повод запустить refresh.
final class AuthInvalidToken extends ApiException {
  const AuthInvalidToken({
    super.code,
    super.statusCode,
    super.requestId,
    super.message,
  });
}

/// 403, не хватает прав (в мобильном приложении штатно не встречается).
final class AuthForbidden extends ApiException {
  const AuthForbidden({
    super.code,
    super.statusCode,
    super.requestId,
    super.message,
  });
}

/// 400, невалидный запрос. Всегда баг клиента.
final class ValidationFailed extends ApiException {
  /// Ошибки по полям.
  final List<ProblemFieldErrorDto> errors;

  @override
  List<Object?> get props =>
      [...super.props, errors.map((it) => '${it.field}:${it.message}')];

  const ValidationFailed({
    this.errors = const [],
    super.code,
    super.statusCode,
    super.requestId,
    super.message,
  });
}

/// 404, сущность не найдена или не принадлежит пользователю.
final class ApiNotFound extends ApiException {
  const ApiNotFound({
    super.code,
    super.statusCode,
    super.requestId,
    super.message,
  });
}

/// 409, нарушение инварианта (например, merge теста в самого себя).
final class ApiConflict extends ApiException {
  const ApiConflict({
    super.code,
    super.statusCode,
    super.requestId,
    super.message,
  });
}

/// 413, файл импорта больше лимита.
final class ImportTooLarge extends ApiException {
  const ImportTooLarge({
    super.code,
    super.statusCode,
    super.requestId,
    super.message,
  });
}

/// 422, файл импорта не разобрался.
final class ImportParseError extends ApiException {
  const ImportParseError({
    super.code,
    super.statusCode,
    super.requestId,
    super.message,
  });
}

/// 429, превышен лимит запросов.
final class RateLimited extends ApiException {
  /// Сколько ждать до следующей попытки, если сервер прислал `Retry-After`.
  final Duration? retryAfter;

  @override
  List<Object?> get props => [...super.props, retryAfter];

  const RateLimited({
    this.retryAfter,
    super.code,
    super.statusCode,
    super.requestId,
    super.message,
  });
}

/// 5xx или неразобранный ответ сервера.
final class ApiServerError extends ApiException {
  const ApiServerError({
    super.code,
    super.statusCode,
    super.requestId,
    super.message,
  });
}

/// Сети нет: таймаут, отсутствие соединения, обрыв.
///
/// Не ошибка приложения — штатное офлайн-состояние.
final class NetworkUnavailable extends ApiException {
  const NetworkUnavailable({
    super.message,
    super.parentException,
    super.stackTrace,
  });
}

/// Запрос отменён вызывающим кодом.
final class RequestCancelled extends ApiException {
  const RequestCancelled({super.message});
}

/// Всё остальное.
final class UnknownApiException extends ApiException {
  const UnknownApiException({
    super.code,
    super.statusCode,
    super.requestId,
    super.message,
    super.parentException,
    super.stackTrace,
  });
}
