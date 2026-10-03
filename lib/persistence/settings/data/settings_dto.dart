import 'package:json_annotation/json_annotation.dart';

import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_algorithm.dart';

part 'settings_dto.g.dart';

/// Режим темы приложения.
enum AppThemeMode {
  light,
  dark,
  system,
}

/// Стиль цветовой палитры приложения.
///
/// Новый стиль — новое значение здесь и палитра в `lib/uikit/theme/palette/`.
enum AppColorStyle {
  /// Material You: вся палитра из акцента.
  colorful,

  /// Шкала серого и один акцент.
  monochrome,

  /// Монохром с чисто чёрным фоном в тёмной теме.
  amoled,
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

  /// Стиль палитры. Неизвестное значение (настройки из более новой версии)
  /// читается как цветной.
  @JsonKey(unknownEnumValue: AppColorStyle.colorful)
  final AppColorStyle colorStyle;

  /// Алгоритм подмешивания вопросов.
  final MixupAlgorithm mixupAlgorithm;

  /// Максимальный размер шрифта текста на карточке в px (24–200).
  ///
  /// Текст подгоняется под доступное место: короткий растёт до этого размера,
  /// длинный переносится и ужимается. Чем больше значение, тем крупнее текст.
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
    this.colorStyle = AppColorStyle.colorful,
    this.mixupAlgorithm = MixupAlgorithm.classic,
    this.cardFontSize = 96.0,
    this.streakNegativeBonus = 0.35,
    this.streakPositivePenalty = 0.35,
  });

  factory SettingsDto.fromJson(Map<String, dynamic> json) =>
      _$SettingsDtoFromJson(json);

  /// Копия с изменёнными полями.
  ///
  /// Настройки правят сразу несколько BLoC'ов, поэтому каждый обновляет
  /// только свои поля поверх актуального снимка из хранилища.
  SettingsDto copyWith({
    int? animationDurationMs,
    bool? shaderAnimationEnabled,
    double? accentColorHue,
    bool? mixupEnabled,
    int? mixupMin,
    int? mixupMax,
    AppThemeMode? themeMode,
    AppColorStyle? colorStyle,
    MixupAlgorithm? mixupAlgorithm,
    double? cardFontSize,
    double? streakNegativeBonus,
    double? streakPositivePenalty,
  }) {
    return SettingsDto(
      animationDurationMs: animationDurationMs ?? this.animationDurationMs,
      shaderAnimationEnabled:
          shaderAnimationEnabled ?? this.shaderAnimationEnabled,
      accentColorHue: accentColorHue ?? this.accentColorHue,
      mixupEnabled: mixupEnabled ?? this.mixupEnabled,
      mixupMin: mixupMin ?? this.mixupMin,
      mixupMax: mixupMax ?? this.mixupMax,
      themeMode: themeMode ?? this.themeMode,
      colorStyle: colorStyle ?? this.colorStyle,
      mixupAlgorithm: mixupAlgorithm ?? this.mixupAlgorithm,
      cardFontSize: cardFontSize ?? this.cardFontSize,
      streakNegativeBonus: streakNegativeBonus ?? this.streakNegativeBonus,
      streakPositivePenalty:
          streakPositivePenalty ?? this.streakPositivePenalty,
    );
  }

  Map<String, dynamic> toJson() => _$SettingsDtoToJson(this);
}
