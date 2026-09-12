import 'package:dio/dio.dart';

import 'package:quizzerg/feature/auth/data/dto/auth_dto.dart';
import 'package:quizzerg/feature/auth/domain/repository/i_auth_api_repository.dart';
import 'package:quizzerg/network/api/api_client.dart';

/// Реализация [IAuthApiRepository] поверх REST.
class AuthApiRepository implements IAuthApiRepository {
  /// Таймаут выхода из аккаунта.
  ///
  /// Разлогин не должен ждать сеть: локально токены чистятся в любом исходе.
  static const logoutTimeout = Duration(seconds: 5);

  final ApiClient _client;

  const AuthApiRepository({required ApiClient client}) : _client = client;

  @override
  Future<String> nonce() => _client.request(
        send: (dio) => dio.post<Object?>('/auth/nonce'),
        parse: (data) => NonceDto.fromJson(ApiClient.asMap(data)).nonce,
      );

  @override
  Future<TokenPairDto> google(String idToken) => _client.request(
        send: (dio) => dio.post<Object?>(
          '/auth/google',
          data: GoogleSignInDto(idToken: idToken).toJson(),
        ),
        parse: (data) => TokenPairDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<TokenPairDto> refresh(String refresh) => _client.request(
        send: (dio) => dio.post<Object?>(
          '/auth/refresh',
          data: RefreshRequestDto(refresh: refresh).toJson(),
        ),
        parse: (data) => TokenPairDto.fromJson(ApiClient.asMap(data)),
      );

  @override
  Future<void> logout(String refresh) => _client.requestVoid(
        (dio) => dio.post<Object?>(
          '/auth/logout',
          data: RefreshRequestDto(refresh: refresh).toJson(),
          options: Options(
            receiveTimeout: logoutTimeout,
            sendTimeout: logoutTimeout,
          ),
        ),
      );
}
