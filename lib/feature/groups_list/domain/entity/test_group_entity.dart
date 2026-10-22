import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quizzerg/feature/question_stats/domain/entity/study_progress_entity.dart';

part 'test_group_entity.freezed.dart';

@freezed
sealed class TestGroupEntity with _$TestGroupEntity {
  const factory TestGroupEntity({
    required String id,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int testCount,

    /// Прогресс изучения по всем тестам группы.
    @Default(StudyProgressEntity.empty) StudyProgressEntity progress,
  }) = _TestGroupEntity;
}
