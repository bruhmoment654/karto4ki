import 'package:intl/intl.dart';

import 'package:quizzerg/feature/test_execution/domain/entity/attempt_history_usage.dart';
import 'package:quizzerg/l10n/app_localizations.dart';

/// Подписи размера истории прохождений: «Занимает 1,2 МБ», «Пусто».
abstract final class AttemptHistoryFormat {
  /// Десятичные единицы, как в размерах файлов Android и iOS.
  static const _unit = 1000;

  /// Строка под заголовком карточки.
  static String usage(AppLocalizations l10n, AttemptHistoryUsage? usage) =>
      switch (usage) {
        null => l10n.settingsHistoryUsageUnknown,
        AttemptHistoryUsage(isEmpty: true) => l10n.settingsHistoryEmpty,
        AttemptHistoryUsage(:final bytes, isEstimate: true) =>
          l10n.settingsHistoryUsageEstimate(size(l10n, bytes)),
        AttemptHistoryUsage(:final bytes) => l10n.settingsHistoryUsage(
          size(l10n, bytes),
        ),
      };

  /// Размер по локали: «850 КБ», «1,2 МБ» / «850 KB», «1.2 MB».
  static String size(AppLocalizations l10n, int bytes) {
    if (bytes < _unit) {
      return l10n.settingsHistorySizeBytes(_number(l10n, bytes.toDouble()));
    }

    final kilobytes = bytes / _unit;
    // 999,6 КБ округлились бы до «1000 КБ» — такое показываем мегабайтами.
    if (kilobytes.round() < _unit) {
      return l10n.settingsHistorySizeKilobytes(_number(l10n, kilobytes));
    }

    return l10n.settingsHistorySizeMegabytes(_number(l10n, kilobytes / _unit));
  }

  /// До 10 — с десятыми, дальше целым: «1,2 МБ», «12 МБ».
  static int _fractionDigits(double value) => value < 10 ? 1 : 0;

  static String _number(AppLocalizations l10n, double value) {
    final format = NumberFormat.decimalPattern(l10n.localeName)
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = _fractionDigits(value);

    return format.format(value);
  }
}
