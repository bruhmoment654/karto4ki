import 'package:flutter/material.dart';

/// Цвет рубашки по умолчанию (бренд-фиолетовый).
const _cardBackColor = Color(0xFF4A2FB0);

/// {@template card_back.class}
/// «Рубашка» игральной карты: крупная аргайл-решётка из ромбов на сплошном
/// фиолетовом фоне, от края до края, без рамки.
///
/// Параметр [draw] (0→1) каскадом «прочерчивает» решётку из угла. При
/// `draw == 1` рубашка статична (оборот карточки в прохождении), её также
/// использует сплеш `CardSwipeSplash`.
/// {@endtemplate}
class CardBack extends StatelessWidget {
  /// Прогресс прочерчивания решётки `[0; 1]` (1 — полностью отрисована).
  final double draw;

  /// Радиус скругления углов.
  final double radius;

  /// Цвет фона (например, цвет группы).
  final Color color;

  /// Цвет линий решётки; прозрачность задаёт сама решётка.
  final Color lineColor;

  /// {@macro card_back.class}
  const CardBack({
    this.draw = 1.0,
    this.radius = 20,
    this.color = _cardBackColor,
    this.lineColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CardBackPainter(
        draw: draw,
        radius: radius,
        color: color,
        lineColor: lineColor,
      ),
      child: const SizedBox.expand(),
    );
  }
}

/// Рисует фон и крупную аргайл-решётку с каскадным проявлением из угла
/// по [draw]. Шаг решётки масштабируется от ширины — ромбы остаются крупными
/// при любом размере карты.
class _CardBackPainter extends CustomPainter {
  final double draw;
  final double radius;
  final Color color;
  final Color lineColor;

  _CardBackPainter({
    required this.draw,
    required this.radius,
    required this.color,
    required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas
      ..save()
      ..clipRRect(rrect)
      ..drawRect(rect, Paint()..color = color);

    final width = size.width;
    final height = size.height;
    final step = width / 3.4; // шаг → очень крупные ромбы
    final overhang = step; // запас, чтобы линии доставали до углов
    final strokeWidth = (width / 210) * 2.0;
    final maxSweep = width + height;

    void diag(Offset a, Offset b, double sweepPos, double opacity) {
      // Каждая линия рисуется в окне шириной 0.45, сдвинутом по позиции.
      final start = (sweepPos / maxSweep) * 0.55;
      final progress = ((draw - start) / 0.45).clamp(0.0, 1.0);
      if (progress <= 0) return;
      final end = Offset.lerp(a, b, progress)!;
      canvas.drawLine(
        a,
        end,
        Paint()
          ..color = lineColor.withValues(alpha: lineColor.a * opacity)
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );
    }

    // Семейство A: x + y = c (наклон -1).
    for (var c = -overhang; c <= width + height + overhang; c += step) {
      diag(Offset(c + overhang, -overhang),
          Offset(c - (height + overhang), height + overhang), c, 0.55);
      diag(Offset(c + overhang + 4, -overhang),
          Offset(c - (height + overhang) + 4, height + overhang), c, 0.26);
    }
    // Семейство B: x - y = m (наклон +1).
    for (var m = -height - overhang; m <= width + overhang; m += step) {
      diag(Offset(m - overhang, -overhang),
          Offset(m + (height + overhang), height + overhang), m + height, 0.55);
      diag(
          Offset(m - overhang + 4, -overhang),
          Offset(m + (height + overhang) + 4, height + overhang),
          m + height,
          0.26);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CardBackPainter old) =>
      old.draw != draw ||
      old.radius != radius ||
      old.color != color ||
      old.lineColor != lineColor;
}
