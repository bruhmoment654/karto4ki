import 'package:quizzerg/core/auth/i_auth_service.dart';
import 'package:quizzerg/core/config/backend_config.dart';

/// Тестовая реализация [IAuthService]: статический токен из `--dart-define`
/// (`AUTH_TOKEN` — Supabase JWT или PAT со scope'ами sync).
///
/// Временное решение до полноценной авторизации через Supabase с экраном
/// входа. Вход/выход/регистрация не поддерживаются.
final class TokenAuthService implements IAuthService {
  const TokenAuthService();

  @override
  bool get isAvailable => BackendConfig.isConfigured;

  @override
  bool get isAuthenticated => isAvailable;

  @override
  String? get userId {
    if (!isAuthenticated) return null;
    if (BackendConfig.authUserId.isNotEmpty) return BackendConfig.authUserId;
    // PAT не раскрывает userId — используем стабильный суррогат от токена,
    // чтобы работал детект смены аккаунта (секрет в prefs не пишем).
    const token = BackendConfig.authToken;
    return token.length <= 12 ? token : token.substring(0, 12);
  }

  @override
  String? get email => null;

  @override
  Future<String?> getAccessToken() async =>
      isAuthenticated ? BackendConfig.authToken : null;

  @override
  Stream<AuthState> get stateChanges => const Stream.empty();

  @override
  Future<void> signIn({required String email, required String password}) =>
      throw UnsupportedError('Вход будет добавлен вместе с экраном авторизации');

  @override
  Future<void> signUp({required String email, required String password}) =>
      throw UnsupportedError(
        'Регистрация будет добавлена вместе с экраном авторизации',
      );

  @override
  Future<void> signOut() =>
      throw UnsupportedError('Выход будет добавлен вместе с экраном авторизации');
}
