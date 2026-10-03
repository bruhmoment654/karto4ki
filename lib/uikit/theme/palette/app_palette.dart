import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';

/// Цветовая палитра приложения: по яркости и акценту строит роли M3
/// и цвета [AppColors].
///
/// Каждая палитра — отдельный класс. Темы компонентов (`AppTheme`) берут
/// цвета только отсюда, поэтому новая палитра не требует правок в теме.
abstract class AppPalette {
  const AppPalette();

  /// Роли M3 для [brightness]. [accent] — seed-цвет из слайдера настроек.
  ColorScheme colorScheme({
    required Brightness brightness,
    required Color accent,
  });

  /// Цвета сверх ролей M3 для схемы, построенной этой палитрой.
  AppColors appColors(ColorScheme scheme);
}
