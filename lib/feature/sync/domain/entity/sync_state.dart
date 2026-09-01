/// Состояние синхронизации строки локальной БД.
enum SyncState {
  /// Локальная копия подтверждена сервером.
  synced('synced'),

  /// Есть локальные изменения, которые ещё не уехали на сервер.
  pending('pending');

  /// Значение, как оно хранится в колонке `sync_state`.
  final String dbValue;

  const SyncState(this.dbValue);

  /// Разбирает значение из БД. Неизвестное считаем неотправленным —
  /// лишний push безопаснее потерянной правки.
  static SyncState fromDb(String value) => values.firstWhere(
        (it) => it.dbValue == value,
        orElse: () => SyncState.pending,
      );
}
