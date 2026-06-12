import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/core/sync/domain/entity/sync_status.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_type.dart';

part 'test_entity.freezed.dart';

/// Test entity that groups cards.
@freezed
sealed class TestEntity with _$TestEntity {
  const TestEntity._();

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

    /// Количество вопросов (карточек) в тесте.
    @Default(0) int questionCount,

    /// Статус синхронизации с бэкендом.
    @Default(SyncStatus.local) SyncStatus syncStatus,

    /// Момент soft delete (null — тест жив).
    DateTime? deletedAt,
  }) = _TestEntity;

  /// Тест помечен удалённым («заморожен», ждёт purge).
  bool get isDeleted => deletedAt != null;
}
