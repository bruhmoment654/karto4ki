import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/core/logger/error_logger.dart';

/// Базовый репозиторий с обработкой ошибок.
///
/// Все репозитории, работающие с асинхронными источниками данных,
/// должны наследоваться от этого класса и использовать [makeCall].
abstract class BaseRepository {
  final ErrorLogger errorLogger;

  const BaseRepository({required this.errorLogger});

  /// Оборачивает вызов в try/catch, логирует ошибки
  /// и возвращает [Result].
  RequestOperation<T> makeCall<T>(Future<T> Function() call) async {
    try {
      final result = await call();
      return Result.ok(result);
    } on Object catch (e, st) {
      errorLogger.logError(e, st);
      return Result.failed(e, st);
    }
  }
}
