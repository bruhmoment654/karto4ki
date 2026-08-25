import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';
import 'package:quizzerg/uikit/motion/count_up_text.dart';

/// Кольцо-заполнение: дуга-прогресс от 12 часов по часовой стрелке на
/// [percent] процентов, в центре — процент через [CountUpText], под кольцом —
/// [label] и [sub].
///
/// reduced-motion ([AppMotion.reduced]): дуга сразу на финальном значении.
class FillRing extends StatefulWidget {
  const FillRing({
    required this.percent,
    required this.color,
    required this.label,
    required this.sub,
    this.size = 92,
    this.thickness = 10,
    this.animationDelay = Duration.zero,
    super.key,
  });

  /// Заполнение в процентах (0..100).
  final int percent;

  /// Цвет дуги и центрального процента.
  final Color color;

  /// Подпись под кольцом (название метрики).
  final String label;

  /// Вторичная подпись (например, «247/278»).
  final String sub;

  final double size;
  final double thickness;

  /// Задержка перед запуском анимации дуги (для каскада из нескольких колец).
  final Duration animationDelay;

  @override
  State<FillRing> createState() => _FillRingState();
}

class _FillRingState extends State<FillRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _sweep;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppMotion.ring);
    _sweep = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;

    if (AppMotion.reduced(context)) {
      _controller.value = 1;
    } else {
      Future<void>.delayed(widget.animationDelay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final target = widget.percent.clamp(0, 100) / 100;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          dimension: widget.size,
          child: AnimatedBuilder(
            animation: _sweep,
            builder: (context, child) {
              return CustomPaint(
                painter: _RingPainter(
                  progress: _sweep.value * target,
                  color: widget.color,
                  track: cs.surfaceContainerHigh,
                  thickness: widget.thickness,
                ),
                child: child,
              );
            },
            child: Center(
              child: CountUpText(
                value: widget.percent,
                suffix: '%',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: widget.color,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.label,
          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 1),
        Text(
          widget.sub,
          style: textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.color,
    required this.track,
    required this.thickness,
  });

  /// Доля заполнения 0..1.
  final double progress;
  final Color color;
  final Color track;
  final double thickness;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      thickness / 2,
      thickness / 2,
      size.width - thickness,
      size.height - thickness,
    );

    final trackPaint = Paint()
      ..color = track
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;
    canvas.drawArc(rect, 0, 2 * math.pi, false, trackPaint);

    if (progress <= 0) return;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.track != track ||
      old.thickness != thickness;
}
