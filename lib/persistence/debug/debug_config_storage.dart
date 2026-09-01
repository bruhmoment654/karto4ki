import 'package:quizzerg/persistence/debug/i_debug_config_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Реализация [IDebugConfigStorage] поверх SharedPreferences.
class DebugConfigStorage implements IDebugConfigStorage {
  static const _proxyUrlKey = 'debug_proxy_url';

  final SharedPreferences _prefs;

  const DebugConfigStorage(this._prefs);

  @override
  String? getProxyUrl() => _prefs.getString(_proxyUrlKey);

  @override
  Future<void> setProxyUrl(String? proxyUrl) => proxyUrl == null
      ? _prefs.remove(_proxyUrlKey)
      : _prefs.setString(_proxyUrlKey, proxyUrl);
}
