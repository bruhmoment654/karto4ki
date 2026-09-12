import 'package:quizzerg/feature/auth/domain/entity/auth_token_pair.dart';

/// Защищённое хранилище пары токенов.
abstract interface class IAuthTokenStorage {
  /// Текущая пара или `null`, если пользователь не авторизован.
  Future<AuthTokenPair?> read();

  /// Записать пару целиком.
  ///
  /// Запись обязана быть атомарной: после ротации старый refresh мёртв
  /// сразу, и потеря нового означает разлогин на всех устройствах.
  Future<void> write(AuthTokenPair pair);

  /// Забыть токены.
  Future<void> clear();
}
