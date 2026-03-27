import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_algorithm.dart';

part 'settings_dto.g.dart';

/// Режим темы приложения.
enum AppThemeMode {
  light,
  dark,
  system,
}

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

  /// Режим темы (light / dark / system).
  final AppThemeMode themeMode;

  /// Алгоритм подмешивания вопросов.
  final MixupAlgorithm mixupAlgorithm;

  /// Размер шрифта на карточках (14–40).
  final double cardFontSize;

  /// Бонус за отрицательный streak (вес в скоринге, 0.0–1.0).
  final double streakNegativeBonus;

  /// Штраф за положительный streak (вес в скоринге, 0.0–1.0).
  final double streakPositivePenalty;

  const SettingsDto({
    this.animationDurationMs = 300,
    this.shaderAnimationEnabled = true,
    this.accentColorHue = 149.0,
    this.mixupEnabled = false,
    this.mixupMin = 1,
    this.mixupMax = 5,
    this.themeMode = AppThemeMode.system,
    this.mixupAlgorithm = MixupAlgorithm.classic,
    this.cardFontSize = 24.0,
    this.streakNegativeBonus = 0.35,
    this.streakPositivePenalty = 0.35,
  });

  factory SettingsDto.fromJson(Map<String, dynamic> json) =>
      _$SettingsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsDtoToJson(this);
}
