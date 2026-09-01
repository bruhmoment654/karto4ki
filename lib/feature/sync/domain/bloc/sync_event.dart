part of 'sync_bloc.dart';

/// События синхронизации.
@freezed
sealed class SyncEvent with _$SyncEvent {
  /// Старт: подписка на сеть и первый прогон.
  const factory SyncEvent.started() = _SyncEvent$Started;

  /// Синхронизировать сейчас (кнопка, возврат в foreground).
  const factory SyncEvent.requested() = _SyncEvent$Requested;

  /// Локальная мутация — запустить синхронизацию с дебаунсом.
  const factory SyncEvent.localMutation() = _SyncEvent$LocalMutation;

  /// Изменилось состояние сети.
  const factory SyncEvent.connectivityChanged({
    required List<ConnectivityResult> results,
  }) = _SyncEvent$ConnectivityChanged;

  /// Конфликты показаны пользователю, можно очистить очередь.
  const factory SyncEvent.conflictsShown() = _SyncEvent$ConflictsShown;
}
