/// Состояние авторизации.
enum AuthState {
  /// Бэкенд не сконфигурирован или пользователь не вошёл.
  unauthenticated,

  /// Пользователь авторизован, синхронизация доступна.
  authenticated,
}

/// Сервис авторизации (Supabase JWT).
abstract interface class IAuthService {
  /// Авторизация доступна (бэкенд сконфигурирован).
  bool get isAvailable;

  /// Пользователь авторизован.
  bool get isAuthenticated;

  /// userId (Supabase `sub`), null если не авторизован.
  String? get userId;

  /// Email текущего пользователя.
  String? get email;

  /// Актуальный access token (JWT) для Authorization-заголовка.
  Future<String?> getAccessToken();

  /// Изменения состояния авторизации.
  Stream<AuthState> get stateChanges;

  /// Вход по email/паролю.
  Future<void> signIn({required String email, required String password});

  /// Регистрация по email/паролю.
  Future<void> signUp({required String email, required String password});

  /// Выход из аккаунта.
  Future<void> signOut();
}
