part of 'debug_bloc.dart';

/// Чем закончилась попытка сохранить прокси. Текст подбирает View.
enum DebugProxyOutcome { applied, cleared, failed }

/// Состояние дебаг-экрана.
@freezed
sealed class DebugState with _$DebugState {
  const factory DebugState({
    /// Base URL текущего окружения.
    required String baseUrl,

    /// Сохранённый адрес прокси или `null`, если прокси выключен.
    String? proxyUrl,

    /// Одноразовый результат сохранения — показывается снеком.
    SideEffectValue<DebugProxyOutcome>? outcome,

    /// Текст ошибки последнего сохранения.
    String? errorMessage,
  }) = _DebugState;
}
