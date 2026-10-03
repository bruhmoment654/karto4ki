import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Рисует трек на всю ширину и залитый отрезок [start]..[end] с волнистыми
/// (синусоидными) краями.
///
/// Общая отрисовка для `WaveFillBar` и `WaveProgressBar`: у первого отрезок
/// всегда начинается от левого края, у второго в неопределённом режиме бежит
/// по треку.
class WaveFillPainter extends CustomPainter {
  WaveFillPainter({
    required this.end,
    required this.phase,
    required this.amplitude,
    required this.color,
    required this.background,
    this.start = 0,
  });

  /// Начало залитого отрезка 0..1. При 0 левый край плоский.
  final double start;

  /// Конец залитого отрезка 0..1. При 1 правый край плоский.
  final double end;

  /// Фаза колыхания фронта в радианах.
  final double phase;

  /// Амплитуда волны фронта (0 — фронт плоский).
  final double amplitude;
  final Color color;
  final Color background;

  /// Число периодов синусоиды по высоте полоски (меньше — плавнее).
  static const _cycles = 0.5;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = background);
    if (end <= start) return;

    final paint = Paint()..color = color;
    final startX = start * size.width;
    final endX = end * size.width;

    // Полностью залито или анимация отключена — плоские границы.
    if (amplitude == 0 || (start <= 0 && end >= 1)) {
      canvas.drawRect(
        Rect.fromLTWH(startX, 0, endX - startX, size.height),
        paint,
      );

      return;
    }

    final path = Path();
    _addEdge(
      path,
      size: size,
      edgeX: startX,
      isWavy: start > 0,
      isDownward: true,
    );
    _addEdge(
      path,
      size: size,
      edgeX: endX,
      isWavy: end < 1,
      isDownward: false,
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  /// Добавляет в [path] вертикальный край отрезка: сверху вниз при
  /// [isDownward], иначе снизу вверх. Плоский при `isWavy == false`.
  void _addEdge(
    Path path, {
    required Size size,
    required double edgeX,
    required bool isWavy,
    required bool isDownward,
  }) {
    final from = isDownward ? 0.0 : size.height;
    final to = isDownward ? size.height : 0.0;

    if (!isWavy) {
      if (isDownward) {
        path
          ..moveTo(edgeX, from)
          ..lineTo(edgeX, to);
      } else {
        path
          ..lineTo(edgeX, from)
          ..lineTo(edgeX, to);
      }

      return;
    }

    final step = isDownward ? 1.0 : -1.0;
    var isFirst = true;
    for (var posY = from; isDownward ? posY <= to : posY >= to; posY += step) {
      final wave = amplitude *
          math.sin(2 * math.pi * _cycles * (posY / size.height) + phase);
      if (isFirst && isDownward) {
        path.moveTo(edgeX + wave, posY);
      } else {
        path.lineTo(edgeX + wave, posY);
      }
      isFirst = false;
    }
  }

  @override
  bool shouldRepaint(WaveFillPainter old) =>
      old.start != start ||
      old.end != end ||
      old.phase != phase ||
      old.amplitude != amplitude ||
      old.color != color ||
      old.background != background;
}
