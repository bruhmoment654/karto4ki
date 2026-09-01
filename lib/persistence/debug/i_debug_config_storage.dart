/// Хранилище отладочных настроек.
///
/// Живёт отдельно от пользовательских настроек: это конфигурация сборки,
/// которая читается до создания сетевого клиента.
abstract interface class IDebugConfigStorage {
  /// Адрес прокси в формате `host:port` или `null`, если прокси выключен.
  String? getProxyUrl();

  /// Сохранить адрес прокси. `null` — выключить.
  Future<void> setProxyUrl(String? proxyUrl);
}
