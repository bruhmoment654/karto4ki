/// Фаза синхронизации.
enum SyncPhase {
  /// Ничего не происходит.
  idle,

  /// Цикл синхронизации выполняется.
  syncing,

  /// Последний цикл завершился ошибкой.
  error,
}

/// Состояние синхронизации для UI (строка статуса в настройках, бейджи).
class SyncState {
  /// Текущая фаза.
  final SyncPhase phase;

  /// Момент последней успешной синхронизации.
  final DateTime? lastSyncedAt;

  /// Количество сущностей, ожидающих отправки на бэкенд.
  final int pendingCount;

  const SyncState({
    this.phase = SyncPhase.idle,
    this.lastSyncedAt,
    this.pendingCount = 0,
  });

  SyncState copyWith({
    SyncPhase? phase,
    DateTime? lastSyncedAt,
    int? pendingCount,
  }) =>
      SyncState(
        phase: phase ?? this.phase,
        lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
        pendingCount: pendingCount ?? this.pendingCount,
      );
}
