/// Получение Google ID-token на устройстве.
///
/// Контракт доменный: наружу отдаётся готовый токен, а не транспортный
/// результат. `serverClientId` сюда не входит — его знает реализация,
/// блоку авторизации про OAuth-клиенты знать незачем.
abstract interface class IGoogleSignInService {
  /// Возвращает Google ID-token, подписанный переданным [nonce].
  ///
  /// Бросает [GoogleSignInCancelled], если пользователь закрыл пикер,
  /// и [GoogleSignInFailure] на любой технической проблеме.
  Future<String> idToken({required String nonce});

  /// Разлогин на стороне Google (чтобы следующий вход снова спросил аккаунт).
  Future<void> signOut();
}

/// Пользователь закрыл пикер аккаунтов.
///
/// Не ошибка: экран должен просто вернуться в исходное состояние.
/// Отдельный тип нужен, чтобы блок отличил отмену от сбоя — иначе
/// закрывший пикер увидит баннер с `PlatformException(...)`.
class GoogleSignInCancelled implements Exception {
  /// Что сказал натив. У настоящей отмены обычно пусто, а GMS складывает сюда
  /// и часть своих сбоев — `[16] Account reauth failed` приходит тем же типом
  /// исключения. Пользователю это показывать не нужно, но в логе оно быть
  /// обязано: иначе сбой не отличить от закрытого пикера.
  final String? reason;

  const GoogleSignInCancelled([this.reason]);

  @override
  String toString() => reason == null
      ? 'GoogleSignInCancelled'
      : 'GoogleSignInCancelled: $reason';
}

/// Вход не удался по технической причине.
class GoogleSignInFailure implements Exception {
  final String message;

  const GoogleSignInFailure(this.message);

  @override
  String toString() => 'GoogleSignInFailure: $message';
}

/// Заглушка для платформ без реализации.
///
/// Нужна для iOS: без неё оттуда полетел бы `MissingPluginException`
/// вместо внятного сообщения. Приложение при этом собирается и работает
/// как гость — вход просто недоступен.
class StubGoogleSignInService implements IGoogleSignInService {
  const StubGoogleSignInService();

  @override
  Future<String> idToken({required String nonce}) =>
      throw const GoogleSignInFailure(
        'Вход через Google на этой платформе ещё не реализован',
      );

  @override
  Future<void> signOut() async {}
}
