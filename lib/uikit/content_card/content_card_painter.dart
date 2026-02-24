import 'package:flutter/rendering.dart';

import 'package:quizzerg/uikit/content_card/content_card_type.dart';

class ContentCardPainter extends CustomPainter {
  final ContentCardType type;
  final Color? accentColor;

  ContentCardPainter({
    required this.type,
    this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (type == ContentCardType.smallWide) {
      _paintLinear(canvas, size);
      return;
    }

    final circles = _getCircles(type, size);
    for (final circle in circles) {
      final rect = Rect.fromCircle(
        center: circle.center,
        radius: circle.radius,
      );
      final gradient = RadialGradient(
        colors: [
          circle.color,
          circle.color.withValues(alpha: circle.color.a * 0.6),
          circle.color.withValues(alpha: circle.color.a * 0.3),
          circle.color.withValues(alpha: circle.color.a * 0.12),
          circle.color.withValues(alpha: circle.color.a * 0.03),
          circle.color.withValues(alpha: 0),
        ],
        stops: const [0.0, 0.15, 0.35, 0.55, 0.78, 1.0],
      );
      final paint = Paint()..shader = gradient.createShader(rect);
      canvas.drawCircle(circle.center, circle.radius, paint);
    }
  }

  void _paintLinear(Canvas canvas, Size size) {
    final primary = accentColor ?? const Color(0xFF23FF8E);
    final color = primary.withValues(alpha: 0.10);
    final rect = Offset.zero & size;
    final gradient = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [
        color,
        color.withValues(alpha: color.a * 0.75),
        color.withValues(alpha: color.a * 0.45),
        color.withValues(alpha: color.a * 0.18),
        color.withValues(alpha: color.a * 0.05),
        color.withValues(alpha: 0),
      ],
      stops: const [0.0, 0.2, 0.4, 0.65, 0.85, 1.0],
    );
    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  List<_ResolvedCircle> _getCircles(ContentCardType type, Size size) {
    final primary = accentColor ?? const Color(0xFF23FF8E);
    const info = Color(0xFF42A5F5);

    return switch (type) {
      ContentCardType.large => [
          _ResolvedCircle(
            center: Offset(size.width * 0.05, size.height * 0.1),
            radius: size.shortestSide * 1.6,
            color: primary.withValues(alpha: 0.15),
          ),
          _ResolvedCircle(
            center: Offset(size.width * 0.9, size.height * 0.85),
            radius: size.shortestSide * 1.4,
            color: info.withValues(alpha: 0.12),
          ),
          _ResolvedCircle(
            center: Offset(size.width * 0.5, size.height * 1.0),
            radius: size.shortestSide * 1.1,
            color: primary.withValues(alpha: 0.08),
          ),
        ],
      ContentCardType.medium => [
          _ResolvedCircle(
            center: Offset(size.width * 0.9, size.height * 0.25),
            radius: size.shortestSide * 1.8,
            color: primary.withValues(alpha: 0.13),
          ),
          _ResolvedCircle(
            center: Offset(size.width * 0.1, size.height * 0.85),
            radius: size.shortestSide * 1.4,
            color: info.withValues(alpha: 0.08),
          ),
        ],
      ContentCardType.smallWide => [],
      ContentCardType.small => [
          _ResolvedCircle(
            center: Offset(size.width * 0.85, size.height * 0.3),
            radius: size.shortestSide * 2.8,
            color: primary.withValues(alpha: 0.08),
          ),
        ],
    };
  }

  @override
  bool shouldRepaint(ContentCardPainter oldDelegate) =>
      type != oldDelegate.type || accentColor != oldDelegate.accentColor;
}

class _ResolvedCircle {
  final Offset center;
  final double radius;
  final Color color;

  const _ResolvedCircle({
    required this.center,
    required this.radius,
    required this.color,
  });
}
