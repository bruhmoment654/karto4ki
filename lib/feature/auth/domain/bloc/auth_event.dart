part of 'auth_bloc.dart';

/// События авторизации.
@freezed
sealed class AuthEvent with _$AuthEvent {
  /// Прочитать хранилище и поднять сессию.
  const factory AuthEvent.started() = _AuthEvent$Started;

  /// Нажата кнопка входа через Google.
  const factory AuthEvent.signInRequested() = _AuthEvent$SignInRequested;

  /// Нажат выход из аккаунта.
  const factory AuthEvent.signOutRequested() = _AuthEvent$SignOutRequested;

  /// Статус сессии изменился в репозитории.
  ///
  /// Единственный вход для «токены появились / пропали / протухли»:
  /// транспорт сообщает об этом репозиторию, а не блоку напрямую.
  const factory AuthEvent.statusChanged(AuthStatus status) =
      _AuthEvent$StatusChanged;

  /// Перечитать `/me`.
  const factory AuthEvent.userRefreshed() = _AuthEvent$UserRefreshed;
}
