import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/theme/palette/seed_palette.dart';

/// Цвета приложения сверх ролей [ColorScheme]. Значения задаёт палитра
/// (`AppPalette.appColors`), поэтому в монохроме они нейтральные.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  /// «Знаю», верный ответ, синхронизировано.
  final Color success;

  // M3-именование «on<роль>», как в ColorScheme, — это цвет, а не колбэк.
  // ignore: prefer-correct-callback-field-name
  final Color onSuccess;

  /// Требует внимания, но не ошибка.
  final Color warning;

  /// Нейтральная подсветка значения.
  final Color info;

  /// Контейнер FAB — главного действия экрана.
  final Color fab;

  // ignore: prefer-correct-callback-field-name
  final Color onFab;

  /// Шкала точности для крупных чисел и полос: ≥90%, ≥60%, ниже.
  final Color accuracyHigh;
  final Color accuracyMid;
  final Color accuracyLow;

  const AppColors({
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.info,
    required this.fab,
    required this.onFab,
    required this.accuracyHigh,
    required this.accuracyMid,
    required this.accuracyLow,
  });

  /// Если тема собрана не из палитры (тесты, сторонний `Theme`), берём
  /// цвета цветной палитры.
  static AppColors of(BuildContext context) => Theme.of(context).appColors;

  @override
  AppColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? info,
    Color? fab,
    Color? onFab,
    Color? accuracyHigh,
    Color? accuracyMid,
    Color? accuracyLow,
  }) {
    return AppColors(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      fab: fab ?? this.fab,
      onFab: onFab ?? this.onFab,
      accuracyHigh: accuracyHigh ?? this.accuracyHigh,
      accuracyMid: accuracyMid ?? this.accuracyMid,
      accuracyLow: accuracyLow ?? this.accuracyLow,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;

    return AppColors(
      success: _lerp(success, other.success, t),
      onSuccess: _lerp(onSuccess, other.onSuccess, t),
      warning: _lerp(warning, other.warning, t),
      info: _lerp(info, other.info, t),
      fab: _lerp(fab, other.fab, t),
      onFab: _lerp(onFab, other.onFab, t),
      accuracyHigh: _lerp(accuracyHigh, other.accuracyHigh, t),
      accuracyMid: _lerp(accuracyMid, other.accuracyMid, t),
      accuracyLow: _lerp(accuracyLow, other.accuracyLow, t),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppColors &&
          success == other.success &&
          onSuccess == other.onSuccess &&
          warning == other.warning &&
          info == other.info &&
          fab == other.fab &&
          onFab == other.onFab &&
          accuracyHigh == other.accuracyHigh &&
          accuracyMid == other.accuracyMid &&
          accuracyLow == other.accuracyLow;

  @override
  int get hashCode => Object.hash(
    success,
    onSuccess,
    warning,
    info,
    fab,
    onFab,
    accuracyHigh,
    accuracyMid,
    accuracyLow,
  );
}

extension AppColorsThemeX on ThemeData {
  AppColors get appColors =>
      extension<AppColors>() ?? const SeedPalette().appColors(colorScheme);
}

/// [Color.lerp] с ненулевыми концами не возвращает `null`.
Color _lerp(Color a, Color b, double progress) =>
    Color.lerp(a, b, progress) ?? a;
