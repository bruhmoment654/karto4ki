import 'package:drift/drift.dart';

import 'package:quizzerg/core/utils/uuid_generator.dart';
import 'package:quizzerg/feature/tests_list/data/converters/test_type_converter.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_type.dart';
import 'package:quizzerg/persistence/database/app_database.dart';

/// Converter for [TestEntity] and [TestDatabaseDto].
abstract final class TestConverter {
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
    );
  }

  /// Компаньон для обновления существующего теста.
  ///
  /// Поля `updated_at` и `sync_state` проставляет DAO.
  static TestsCompanion toUpdateCompanion(TestEntity entity) {
    return TestsCompanion(
      id: Value(entity.id),
      title: Value(entity.title),
      description: Value(entity.description),
      type: Value(TestTypeConverter.toDto(entity.type)),
    );
  }

  /// Компаньон для вставки нового теста.
  static TestsCompanion toNewCompanion({
    required String title,
    String? description,
    String? id,
    TestType type = TestType.tinder,
  }) {
    final now = DateTime.now().toUtc();
    return TestsCompanion.insert(
      id: id ?? UuidGenerator.v7(),
      title: title,
      description: Value(description),
      type: TestTypeConverter.toDto(type),
      createdAt: now,
      updatedAt: now,
    );
  }
}
