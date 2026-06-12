import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/core/sync/domain/entity/sync_status.dart';

part 'test_group_entity.freezed.dart';

@freezed
sealed class TestGroupEntity with _$TestGroupEntity {
  const TestGroupEntity._();

  const factory TestGroupEntity({
    required String id,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int testCount,
    @Default(SyncStatus.local) SyncStatus syncStatus,
    DateTime? deletedAt,
  }) = _TestGroupEntity;

  /// Группа помечена удалённой.
  bool get isDeleted => deletedAt != null;
}
