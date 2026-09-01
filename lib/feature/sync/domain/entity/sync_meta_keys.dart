/// Ключи таблицы `sync_meta`.
abstract final class SyncMetaKeys {
  /// Opaque-курсор журнала изменений сервера.
  static const cursor = 'sync_cursor';

  /// Время последней успешной синхронизации (ISO-8601 UTC).
  static const lastSyncedAt = 'sync_last_synced_at';
}
