import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/progress/animated_circular_progress.dart';

/// Размер кольца точности: диаметр, толщина дуги и кегль процента.
enum AppAccuracyRingSize {
  /// Карточка теста.
  small(diameter: 48, strokeWidth: 5, fontSize: 13),

  /// Карточка группы на главной.
  medium(diameter: 64, strokeWidth: 6, fontSize: 15),

  /// Сводка группы.
  large(diameter: 88, strokeWidth: 7, fontSize: 18);

  final double diameter;
  final double strokeWidth;
  final double fontSize;

  const AppAccuracyRingSize({
    required this.diameter,
    required this.strokeWidth,
    required this.fontSize,
  });
}

/// Кольцо точности с процентом в центре.
///
/// [value] — 0..1; `null` — точности нет: пустой трек и «—».
/// Трек — 18% цвета дуги, поэтому кольцо тональное на любом контейнере.
class AppAccuracyRing extends StatelessWidget {
  static const _trackAlpha = 0.18;

  final double? value;

  /// Цвет дуги.
  final Color color;

  /// Цвет процента.
  final Color textColor;
  final AppAccuracyRingSize size;

  const AppAccuracyRing({
    required this.value,
    required this.color,
    required this.textColor,
    this.size = AppAccuracyRingSize.medium,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final value = this.value;
    final label = value == null ? '—' : '${(value * 100).round()}%';

    return AnimatedCircularProgress(
      value: value ?? 0,
      color: color,
      trackColor: color.withValues(alpha: _trackAlpha),
      size: size.diameter,
      strokeWidth: size.strokeWidth,
      semanticsLabel: label,
      child: Text(
        label,
        style: TextStyle(
          fontSize: size.fontSize,
          fontWeight: FontWeight.w800,
          color: textColor,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}
