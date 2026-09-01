import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/network/dto/utc_date_time_converter.dart';

part 'pat_dto.g.dart';

/// Personal Access Token без секрета.
@JsonSerializable(checked: true, createToJson: false)
class PatDto {
  final String id;
  final String name;

  /// Первые 12 символов токена — для идентификации в UI.
  final String prefix;

  /// Последние 4 символа — fingerprint.
  final String suffix;
  final List<String> scopes;

  @NullableUtcDateTimeConverter()
  final DateTime? lastUsedAt;

  @NullableUtcDateTimeConverter()
  final DateTime? expiresAt;

  @UtcDateTimeConverter()
  final DateTime createdAt;

  const PatDto({
    required this.id,
    required this.name,
    required this.prefix,
    required this.suffix,
    required this.scopes,
    required this.createdAt,
    this.lastUsedAt,
    this.expiresAt,
  });

  factory PatDto.fromJson(Map<String, dynamic> json) => _$PatDtoFromJson(json);
}

/// Ответ `GET /tokens`.
@JsonSerializable(checked: true, createToJson: false)
class PatListDto {
  final List<PatDto> tokens;

  const PatListDto({this.tokens = const []});

  factory PatListDto.fromJson(Map<String, dynamic> json) =>
      _$PatListDtoFromJson(json);
}

/// Тело `POST /tokens`.
@JsonSerializable(checked: true, createFactory: false, includeIfNull: false)
class CreatePatDto {
  final String name;
  final List<String> scopes;
  final int? expiresInDays;

  const CreatePatDto({
    required this.name,
    required this.scopes,
    this.expiresInDays,
  });

  Map<String, dynamic> toJson() => _$CreatePatDtoToJson(this);
}

/// Ответ `POST /tokens`. Поле `token` видно **один раз**.
@JsonSerializable(checked: true, createToJson: false)
class CreatePatResponseDto {
  final String id;
  final String token;
  final String name;
  final List<String> scopes;

  @NullableUtcDateTimeConverter()
  final DateTime? expiresAt;

  @UtcDateTimeConverter()
  final DateTime createdAt;

  const CreatePatResponseDto({
    required this.id,
    required this.token,
    required this.name,
    required this.scopes,
    required this.createdAt,
    this.expiresAt,
  });

  factory CreatePatResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePatResponseDtoFromJson(json);
}
