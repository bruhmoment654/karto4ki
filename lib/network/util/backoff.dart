import 'dart:math';

/// Экспоненциальный бэкофф с джиттером.
abstract final class Backoff {
  static final _random = Random();

  /// Базовая задержка первой повторной попытки.
  static const defaultBase = Duration(milliseconds: 500);

  /// Потолок задержки.
  static const defaultMax = Duration(seconds: 30);

  /// Задержка перед попыткой [attempt] (нумерация с 1).
  ///
  /// Джиттер «равных долей»: половина задержки фиксированная, половина
  /// случайная. Так параллельные клиенты расходятся по времени, но
  /// повтор не улетает в ноль.
  static Duration delayFor(
    int attempt, {
    Duration base = defaultBase,
    Duration max = defaultMax,
    Random? random,
  }) {
    final shift = (attempt - 1).clamp(0, 16);
    final exponential = base.inMilliseconds << shift;
    final capped = min(exponential, max.inMilliseconds);
    final half = capped ~/ 2;
    final jitter = (random ?? _random).nextInt(capped - half + 1);

    return Duration(milliseconds: half + jitter);
  }
}
