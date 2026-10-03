import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/feature/main/domain/entity/card_entity.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/test_attempt_entity.dart';

part 'attempt_summary.freezed.dart';

/// Как изменился ответ на вопрос относительно прошлых прохождений теста.
enum QuestionTrend {
  /// Верно, а раньше в этом тесте — только ошибки.
  firstCorrect,

  /// Верно после ошибки в прошлый раз.
  fixed,

  /// Ошибка после верного ответа в прошлый раз.
  forgot,

  /// Ошибка и в прошлый раз.
  repeatedMistake,

  /// Верно и в прошлый раз.
  stable,
}

/// Ответ на вопрос в завершённом прохождении.
@freezed
sealed class QuestionResult with _$QuestionResult {
  const factory QuestionResult({
    required CardEntity card,
    required bool isCorrect,

    /// Ответы на вопрос в прохождениях теста, от старых к новым; последний —
    /// текущий. Не длиннее [AttemptSummary.historyLength].
    required List<bool> history,

    /// `null` — в прошлых прохождениях теста вопроса не было.
    QuestionTrend? trend,
  }) = _QuestionResult;
}

/// Сводка для экрана результата: динамика прохождений и разбор по вопросам.
@freezed
sealed class AttemptSummary with _$AttemptSummary {
  const AttemptSummary._();

  /// Сколько последних прохождений показываем в динамике и в истории вопроса.
  static const historyLength = 5;

  const factory AttemptSummary({
    /// Последние прохождения теста от старых к новым; последнее — текущее.
    /// Пусто, если историю получить не удалось.
    required List<TestAttemptEntity> recentAttempts,

    /// Сколько всего раз тест пройден, включая текущий.
    required int totalAttempts,
    required List<QuestionResult> questions,
  }) = _AttemptSummary;

  /// История недоступна: показываем только текущие ответы.
  bool get hasHistory => recentAttempts.isNotEmpty;

  bool get isFirstAttempt => recentAttempts.length == 1;

  /// Разница в процентах с прошлым прохождением; `null`, если его нет.
  int? get percentDelta {
    if (recentAttempts.length < 2) return null;
    final current = recentAttempts.last;
    final previous = recentAttempts[recentAttempts.length - 2];
    return current.percent - previous.percent;
  }
}
