import 'package:intl/intl.dart';

import 'package:quizzerg/l10n/app_localizations.dart';

/// Подписи времени последней синхронизации.
///
/// Дизайн просит две разные подписи, и это не одно и то же:
/// - карточка и бейдж — относительную («2 минуты назад»), то есть разницу
///   между «сейчас» и моментом синхронизации;
/// - диалог — абсолютную («Сегодня в 13:22»), то есть сам момент
///   в таймзоне устройства.
///
/// Относительная считается по серверным часам (`ServerClock.now`), иначе
/// устройство со сбитыми часами напишет «3 часа назад» сразу после
/// успешного прогона.
abstract final class SyncTimeFormat {
  /// Меньше этого — «только что».
  static const justNowThreshold = Duration(minutes: 1);

  /// Относительная подпись: «только что» / «5 минут назад» / «2 часа назад».
  ///
  /// Дальше суток относительная подпись бессмысленна — отдаём абсолютную.
  static String relative({
    required AppLocalizations l10n,
    required DateTime lastSyncedAt,
    required DateTime now,
  }) {
    final elapsed = now.difference(lastSyncedAt);
    if (elapsed < justNowThreshold) return l10n.syncTimeJustNow;
    if (elapsed.inHours < 1) return l10n.syncTimeMinutesAgo(elapsed.inMinutes);
    if (elapsed.inHours < 24) return l10n.syncTimeHoursAgo(elapsed.inHours);

    return absolute(l10n: l10n, lastSyncedAt: lastSyncedAt, now: now);
  }

  /// Абсолютная подпись: «сегодня в 13:22» / «вчера в 13:22» / «2 сентября
  /// в 13:22». Момент точный, поэтому циферблат верен даже при сбитых часах.
  static String absolute({
    required AppLocalizations l10n,
    required DateTime lastSyncedAt,
    required DateTime now,
  }) {
    final local = lastSyncedAt.toLocal();
    final time = DateFormat.Hm(l10n.localeName).format(local);
    final today = _dateOnly(now.toLocal());
    final day = _dateOnly(local);

    if (day == today) return l10n.syncTimeToday(time);
    if (day == today.subtract(const Duration(days: 1))) {
      return l10n.syncTimeYesterday(time);
    }

    return l10n.syncTimeAtDate(
      DateFormat.MMMMd(l10n.localeName).format(local),
      time,
    );
  }

  static DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);
}
