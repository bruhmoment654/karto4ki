import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/active_test_session.dart';

/// Репозиторий активной (последней) сессии теста.
///
/// Контракт хранилища для возобновления тестов. Реализации могут быть
/// разными (drift / shared_preferences), но всё остальное приложение
/// общается с хранилищем только через этот интерфейс.
abstract interface class IActiveSessionRepository {
  /// Получить активную сессию, если она есть.
  RequestOperation<ActiveTestSession?> getActiveSession();

  /// Сохранить активную сессию (перезаписывает существующую).
  RequestOperation<void> saveActiveSession(ActiveTestSession session);

  /// Очистить активную сессию.
  RequestOperation<void> clearActiveSession();

  /// Подписаться на изменения активной сессии.
  Stream<ActiveTestSession?> watchActiveSession();
}
