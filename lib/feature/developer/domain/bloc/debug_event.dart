part of 'debug_bloc.dart';

/// События дебаг-экрана.
@freezed
sealed class DebugEvent with _$DebugEvent {
  /// Сохранить и применить адрес прокси.
  const factory DebugEvent.proxyApplied({
    required String? proxyUrl,
  }) = _DebugEvent$ProxyApplied;

  /// Выключить прокси.
  const factory DebugEvent.proxyCleared() = _DebugEvent$ProxyCleared;
}
