/// Ключи таблицы `sync_meta`.
abstract final class SyncMetaKeys {
  /// Opaque-курсор журнала изменений сервера.
  static const cursor = 'sync_cursor';

  /// Время последней успешной синхронизации (ISO-8601 UTC).
  static const lastSyncedAt = 'sync_last_synced_at';

  /// Источник этого времени: `server` или `local` (см. [SyncTimeSource]).
  static const lastSyncedSource = 'sync_last_synced_source';

  /// Сдвиг локальных часов относительно серверных, в миллисекундах.
  ///
  /// Ключ, а не колонка: `sync_meta` — key-value, миграция схемы не нужна.
  static const clockSkewMs = 'sync_clock_skew_ms';
}

/// Откуда взято время последней синхронизации.
enum SyncTimeSource {
  /// Поле `serverTime` из ответа — точный момент.
  server('server'),

  /// Часы устройства: сборка бэкенда без `serverTime`. Врать точно нельзя,
  /// поэтому относительную подпись по такому времени не показываем.
  local('local');

  final String dbValue;

  const SyncTimeSource(this.dbValue);

  static SyncTimeSource fromDb(String? raw) =>
      raw == local.dbValue ? local : server;
}
