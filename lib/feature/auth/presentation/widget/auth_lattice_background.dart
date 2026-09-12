import 'package:flutter/material.dart';

/// Фон экрана входа: две решётки под ±45°, растворяющиеся радиальной маской.
///
/// Тот же узор, что на иконке и в сплеше. Собственной анимации у виджета
/// нет — все параметры вынесены наружу, чтобы поверх можно было навесить
/// `AnimationController` (например, тянуть [maskRadius] и [opacity] при
/// входе), не трогая вёрстку экрана.
class AuthLatticeBackground extends StatelessWidget {
  /// Шаг узора по горизонтали, в логических пикселях.
  final double period;

  /// Множитель прозрачности всей решётки.
  final double opacity;

  /// Цвет полос. По умолчанию — `primary` текущей темы.
  final Color? color;

  /// Центр радиальной маски в долях размера.
  final Alignment maskCenter;

  /// Радиус маски в долях короткой стороны.
  final double maskRadius;

  const AuthLatticeBackground({
    this.period = 74,
    this.opacity = 1,
    this.color,
    this.maskCenter = const Alignment(0, -0.88),
    this.maskRadius = 1.1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final base = color ?? Theme.of(context).colorScheme.primary;

    return IgnorePointer(
      child: ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (rect) => RadialGradient(
          center: maskCenter,
          radius: maskRadius,
          colors: const [Colors.black, Colors.black, Colors.transparent],
          stops: const [0, 0.3, 0.76],
        ).createShader(rect),
        child: CustomPaint(
          painter: _LatticePainter(
            period: period,
            strongColor: base.withValues(alpha: 0.55 * opacity),
            softColor: base.withValues(alpha: 0.24 * opacity),
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

/// Рисует обе решётки: толстая полоса 2px и тонкая 1.5px внутри периода.
class _LatticePainter extends CustomPainter {
  final double period;
  final Color strongColor;
  final Color softColor;

  const _LatticePainter({
    required this.period,
    required this.strongColor,
    required this.softColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _paintDiagonals(canvas, size, isForward: true);
    _paintDiagonals(canvas, size, isForward: false);
  }

  void _paintDiagonals(Canvas canvas, Size size, {required bool isForward}) {
    final strong = Paint()
      ..color = strongColor
      ..strokeWidth = 2;
    final soft = Paint()
      ..color = softColor
      ..strokeWidth = 1.5;

    // Полосы под 45° — линии с шагом period по нормали к направлению.
    final span = size.width + size.height;
    final length = span * 2;

    for (var offset = -span; offset <= span; offset += period) {
      _line(canvas, size, offset, length, strong, isForward: isForward);
      _line(canvas, size, offset + 5, length, soft, isForward: isForward);
    }
  }

  void _line(
    Canvas canvas,
    Size size,
    double offset,
    double length,
    Paint paint, {
    required bool isForward,
  }) {
    final direction = isForward ? 1 : -1;
    final start = Offset(offset, 0);
    final end = Offset(offset + direction * length, length);

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(_LatticePainter oldDelegate) =>
      oldDelegate.period != period ||
      oldDelegate.strongColor != strongColor ||
      oldDelegate.softColor != softColor;
}
