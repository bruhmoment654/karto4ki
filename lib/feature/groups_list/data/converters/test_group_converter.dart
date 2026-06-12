import 'package:drift/drift.dart';
import 'package:quizzerg/core/sync/domain/entity/sync_status.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
import 'package:uuid/uuid.dart';

/// Конвертер для [TestGroupEntity] и [TestGroupDatabaseDto].
abstract final class TestGroupConverter {
  static const _uuid = Uuid();

  /// Конвертирует [TestGroupDatabaseDto] в [TestGroupEntity].
  static TestGroupEntity fromDto(
    TestGroupDatabaseDto dto, {
    required int testCount,
  }) {
    return TestGroupEntity(
      id: dto.id,
      title: dto.title,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      testCount: testCount,
      syncStatus: SyncStatus.fromDb(dto.syncStatus),
      deletedAt: dto.deletedAt,
    );
  }

  /// Создаёт [TestGroupsCompanion] для вставки новой группы.
  static TestGroupsCompanion toNewCompanion({
    required String title,
  }) {
    final now = DateTime.now();
    return TestGroupsCompanion.insert(
      id: _uuid.v4(),
      title: title,
      syncStatus: Value(SyncStatus.pending.dbValue),
      createdAt: now,
      updatedAt: now,
    );
  }

  /// Конвертирует [TestGroupEntity] в [TestGroupsCompanion] для обновления.
  ///
  /// Локальная мутация помечает группу как ожидающую отправки на бэкенд.
  static TestGroupsCompanion toCompanion(TestGroupEntity entity) {
    return TestGroupsCompanion(
      id: Value(entity.id),
      title: Value(entity.title),
      syncStatus: Value(SyncStatus.pending.dbValue),
      createdAt: Value(entity.createdAt),
      updatedAt: Value(DateTime.now()),
    );
  }
}
