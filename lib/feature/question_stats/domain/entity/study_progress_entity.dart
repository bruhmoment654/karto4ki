import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_progress_entity.freezed.dart';

/// Прогресс изучения теста или группы: вопросы по состояниям, точность и
/// последнее прохождение.
///
/// Вопрос — уникальный `question_key` среди живых карточек; четыре
/// состояния не пересекаются и в сумме дают [total].
@freezed
sealed class StudyProgressEntity with _$StudyProgressEntity {
  const StudyProgressEntity._();

  /// Порог «отличной точности».
  static const greatAccuracy = 0.9;

  static const empty = StudyProgressEntity();

  const factory StudyProgressEntity({
    /// Ни разу не показывались.
    @Default(0) int newCount,

    /// Показывались, но ещё не освоены и не слабые.
    @Default(0) int learningCount,

    /// Серия верных ответов не ниже порога освоения.
    @Default(0) int masteredCount,

    /// Последние ответы неверные.
    @Default(0) int weakCount,

    /// Доля верных ответов (0..1) за последние прохождения; `null` — на этом
    /// устройстве прохождений нет.
    double? accuracy,

    /// Последнее завершённое прохождение; `null` — прохождений нет.
    DateTime? lastStudiedAt,
  }) = _StudyProgressEntity;

  int get total => newCount + learningCount + masteredCount + weakCount;

  /// Есть вопросы, но ни один ещё не показывался.
  ///
  /// Считается по статистике, а не по точности: точность локальная и
  /// пропадает на другом устройстве или после очистки истории.
  bool get isNotStarted => total > 0 && newCount == total;

  bool get isGreatAccuracy => (accuracy ?? 0) >= greatAccuracy;
}
