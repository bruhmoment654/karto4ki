import 'package:quizzerg/l10n/app_localizations.dart';

/// Подписи прогресса изучения на карточках групп и тестов.
abstract final class StudyProgressFormat {
  /// «сегодня» / «вчера» / «N дней назад» — по календарным дням устройства.
  static String daysAgo({
    required AppLocalizations l10n,
    required DateTime at,
    required DateTime now,
  }) {
    final days = _dayOf(now).difference(_dayOf(at)).inDays;
    if (days <= 0) return l10n.progressToday;
    if (days == 1) return l10n.progressYesterday;

    return l10n.progressDaysAgo(days);
  }

  /// «10 тестов · занимались 2 дня назад» / «Нет тестов».
  static String groupSubtitle({
    required AppLocalizations l10n,
    required int testCount,
    required DateTime? lastStudiedAt,
    required DateTime now,
  }) => [
    if (testCount == 0)
      l10n.groupsListNoTests
    else
      l10n.groupsListTestCount(testCount),
    if (lastStudiedAt != null)
      l10n.progressStudied(daysAgo(l10n: l10n, at: lastStudiedAt, now: now)),
  ].join(' · ');

  /// Календарный день в UTC: так разница в днях не плывёт на переходе
  /// на летнее время.
  static DateTime _dayOf(DateTime moment) {
    final local = moment.toLocal();
    return DateTime.utc(local.year, local.month, local.day);
  }
}
