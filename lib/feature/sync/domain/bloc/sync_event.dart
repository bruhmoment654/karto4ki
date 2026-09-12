part of 'sync_bloc.dart';

/// События синхронизации.
@freezed
sealed class SyncEvent with _$SyncEvent {
  /// Старт: поднять сдвиг часов и подписаться на авторизацию.
  const factory SyncEvent.started() = _SyncEvent$Started;

  /// Синхронизировать сейчас (кнопка, возврат в foreground).
  const factory SyncEvent.requested() = _SyncEvent$Requested;

  /// Локальная правка — запустить синхронизацию с дебаунсом.
  ///
  /// Приходит из `ISyncSignalRepository`, а не из UI: экраны про
  /// синхронизацию не знают.
  const factory SyncEvent.localMutation() = _SyncEvent$LocalMutation;

  /// Изменилось состояние сети.
  const factory SyncEvent.connectivityChanged({
    required List<ConnectivityResult> results,
  }) = _SyncEvent$ConnectivityChanged;

  /// Изменилось состояние авторизации.
  const factory SyncEvent.authChanged(SyncAuthStatus status) =
      _SyncEvent$AuthChanged;

  /// Конфликты показаны пользователю, можно очистить очередь.
  const factory SyncEvent.conflictsShown() = _SyncEvent$ConflictsShown;
}
