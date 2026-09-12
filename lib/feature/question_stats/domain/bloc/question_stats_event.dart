part of 'question_stats_bloc.dart';

/// События экрана статистики вопросов.
@freezed
sealed class QuestionStatsEvent with _$QuestionStatsEvent {
  /// Загрузить статистику.
  const factory QuestionStatsEvent.started() = _QuestionStatsEvent$Started;

  /// Сменить критерий сортировки.
  const factory QuestionStatsEvent.sortChanged({
    required QuestionStatsSort sort,
  }) = _QuestionStatsEvent$SortChanged;

  /// Переключить направление сортировки.
  const factory QuestionStatsEvent.sortOrderToggled() =
      _QuestionStatsEvent$SortOrderToggled;

  /// Изменить поисковый запрос.
  const factory QuestionStatsEvent.searchChanged({
    required String query,
  }) = _QuestionStatsEvent$SearchChanged;

  /// Очистить поиск.
  const factory QuestionStatsEvent.searchCleared() =
      _QuestionStatsEvent$SearchCleared;
}
