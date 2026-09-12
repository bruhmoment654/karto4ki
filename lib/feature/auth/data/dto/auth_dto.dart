import 'package:json_annotation/json_annotation.dart';

part 'auth_dto.g.dart';

/// Ответ `POST /auth/nonce` (201).
@JsonSerializable(checked: true, createToJson: false)
class NonceDto {
  final String nonce;

  const NonceDto({required this.nonce});

  factory NonceDto.fromJson(Map<String, dynamic> json) =>
      _$NonceDtoFromJson(json);
}

/// Пара токенов из `/auth/google` (201) и `/auth/refresh` (200).
@JsonSerializable(checked: true, createToJson: false)
class TokenPairDto {
  final String accessToken;
  final String refreshToken;

  const TokenPairDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenPairDto.fromJson(Map<String, dynamic> json) =>
      _$TokenPairDtoFromJson(json);
}

/// Тело `POST /auth/google`.
@JsonSerializable(checked: true, createFactory: false)
class GoogleSignInDto {
  final String idToken;

  const GoogleSignInDto({required this.idToken});

  Map<String, dynamic> toJson() => _$GoogleSignInDtoToJson(this);
}

/// Тело `POST /auth/refresh` и `POST /auth/logout`.
@JsonSerializable(checked: true, createFactory: false)
class RefreshRequestDto {
  final String refresh;

  const RefreshRequestDto({required this.refresh});

  Map<String, dynamic> toJson() => _$RefreshRequestDtoToJson(this);
}
