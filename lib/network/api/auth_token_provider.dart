/// Источник токена доступа для транспортного слоя.
///
/// Реализация живёт в фиче авторизации: транспорт ничего не знает
/// ни про Google, ни про nonce, ни про secure storage.
abstract interface class IAuthTokenProvider {
  /// Текущий access-токен или `null`, если пользователь не авторизован.
  Future<String?> accessToken();

  /// Обновить пару токенов.
  ///
  /// Возвращает `true`, если обновление удалось и запрос можно повторить.
  /// Транспорт гарантирует single-flight: одновременно выполняется
  /// не больше одного обновления (иначе сервер сочтёт повторное
  /// использование refresh-токена компрометацией и отзовёт всю цепочку).
  Future<bool> refreshTokens();

  /// Обновление не удалось — сессия истекла.
  ///
  /// Реализация чистит токены и уводит пользователя на экран входа.
  /// Локальные данные при этом трогать нельзя.
  Future<void> onSessionExpired();
}

/// Заглушка на время, пока авторизация не реализована.
///
/// Запросы уходят без заголовка `Authorization`; обновлять нечего.
class AnonymousAuthTokenProvider implements IAuthTokenProvider {
  const AnonymousAuthTokenProvider();

  @override
  Future<String?> accessToken() async => null;

  @override
  Future<bool> refreshTokens() async => false;

  @override
  Future<void> onSessionExpired() async {}
}
