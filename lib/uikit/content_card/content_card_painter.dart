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
    final circles = _getCircles(type, size);
    for (final circle in circles) {
      final paint = Paint()
        ..color = circle.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, circle.blurSigma);
      canvas.drawCircle(circle.center, circle.radius, paint);
    }
  }

  List<_ResolvedCircle> _getCircles(ContentCardType type, Size size) {
    final primary = accentColor ?? const Color(0xFF23FF8E);
    const info = Color(0xFF42A5F5);

    return switch (type) {
      ContentCardType.large => [
          _ResolvedCircle(
            center: Offset(size.width * 0.1, size.height * 0.15),
            radius: size.shortestSide * 0.35,
            color: primary.withValues(alpha: 0.07),
            blurSigma: 50,
          ),
          _ResolvedCircle(
            center: Offset(size.width * 0.85, size.height * 0.8),
            radius: size.shortestSide * 0.3,
            color: info.withValues(alpha: 0.06),
            blurSigma: 50,
          ),
          _ResolvedCircle(
            center: Offset(size.width * 0.5, size.height * 0.95),
            radius: size.shortestSide * 0.25,
            color: primary.withValues(alpha: 0.04),
            blurSigma: 50,
          ),
        ],
      ContentCardType.medium => [
          _ResolvedCircle(
            center: Offset(size.width * 0.9, size.height * 0.3),
            radius: size.shortestSide * 0.4,
            color: primary.withValues(alpha: 0.06),
            blurSigma: 35,
          ),
          _ResolvedCircle(
            center: Offset(size.width * 0.15, size.height * 0.8),
            radius: size.shortestSide * 0.3,
            color: info.withValues(alpha: 0.04),
            blurSigma: 30,
          ),
        ],
      ContentCardType.smallWide => [
          _ResolvedCircle(
            center: Offset(size.width * 0.95, size.height * 0.5),
            radius: size.shortestSide * 0.4,
            color: primary.withValues(alpha: 0.05),
            blurSigma: 25,
          ),
        ],
      ContentCardType.small => [
          _ResolvedCircle(
            center: Offset(size.width * 0.85, size.height * 0.3),
            radius: size.shortestSide * 0.3,
            color: primary.withValues(alpha: 0.04),
            blurSigma: 18,
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
  final double blurSigma;

  const _ResolvedCircle({
    required this.center,
    required this.radius,
    required this.color,
    required this.blurSigma,
  });
}
