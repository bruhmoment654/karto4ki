import 'package:quizzerg/core/feature/core/entity/request_operation.dart';

/// Репозиторий дебаг-экрана.
abstract interface class IDebugRepository {
  /// Текущий адрес прокси или `null`, если прокси выключен.
  String? getProxyUrl();

  /// Сохранить адрес прокси и применить его к сетевому клиенту.
  ///
  /// Пустая строка и `null` выключают прокси.
  RequestOperation<void> saveProxyUrl(String? proxyUrl);

  /// Base URL текущего окружения — показываем на экране для наглядности.
  String get baseUrl;
}
