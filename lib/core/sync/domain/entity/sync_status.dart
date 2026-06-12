/// Статус синхронизации локальной сущности с бэкендом.
enum SyncStatus {
  /// Синхронизация не активна (создано до авторизации).
  local('local'),

  /// Есть локальные изменения, не отправленные на бэкенд.
  pending('pending'),

  /// Локальное восстановление из удалённых, не отправленное на бэкенд.
  pendingRestore('pending_restore'),

  /// Совпадает с бэкендом.
  synced('synced');

  const SyncStatus(this.dbValue);

  /// Значение, хранимое в колонке `sync_status`.
  final String dbValue;

  /// Не отправлено на бэкенд (для бейджа в UI).
  bool get isPending => this == pending || this == pendingRestore;

  static SyncStatus fromDb(String value) => SyncStatus.values.firstWhere(
        (s) => s.dbValue == value,
        orElse: () => SyncStatus.local,
      );
}
