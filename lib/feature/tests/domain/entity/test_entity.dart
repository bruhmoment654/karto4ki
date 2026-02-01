import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:karto4ki/feature/tests/domain/entity/test_type.dart';

part 'test_entity.freezed.dart';

/// Test entity that groups cards.
@freezed
sealed class TestEntity with _$TestEntity {
  const factory TestEntity({
    /// Unique test identifier.
    required String id,

    /// Test title.
    required String title,

    /// Test type.
    required TestType type,

    /// Creation date.
    required DateTime createdAt,

    /// Update date.
    required DateTime updatedAt,

    /// Test description.
    String? description,
  }) = _TestEntity;
}
