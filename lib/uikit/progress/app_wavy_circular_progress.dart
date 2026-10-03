import 'package:flutter/material.dart';
import 'package:material_3_expressive/material_3_expressive.dart'
    show M3EProgressIndicator;
import 'package:quizzerg/uikit/m3e/m3e_scope.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// Круговая «змейка» M3 Expressive — лоадер для процесса, который идёт
/// прямо сейчас (например, в кнопке во время синхронизации).
///
/// [value] `null` — прогресс неизвестен: волнистая дуга бежит по кругу.
/// Иначе дуга заполняется до [value]; сам виджет пакета значение не
/// анимирует, поэтому смена [value] плавно доезжает здесь.
class AppWavyCircularProgress extends StatelessWidget {
  const AppWavyCircularProgress({
    required this.size,
    required this.color,
    required this.trackColor,
    this.value,
    this.strokeWidth = 3,
    this.semanticsLabel,
    super.key,
  });

  /// Заполнение 0..1 либо `null`, если прогресс неизвестен.
  final double? value;
  final double size;
  final Color color;
  final Color trackColor;
  final double strokeWidth;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final target = value;
    if (target == null) return _Indicator(config: this);

    return TweenAnimationBuilder<double>(
      tween: Tween(end: target.clamp(0, 1)),
      duration: AppMotion.reduced(context) ? Duration.zero : AppMotion.fast,
      curve: AppMotion.emphasized,
      builder: (_, current, __) => _Indicator(config: this, progress: current),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({required this.config, this.progress});

  final AppWavyCircularProgress config;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return M3EScope(
      child: M3EProgressIndicator.circularWavy(
        value: progress,
        size: config.size,
        strokeWidth: config.strokeWidth,
        trackStrokeWidth: config.strokeWidth,
        color: config.color,
        trackColor: config.trackColor,
        semanticsLabel: config.semanticsLabel,
      ),
    );
  }
}
