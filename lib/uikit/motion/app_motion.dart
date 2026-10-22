import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Константы движения для entrance/transition-анимаций редизайна.
///
/// Источник — `design_handoff_material_you/ANIMATIONS.md`.
class AppMotion {
  AppMotion._();

  /// Кривая M3 emphasized — основная для появления контента.
  static const emphasized = Cubic(0.2, 0, 0, 1);

  /// Пружина с лёгким overshoot — для «выскакивающих» элементов (FAB и т.п.).
  static const spring = Cubic(0.05, 0.7, 0.1, 1);

  static const fast = Duration(milliseconds: 220);
  static const medium = Duration(milliseconds: 440);
  static const fill = Duration(milliseconds: 900);
  static const ring = Duration(milliseconds: 1050);
  static const liquid = Duration(milliseconds: 1200);

  /// true → пользователь отключил анимации в системе (показываем финал сразу).
  static bool reduced(BuildContext context) => MediaQuery.of(context).disableAnimations;
}

class SpringCurve extends Cubic {
  const SpringCurve(super.a, super.b, super.c, super.d);

  @override
  double transformInternal(double t) {
    if (t == 0) return 0;
    if (t == 1) return 1;

    final value =
        math.pow(1 - t, 3) * a +
        3 * math.pow(1 - t, 2) * t * b +
        3 * (1 - t) * t * t * c +
        t * t * t * d;

    if (value >= 1) return 1;

    return value;
  }
}
