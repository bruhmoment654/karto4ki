part of 'question_stats_bloc.dart';

/// Состояние экрана статистики вопросов.
@freezed
sealed class QuestionStatsState with _$QuestionStatsState {
  const QuestionStatsState._();

  /// Статистика загружается.
  const factory QuestionStatsState.loading() = QuestionStatsState$Loading;

  /// Статистика загружена.
  const factory QuestionStatsState.loaded({
    /// Отфильтрованный и отсортированный список для показа.
    required List<QuestionStatsEntity> stats,

    /// Есть ли вообще статистика — отличает «пусто» от «ничего не нашлось».
    required bool hasAnyStats,
    required QuestionStatsSort sort,
    required SortOrder order,
    required String searchQuery,
  }) = QuestionStatsState$Loaded;

  /// Ошибка загрузки.
  const factory QuestionStatsState.error({
    required Failure failure,
  }) = QuestionStatsState$Error;
}
