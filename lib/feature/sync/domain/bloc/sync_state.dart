part of 'sync_bloc.dart';

/// Состояние индикатора синхронизации.
@freezed
sealed class SyncStatus with _$SyncStatus {
  /// Всё синхронизировано.
  const factory SyncStatus.idle({DateTime? lastSyncedAt}) = SyncStatus$Idle;

  /// Синхронизация идёт.
  const factory SyncStatus.syncing({DateTime? lastSyncedAt}) =
      SyncStatus$Syncing;

  /// Сети нет. Это штатное рабочее состояние, не ошибка.
  const factory SyncStatus.offline({DateTime? lastSyncedAt}) =
      SyncStatus$Offline;

  /// Синхронизация упала — тап по индикатору повторяет.
  const factory SyncStatus.failed({
    required ApiException error,
    DateTime? lastSyncedAt,
  }) = SyncStatus$Failed;
}

/// Состояние [SyncBloc].
@freezed
sealed class SyncState with _$SyncState {
  const factory SyncState({
    required SyncStatus status,

    /// Конфликты, о которых ещё не сказали пользователю.
    @Default(<SyncConflictReport>[]) List<SyncConflictReport> conflicts,

    /// Итог последнего прогона.
    SyncRunResult? lastRun,
  }) = _SyncState;
}
