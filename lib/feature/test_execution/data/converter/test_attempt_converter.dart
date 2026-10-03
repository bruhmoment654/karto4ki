import 'package:quizzerg/feature/test_execution/domain/entity/test_attempt_entity.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

abstract final class TestAttemptConverter {
  static TestAttemptEntity fromDto(TestAttemptDatabaseDto dto) {
    return TestAttemptEntity(
      id: dto.id,
      testId: dto.testId,
      startedAt: dto.startedAt,
      completedAt: dto.completedAt,
      total: dto.total,
      correct: dto.correct,
    );
  }
}
