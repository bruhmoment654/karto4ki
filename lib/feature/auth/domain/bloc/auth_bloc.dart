import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/core/logger/error_logger.dart';
import 'package:quizzerg/feature/auth/data/converter/auth_user_converter.dart';
import 'package:quizzerg/feature/auth/data/dto/auth_dto.dart';
import 'package:quizzerg/feature/auth/data/service/i_google_sign_in_service.dart';
import 'package:quizzerg/feature/auth/data/storage/i_auth_user_storage.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_status.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_token_pair.dart';
import 'package:quizzerg/feature/auth/domain/entity/auth_user_entity.dart';
import 'package:quizzerg/feature/auth/domain/repository/i_auth_api_repository.dart';
import 'package:quizzerg/feature/auth/domain/repository/i_auth_status_repository.dart';
import 'package:quizzerg/feature/profile/domain/repository/i_profile_api_repository.dart';
import 'package:quizzerg/network/error/api_exception.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

/// BLoC авторизации.
///
/// Ведёт вход и рисует UI-состояние. Сессией владеет не он, а
/// [IAuthStatusRepository]: блок подписан на его поток статусов и там же
/// сохраняет и чистит токены. Тот же поток слушает синхронизация — блоки
/// друг о друге не знают.
final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static const _converter = AuthUserConverter();

  final IAuthApiRepository _api;
  final IProfileApiRepository _profileApi;
  final IAuthStatusRepository _authStatus;
  final IAuthUserStorage _userStorage;
  final IGoogleSignInService _googleSignIn;
  final ErrorLogger _errorLogger;

  StreamSubscription<AuthStatus>? _statusSubscription;

  AuthBloc({
    required IAuthApiRepository api,
    required IProfileApiRepository profileApi,
    required IAuthStatusRepository authStatus,
    required IAuthUserStorage userStorage,
    required IGoogleSignInService googleSignIn,
    required ErrorLogger errorLogger,
  })  : _api = api,
        _profileApi = profileApi,
        _authStatus = authStatus,
        _userStorage = userStorage,
        _googleSignIn = googleSignIn,
        _errorLogger = errorLogger,
        super(const AuthState.unknown()) {
    on<AuthEvent>(
      (event, emit) => switch (event) {
        _AuthEvent$Started() => _onStarted(emit),
        _AuthEvent$SignInRequested() => _onSignInRequested(emit),
        _AuthEvent$SignOutRequested() => _onSignOutRequested(emit),
        _AuthEvent$StatusChanged() => _onStatusChanged(event, emit),
        _AuthEvent$UserRefreshed() => _onUserRefreshed(emit),
      },
    );
  }

  @override
  Future<void> close() async {
    await _statusSubscription?.cancel();

    return super.close();
  }

  Future<void> _onStarted(Emitter<AuthState> emit) async {
    await _statusSubscription?.cancel();
    _statusSubscription = _authStatus.statusChanges.listen(
      (status) => add(AuthEvent.statusChanged(status)),
    );

    await _authStatus.restore();
  }

  /// Статус пришёл из репозитория — переводим его в состояние экрана.
  Future<void> _onStatusChanged(
    _AuthEvent$StatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    switch (event.status) {
      case AuthStatus.unknown:
        break;
      case AuthStatus.unauthorized:
        // Во время входа статус не меняется, так что затереть `authorizing`
        // этот случай не может.
        emit(const AuthState.unauthorized());
      case AuthStatus.expired:
        emit(AuthState.expired(user: state.user ?? _userStorage.get()));
      case AuthStatus.authorized:
        // Кеш профиля рисуется мгновенно, `/me` уточняет его следом.
        emit(AuthState.authorized(user: _userStorage.get()));
        await _refreshUser(emit);
    }
  }

  Future<void> _onUserRefreshed(Emitter<AuthState> emit) async {
    if (!state.isAuthorized) return;

    await _refreshUser(emit);
  }

  /// Перечитывает `/me` и обновляет кеш.
  ///
  /// Ошибки глотаются: офлайн — не повод ронять сессию, а 401 придёт
  /// в блок через сигнал транспорта.
  Future<void> _refreshUser(Emitter<AuthState> emit) async {
    try {
      final user = _converter.convert(await _profileApi.getMe());
      await _userStorage.save(user);
      if (state.isAuthorized) emit(AuthState.authorized(user: user));
    } on ApiException catch (error, stackTrace) {
      _errorLogger.logError(error, stackTrace);
    }
  }

  Future<void> _onSignInRequested(Emitter<AuthState> emit) async {
    if (state.isAuthorizing) return;

    emit(const AuthState.authorizing());

    try {
      await _signIn(retryOnInvalidNonce: true);
    } on GoogleSignInCancelled catch (error, stackTrace) {
      // Пользователь закрыл пикер — возвращаем экран как было, без баннера.
      // Ветка обязана стоять до `on Object`: порядок catch в Dart значим.
      //
      // Но в лог пишем, если натив прислал причину: GMS отдаёт часть своих
      // сбоев (`[16] Account reauth failed`) тем же типом, что и отмену,
      // и без лога такой сбой выглядит как «ничего не произошло».
      if (error.reason != null) _errorLogger.logError(error, stackTrace);
      //
      // Выданный nonce не «сгорает»: сервер списывает его только при обмене
      // в /auth/google, так что он просто истечёт через 5 минут.
      emit(const AuthState.unauthorized());

      return;
    } on ApiException catch (error, stackTrace) {
      _errorLogger.logError(error, stackTrace);
      emit(AuthState.unauthorized(error: error));

      return;
    } on Object catch (error, stackTrace) {
      _errorLogger.logError(error, stackTrace);
      emit(
        AuthState.unauthorized(
          error: UnknownApiException(message: error.toString()),
        ),
      );

      return;
    }

    // Дальше состояние приедет из репозитория: saveTokens поменял статус.
  }

  /// Цепочка входа: nonce → Google id-token → обмен на пару токенов.
  ///
  /// `401 auth.invalid_nonce` значит, что nonce протух, уже использован или
  /// инстанс сервера перезапустился (он держит nonce в памяти 5 минут).
  /// Лечится ровно одним повтором всей цепочки: лимит `/auth/*` считается
  /// по IP, и автоцикл съел бы 20 запросов в минуту на всех за общим NAT.
  ///
  /// `401 auth.invalid_token` не ретраится вообще: это либо баг конфигурации
  /// (audience/issuer), либо подделка.
  Future<void> _signIn({required bool retryOnInvalidNonce}) async {
    final nonce = await _api.nonce();
    final idToken = await _googleSignIn.idToken(nonce: nonce);

    try {
      await _saveTokens(await _api.google(idToken));
    } on AuthInvalidNonce catch (error, stackTrace) {
      if (!retryOnInvalidNonce) rethrow;

      _errorLogger.logError(error, stackTrace);
      await _signIn(retryOnInvalidNonce: false);
    }
  }

  Future<void> _saveTokens(TokenPairDto pair) => _authStatus.saveTokens(
        AuthTokenPair(
          accessToken: pair.accessToken,
          refreshToken: pair.refreshToken,
        ),
      );

  /// Выход из аккаунта.
  ///
  /// `/auth/logout` — best-effort: он отзывает refresh на сервере (иначе
  /// украденный токен живёт до 90 дней), но в любом исходе локальные токены
  /// чистятся и пользователь уходит в гости. Повторять потом нечем —
  /// токен уже недоступен.
  Future<void> _onSignOutRequested(Emitter<AuthState> emit) async {
    final refresh = (await _authStatus.tokens())?.refreshToken;
    if (refresh != null) await _tryLogout(refresh);

    await _userStorage.clear();
    await _trySignOutGoogle();
    // Статус на `unauthorized` меняет репозиторий, а не блок.
    await _authStatus.clear();
  }

  Future<void> _tryLogout(String refresh) async {
    try {
      await _api.logout(refresh);
    } on Object catch (error, stackTrace) {
      _errorLogger.logError(error, stackTrace);
    }
  }

  Future<void> _trySignOutGoogle() async {
    try {
      await _googleSignIn.signOut();
    } on Object catch (error, stackTrace) {
      _errorLogger.logError(error, stackTrace);
    }
  }
}
