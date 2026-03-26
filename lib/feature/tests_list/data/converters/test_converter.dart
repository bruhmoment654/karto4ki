import 'package:drift/drift.dart';

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
      id: dto.id.toString(),
      title: dto.title,
      description: dto.description,
      type: TestTypeConverter.fromDto(dto.type),
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      questionCount: questionCount,
    );
  }

  /// Converts [TestEntity] to [TestsCompanion] for insert/update.
  static TestsCompanion toCompanion(
    TestEntity entity, {
    bool updateTimestamp = true,
  }) {
    final now = DateTime.now();
    return TestsCompanion(
      id: entity.id.isNotEmpty
          ? Value(int.parse(entity.id))
          : const Value.absent(),
      title: Value(entity.title),
      description: Value(entity.description),
      type: Value(TestTypeConverter.toDto(entity.type)),
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
      title: title,
      description: Value(description),
      type: TestTypeConverter.toDto(type),
      createdAt: now,
      updatedAt: now,
    );
  }
}
