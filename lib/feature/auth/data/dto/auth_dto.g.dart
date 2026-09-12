// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NonceDto _$NonceDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('NonceDto', json, ($checkedConvert) {
      final val = NonceDto(nonce: $checkedConvert('nonce', (v) => v as String));
      return val;
    });

TokenPairDto _$TokenPairDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TokenPairDto', json, ($checkedConvert) {
      final val = TokenPairDto(
        accessToken: $checkedConvert('accessToken', (v) => v as String),
        refreshToken: $checkedConvert('refreshToken', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$GoogleSignInDtoToJson(GoogleSignInDto instance) =>
    <String, dynamic>{'idToken': instance.idToken};

Map<String, dynamic> _$RefreshRequestDtoToJson(RefreshRequestDto instance) =>
    <String, dynamic>{'refresh': instance.refresh};
