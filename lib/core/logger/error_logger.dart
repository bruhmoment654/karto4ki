import 'package:surf_logger/surf_logger.dart';

/// Интерфейс логирования ошибок.
abstract interface class ErrorLogger {
  void logError(Object error, StackTrace stackTrace);
}

/// Реализация [ErrorLogger] через [LogWriter] из surf_logger.
class SurfErrorLogger implements ErrorLogger {
  final LogWriter _logWriter;

  const SurfErrorLogger(this._logWriter);

  @override
  void logError(Object error, StackTrace stackTrace) {
    _logWriter.e(error, stackTrace);
  }
}
