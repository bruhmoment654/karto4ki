part of 'sync_bloc.dart';

/// Состояние индикатора синхронизации.
///
/// Тон ошибки занят только под протухший токен: `offline` и `notSynced` —
/// информативные состояния, приложение offline-first и работает без сети.
@freezed
sealed class SyncStatus with _$SyncStatus {
  /// Гость: индикатора нет вообще.
  const factory SyncStatus.disabled() = SyncStatus$Disabled;

  /// Всё отправлено и забрано.
  const factory SyncStatus.synced({DateTime? lastSyncedAt}) =
      SyncStatus$Synced;

  /// Идёт обмен. [progress] известен только при первичной загрузке.
  const factory SyncStatus.syncing({
    DateTime? lastSyncedAt,
    SyncProgress? progress,
  }) = SyncStatus$Syncing;

  /// Есть локальные изменения, которые не уехали.
  const factory SyncStatus.notSynced({
    required int pending,
    DateTime? lastSyncedAt,
  }) = SyncStatus$NotSynced;

  /// Сети нет. Это штатный режим работы, не ошибка.
  const factory SyncStatus.offline({
    @Default(0) int pending,
    DateTime? lastSyncedAt,
  }) = SyncStatus$Offline;

  /// Токен протух, нужен перелогин. Единственное error-состояние.
  const factory SyncStatus.expired({DateTime? lastSyncedAt}) =
      SyncStatus$Expired;

  /// Прогон упал не по сети и не по токену — тап повторяет.
  const factory SyncStatus.failed({
    required ApiException error,
    @Default(0) int pending,
    DateTime? lastSyncedAt,
  }) = SyncStatus$Failed;
}

/// Общие поля статуса. Отдельным расширением, потому что у `disabled`
/// их нет и freezed не выносит их в базовый класс.
extension SyncStatusX on SyncStatus {
  DateTime? get lastSyncedAt => switch (this) {
        SyncStatus$Disabled() => null,
        SyncStatus$Synced(:final lastSyncedAt) => lastSyncedAt,
        SyncStatus$Syncing(:final lastSyncedAt) => lastSyncedAt,
        SyncStatus$NotSynced(:final lastSyncedAt) => lastSyncedAt,
        SyncStatus$Offline(:final lastSyncedAt) => lastSyncedAt,
        SyncStatus$Expired(:final lastSyncedAt) => lastSyncedAt,
        SyncStatus$Failed(:final lastSyncedAt) => lastSyncedAt,
      };

  /// Сколько изменений ждёт отправки.
  int get pending => switch (this) {
        SyncStatus$NotSynced(:final pending) => pending,
        SyncStatus$Offline(:final pending) => pending,
        SyncStatus$Failed(:final pending) => pending,
        _ => 0,
      };

  /// Прогресс первичной загрузки, если он известен.
  SyncProgress? get progress => switch (this) {
        SyncStatus$Syncing(:final progress) => progress,
        _ => null,
      };

  /// Показывать ли индикатор.
  bool get isVisible => this is! SyncStatus$Disabled;

  bool get isSyncing => this is SyncStatus$Syncing;

  bool get isExpired => this is SyncStatus$Expired;
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

    /// Откуда взято время последней синхронизации. При `local` подпись
    /// в диалоге мягче, а относительную не показываем вовсе.
    @Default(SyncTimeSource.server) SyncTimeSource lastSyncedSource,
  }) = _SyncState;
}
