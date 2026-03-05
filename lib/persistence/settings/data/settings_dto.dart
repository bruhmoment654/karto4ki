import 'package:json_annotation/json_annotation.dart';

part 'settings_dto.g.dart';

/// DTO настроек приложения.
@JsonSerializable(checked: true)
class SettingsDto {
  /// Длительность анимаций в миллисекундах.
  final int animationDurationMs;

  /// Включена ли анимация шейдерного фона.
  final bool shaderAnimationEnabled;

  /// Оттенок accent-цвета (0–360°).
  final double accentColorHue;

  /// Включено ли подмешивание вопросов из других тестов группы.
  final bool mixupEnabled;

  /// Минимальное количество подмешиваемых вопросов.
  final int mixupMin;

  /// Максимальное количество подмешиваемых вопросов.
  final int mixupMax;

  const SettingsDto({
    this.animationDurationMs = 300,
    this.shaderAnimationEnabled = true,
    this.accentColorHue = 149.0,
    this.mixupEnabled = false,
    this.mixupMin = 1,
    this.mixupMax = 5,
  });

  factory SettingsDto.fromJson(Map<String, dynamic> json) =>
      _$SettingsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsDtoToJson(this);
}
