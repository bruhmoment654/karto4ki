import 'package:drift/drift.dart';
import 'package:quizzerg/core/sync/domain/entity/sync_status.dart';
import 'package:quizzerg/feature/tests_list/data/converters/test_type_converter.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_type.dart';
import 'package:quizzerg/persistence/database/app_database.dart';
import 'package:uuid/uuid.dart';

/// Converter for [TestEntity] and [TestDatabaseDto].
abstract final class TestConverter {
  static const _uuid = Uuid();

  /// Converts [TestDatabaseDto] to [TestEntity].
  static TestEntity fromDto(
    TestDatabaseDto dto, {
    int questionCount = 0,
  }) {
    return TestEntity(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      type: TestTypeConverter.fromDto(dto.type),
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      questionCount: questionCount,
      syncStatus: SyncStatus.fromDb(dto.syncStatus),
      deletedAt: dto.deletedAt,
    );
  }

  /// Converts [TestEntity] to [TestsCompanion] for insert/update.
  ///
  /// Локальная мутация помечает тест как ожидающий отправки на бэкенд.
  static TestsCompanion toCompanion(
    TestEntity entity, {
    bool updateTimestamp = true,
  }) {
    final now = DateTime.now();
    return TestsCompanion(
      id: Value(entity.id.isNotEmpty ? entity.id : _uuid.v4()),
      title: Value(entity.title),
      description: Value(entity.description),
      type: Value(TestTypeConverter.toDto(entity.type)),
      syncStatus: Value(SyncStatus.pending.dbValue),
      createdAt: Value(entity.createdAt),
      updatedAt: updateTimestamp ? Value(now) : Value(entity.updatedAt),
    );
  }

  /// Creates a new [TestsCompanion] for inserting a new test.
  static TestsCompanion toNewCompanion({
    required String title,
    String? description,
    TestType type = TestType.tinder,
  }) {
    final now = DateTime.now();
    return TestsCompanion.insert(
      id: _uuid.v4(),
      title: title,
      description: Value(description),
      type: TestTypeConverter.toDto(type),
      syncStatus: Value(SyncStatus.pending.dbValue),
      createdAt: now,
      updatedAt: now,
    );
  }
}
