import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// Спектральный цвет результата: красный→оранжевый→жёлтый→зелёный по hue
/// (6°→140°) в зависимости от процента [pct] (0..100).
Color spectrumColor(double pct) {
  final hue = 6 + (140 - 6) * (pct.clamp(0, 100) / 100);
  return HSVColor.fromAHSV(1, hue, 0.78, 0.92).toColor();
}

/// Круг результата с «жидкой» заливкой: вода поднимается до [pct], её цвет
/// плавно проходит спектр (см. [spectrumColor]), поверхность колышется.
///
/// В центре — иконка (если задана), процент и подпись «correct из total».
/// Число и цвет синхронизированы с подъёмом воды. Меньше [compactSize] —
/// компактная типографика.
///
/// reduced-motion ([AppMotion.reduced]): вода сразу на финальном уровне, без
/// колыхания, цвет финальный.
class LiquidScoreRing extends StatefulWidget {
  const LiquidScoreRing({
    required this.pct,
    required this.correct,
    required this.total,
    this.icon,
    this.size = 220,
    super.key,
  });

  /// Итоговый процент (0..100).
  final double pct;
  final int correct;
  final int total;
  final IconData? icon;
  final double size;

  /// Порог компактного вида: кольцо в строке-сводке, а не героем экрана.
  static const compactSize = 160.0;

  @override
  State<LiquidScoreRing> createState() => _LiquidScoreRingState();
}

class _LiquidScoreRingState extends State<LiquidScoreRing>
    with TickerProviderStateMixin {
  late final AnimationController _rise;
  late final AnimationController _drift;
  late final Animation<double> _level;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _rise = AnimationController(vsync: this, duration: AppMotion.liquid);
    _level = CurvedAnimation(parent: _rise, curve: Curves.easeOutCubic);
    _drift = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;

    if (AppMotion.reduced(context)) {
      _rise.value = 1;
    } else {
      _rise.forward();
      _drift.repeat();
    }
  }

  @override
  void dispose() {
    _rise.dispose();
    _drift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isCompact = widget.size < LiquidScoreRing.compactSize;
    final icon = widget.icon;

    return AnimatedBuilder(
      animation: Listenable.merge([_level, _drift]),
      builder: (context, _) {
        final current = _level.value * widget.pct;
        final color = spectrumColor(current);

        return SizedBox.square(
          dimension: widget.size,
          child: CustomPaint(
            painter: _LiquidPainter(
              level: current / 100,
              phase: _drift.value,
              color: color,
              track: cs.surfaceContainerHigh,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) Icon(icon, size: 34, color: color),
                  Text(
                    '${current.round()}%',
                    style: (isCompact
                            ? textTheme.displaySmall
                            : textTheme.displayLarge)
                        ?.copyWith(
                      fontWeight: FontWeight.w800,
                      height: 1,
                      color: cs.onSurface,
                    ),
                  ),
                  Text(
                    '${widget.correct} / ${widget.total}',
                    style: (isCompact
                            ? textTheme.labelMedium
                            : textTheme.labelLarge)
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LiquidPainter extends CustomPainter {
  _LiquidPainter({
    required this.level,
    required this.phase,
    required this.color,
    required this.track,
  });

  /// Высота воды 0..1 (доля от диаметра).
  final double level;

  /// Горизонтальный дрейф волны 0..1.
  final double phase;
  final Color color;
  final Color track;

  static const double _amplitude = 7;
  static const double _step = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    final circle = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));

    canvas
      ..save()
      ..clipPath(circle)
      ..drawColor(track, BlendMode.srcOver);

    final waterY = size.height * (1 - level);
    final waveLen = size.width;
    final dx = phase * waveLen;

    final wave = Path()
      ..moveTo(-waveLen, size.height)
      ..lineTo(-waveLen, waterY);
    for (var x = -waveLen; x <= size.width + waveLen; x += _step) {
      final y =
          waterY + _amplitude * math.sin((x + dx) / waveLen * 2 * math.pi);
      wave.lineTo(x, y);
    }
    wave
      ..lineTo(size.width + waveLen, size.height)
      ..close();

    canvas.drawPath(wave, Paint()..color = color.withValues(alpha: 0.32));

    final crest = Path()..moveTo(-waveLen, waterY);
    for (var x = -waveLen; x <= size.width + waveLen; x += _step) {
      final y =
          waterY + _amplitude * math.sin((x + dx) / waveLen * 2 * math.pi);
      crest.lineTo(x, y);
    }
    canvas
      ..drawPath(
        crest,
        Paint()
          ..color = color.withValues(alpha: 0.75)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      )
      ..restore();
  }

  @override
  bool shouldRepaint(_LiquidPainter old) =>
      old.level != level || old.phase != phase || old.color != color;
}
