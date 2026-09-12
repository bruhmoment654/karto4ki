part of 'auth_bloc.dart';

/// Состояние авторизации.
@freezed
sealed class AuthState with _$AuthState {
  /// Читаем хранилище, ещё не знаем.
  const factory AuthState.unknown() = AuthState$Unknown;

  /// Гость. [error] — провал последней попытки входа.
  const factory AuthState.unauthorized({ApiException? error}) =
      AuthState$Unauthorized;

  /// Идёт обмен nonce → idToken → токены.
  const factory AuthState.authorizing() = AuthState$Authorizing;

  /// Токены есть.
  ///
  /// [user] nullable намеренно: токены могут лежать в хранилище, а кеша
  /// профиля не быть (переустановка, чистка префов). Синхронизацию в этом
  /// случае всё равно надо запускать — она зависит от токена, а не от `/me`.
  const factory AuthState.authorized({AuthUserEntity? user}) =
      AuthState$Authorized;

  /// Refresh не удался — нужен перелогин.
  ///
  /// Отдельное состояние, а не разновидность гостя: именно по нему UI
  /// показывает индикатор синхронизации и красный тон, тогда как гостю
  /// не показывает ничего.
  const factory AuthState.expired({AuthUserEntity? user}) = AuthState$Expired;
}

/// Хелперы состояния, чтобы UI не разбирал sealed-класс вручную.
extension AuthStateX on AuthState {
  /// Пользователь, если он известен.
  AuthUserEntity? get user => switch (this) {
        AuthState$Authorized(:final user) => user,
        AuthState$Expired(:final user) => user,
        _ => null,
      };

  /// Есть ли действующая сессия.
  bool get isAuthorized => this is AuthState$Authorized;

  /// Нужен перелогин.
  bool get isExpired => this is AuthState$Expired;

  /// Идёт вход.
  bool get isAuthorizing => this is AuthState$Authorizing;

  /// Показывать ли блок синхронизации: у гостя его нет вовсе.
  bool get hasSession => isAuthorized || isExpired;
}
