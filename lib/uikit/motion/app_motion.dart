import 'package:flutter/material.dart';

/// Константы движения для entrance/transition-анимаций редизайна.
///
/// Источник — `design_handoff_material_you/ANIMATIONS.md`.
class AppMotion {
  AppMotion._();

  /// Кривая M3 emphasized — основная для появления контента.
  static const emphasized = Cubic(0.2, 0, 0, 1);

  /// Пружина с лёгким overshoot — для «выскакивающих» элементов (FAB и т.п.).
  static const spring = Cubic(0.34, 1.56, 0.64, 1);

  static const fast = Duration(milliseconds: 220);
  static const medium = Duration(milliseconds: 440);
  static const fill = Duration(milliseconds: 900);
  static const ring = Duration(milliseconds: 1050);
  static const liquid = Duration(milliseconds: 1200);

  /// true → пользователь отключил анимации в системе (показываем финал сразу).
  static bool reduced(BuildContext context) =>
      MediaQuery.of(context).disableAnimations;
}
