/// Часы сервера: сдвиг между локальным и серверным временем.
///
/// Зачем: часы устройства произвольно врут — ручная установка, слетевший
/// NTP, дешёвый Android с дрейфом. Если считать «сколько прошло с последней
/// синхронизации» как `DateTime.now() - lastSyncedAt`, где `lastSyncedAt`
/// пришёл с сервера, мы вычитаем одни часы из других: устройство, спешащее
/// на три часа, сразу после успешного прогона напишет «3 часа назад».
///
/// Поэтому обе подписи считаются в одной системе координат: относительная —
/// от [now], абсолютная — прямо из `lastSyncedAt`.
class ServerClock {
  Duration _skew = Duration.zero;
  bool _hasServerTime = false;

  /// Известен ли сдвиг. `false` до первого ответа на свежей установке.
  bool get hasServerTime => _hasServerTime;

  /// Текущий сдвиг. Хранится в `sync_meta`, чтобы переживать перезапуск.
  Duration get skew => _skew;

  /// Пересчитать сдвиг по `serverTime` из ответа синхронизации.
  void syncWith(DateTime serverTime) {
    _skew = serverTime.toUtc().difference(DateTime.now().toUtc());
    _hasServerTime = true;
  }

  /// Поднять сдвиг после холодного старта.
  ///
  /// Без этого первая же отрисовка экрана после запуска покажет
  /// относительное время по кривым локальным часам — то есть ровно тот баг,
  /// который эти часы и чинят.
  void restore(Duration skew) {
    _skew = skew;
    _hasServerTime = true;
  }

  /// «Сейчас» серверными часами.
  DateTime now() => DateTime.now().toUtc().add(_skew);
}
