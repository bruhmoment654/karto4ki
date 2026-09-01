/// Время правки, отправляемое на сервер.
abstract final class SyncClock {
  /// `updatedAt = max(now, lastKnownServerUpdatedAt + 1ms)`.
  ///
  /// Без этого устройство с отстающими часами залипает навсегда: его
  /// правки вечно отвергаются как `server_newer`, потому что серверное
  /// время записи больше локального «сейчас».
  static DateTime bumpedUpdatedAt(DateTime? serverUpdatedAt, {DateTime? now}) {
    final current = (now ?? DateTime.now()).toUtc();
    if (serverUpdatedAt == null) return current;

    final floor = serverUpdatedAt.toUtc().add(const Duration(milliseconds: 1));

    return current.isAfter(floor) ? current : floor;
  }

  /// Разбирает серверное время из колонки `server_updated_at` (ISO-8601).
  static DateTime? parseServerUpdatedAt(String? raw) {
    if (raw == null || raw.isEmpty) return null;

    return DateTime.tryParse(raw)?.toUtc();
  }

  /// Формат хранения серверного времени.
  static String format(DateTime value) => value.toUtc().toIso8601String();
}
