import 'package:flutter/services.dart';

import 'package:quizzerg/feature/auth/data/service/google_auth_api.g.dart';
import 'package:quizzerg/feature/auth/data/service/i_google_sign_in_service.dart';

/// Реализация [IGoogleSignInService] поверх нативного Credential Manager.
///
/// Единственное место, где плоский результат Pigeon превращается в доменный
/// контракт: наружу уходит либо токен, либо типизированное исключение.
class GoogleSignInService implements IGoogleSignInService {
  final GoogleAuthApi _api;

  /// OAuth-клиент типа Web — его audience проверяет бэкенд.
  final String serverClientId;

  GoogleSignInService({
    required this.serverClientId,
    GoogleAuthApi? api,
  }) : _api = api ?? GoogleAuthApi();

  @override
  Future<String> idToken({required String nonce}) async {
    final GoogleSignInResult result;
    try {
      result = await _api.signIn(nonce, serverClientId);
    } on PlatformException catch (error) {
      // Сюда падает только необработанное исключение в нативе или обрыв
      // канала: ожидаемые исходы приезжают статусом.
      throw GoogleSignInFailure(error.message ?? error.code);
    }

    // switch исчерпывающий: добавишь статус в схему — компилятор укажет сюда.
    switch (result.status) {
      case GoogleSignInStatus.success:
        final token = result.idToken;
        if (token == null) {
          // Pigeon не умеет union-типов, поэтому success без токена
          // формально собирается. Запираем это здесь.
          throw const GoogleSignInFailure('Натив вернул пустой id-token');
        }

        return token;
      case GoogleSignInStatus.cancelled:
        throw GoogleSignInCancelled(result.errorMessage);
      case GoogleSignInStatus.noCredential:
        throw const GoogleSignInFailure(
          'На устройстве нет доступного Google-аккаунта',
        );
      case GoogleSignInStatus.failure:
        throw GoogleSignInFailure(result.errorMessage ?? 'Неизвестная ошибка');
    }
  }

  @override
  Future<void> signOut() => _api.signOut();
}
