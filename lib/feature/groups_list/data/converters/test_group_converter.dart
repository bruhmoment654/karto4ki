import 'package:drift/drift.dart';
import 'package:quizzerg/core/utils/uuid_generator.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/study_progress_entity.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Конвертер для [TestGroupEntity] и [TestGroupDatabaseDto].
abstract final class TestGroupConverter {
  /// Конвертирует [TestGroupDatabaseDto] в [TestGroupEntity].
  static TestGroupEntity fromDto(
    TestGroupDatabaseDto dto, {
    required int testCount,
    StudyProgressEntity progress = StudyProgressEntity.empty,
  }) {
    return TestGroupEntity(
      id: dto.id,
      title: dto.title,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      testCount: testCount,
      progress: progress,
    );
  }

  /// Создаёт компаньон для вставки новой группы.
  static TestGroupsCompanion toNewCompanion({
    required String title,
    String? id,
  }) {
    final now = DateTime.now().toUtc();
    return TestGroupsCompanion.insert(
      id: id ?? UuidGenerator.v7(),
      title: title,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Компаньон для обновления группы.
  ///
  /// Поля `updated_at` и `sync_state` проставляет DAO.
  static TestGroupsCompanion toUpdateCompanion(TestGroupEntity entity) {
    return TestGroupsCompanion(
      id: Value(entity.id),
      title: Value(entity.title),
    );
  }
}
