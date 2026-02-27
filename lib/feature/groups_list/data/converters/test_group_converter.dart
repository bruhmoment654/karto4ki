import 'package:drift/drift.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Конвертер для [TestGroupEntity] и [TestGroupDatabaseDto].
abstract final class TestGroupConverter {
  /// Конвертирует [TestGroupDatabaseDto] в [TestGroupEntity].
  static TestGroupEntity fromDto(
    TestGroupDatabaseDto dto, {
    required int testCount,
  }) {
    return TestGroupEntity(
      id: dto.id.toString(),
      title: dto.title,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      testCount: testCount,
    );
  }

  /// Создаёт [TestGroupsCompanion] для вставки новой группы.
  static TestGroupsCompanion toNewCompanion({
    required String title,
  }) {
    final now = DateTime.now();
    return TestGroupsCompanion.insert(
      title: title,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Конвертирует [TestGroupEntity] в [TestGroupsCompanion] для обновления.
  static TestGroupsCompanion toCompanion(TestGroupEntity entity) {
    return TestGroupsCompanion(
      id: Value(int.parse(entity.id)),
      title: Value(entity.title),
      createdAt: Value(entity.createdAt),
      updatedAt: Value(DateTime.now()),
    );
  }
}
