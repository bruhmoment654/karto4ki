import 'package:quizzerg/core/feature/core/entity/request_operation.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';

/// История прохождений тестов. Хранится только на устройстве.
abstract interface class ITestAttemptRepository {
  /// Записать завершённое прохождение и собрать сводку для экрана результата.
  ///
  /// Повторный вызов для той же сессии прохождение не дублирует, а сводку
  /// собирает так же.
  RequestOperation<AttemptSummary> recordAttempt(
    TestSession session, {
    required bool mixup,
    required bool swapSides,
  });
}
