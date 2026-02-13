import 'package:json_annotation/json_annotation.dart';

part 'settings_dto.g.dart';

/// DTO настроек приложения.
@JsonSerializable(checked: true)
class SettingsDto {
  /// Длительность анимаций в миллисекундах.
  final int animationDurationMs;

  const SettingsDto({
    this.animationDurationMs = 300,
  });

  factory SettingsDto.fromJson(Map<String, dynamic> json) =>
      _$SettingsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsDtoToJson(this);
}
