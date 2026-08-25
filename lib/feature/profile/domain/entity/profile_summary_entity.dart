import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_summary_entity.freezed.dart';

/// Порог «изучено»: карточка считается изученной при серии не ниже этого.
const int kMasteredThreshold = 3;

/// Порог «слабые карточки»: карточка слабая, если её серия меньше этого.
const int kWeakThreshold = 0;

/// Агрегированная сводка статистики для экрана профиля.
///
/// Все поля — производные от посписочной статистики карточек и набора
/// активных дат. Вычисляется в `ProfileStatsCalculator`.
@freezed
sealed class ProfileSummaryEntity with _$ProfileSummaryEntity {
  const factory ProfileSummaryEntity({
    /// Всего ответов: сумма верных и неверных по всем карточкам.
    required int answersTotal,

    /// Всего верных ответов.
    required int correctTotal,

    /// Точность в процентах (0..100), 0 если ответов не было.
    required int accuracyPercent,

    /// Всего карточек со статистикой.
    required int totalCards,

    /// Карточек со streak >= [kMasteredThreshold].
    required int masteredCount,

    /// Доля изученных карточек в процентах (0..100).
    required int masteredPercent,

    /// Карточек без единой ошибки (`totalIncorrect == 0 && totalShown > 0`).
    required int flawlessCount,

    /// Доля безошибочных карточек в процентах (0..100).
    required int flawlessPercent,

    /// Слабых карточек: streak < [kWeakThreshold].
    required int weakCardsCount,

    /// Текущая серия активных дней подряд.
    required int currentStreak,

    /// Лучшая (рекордная) серия активных дней подряд.
    required int bestStreak,

    /// Всего дней активности.
    required int activeDaysCount,

    /// Среднее число ответов в день активности (0 если дней нет).
    required double avgAnswersPerDay,

    /// Активность по дням текущей недели: 7 значений Пн..Вс.
    required List<bool> weekActivity,

    /// Количество групп — для карточки-идентичности.
    required int groupsCount,

    /// Количество тестов — для карточки-идентичности.
    required int testsCount,
  }) = _ProfileSummaryEntity;
}
