import 'package:flutter/widgets.dart';
import 'package:material_3_expressive/material_3_expressive.dart'
    show M3EShapeContainer, M3EShapeKind;
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// Формы плашек из набора Material Shapes. Разные формы различают метрики.
enum ShapePlateKind {
  cookie4Sided(M3EShapeKind.cookie4Sided),
  pentagon(M3EShapeKind.pentagon),
  cookie7Sided(M3EShapeKind.cookie7Sided);

  const ShapePlateKind(this._m3eKind);

  final M3EShapeKind _m3eKind;
}

/// Квадратная плашка-фигура M3 Expressive с содержимым по центру
/// (обычно иконкой метрики).
///
/// [isRotating] — фигура-фон медленно вращается, содержимое остаётся
/// неподвижным. reduced-motion ([AppMotion.reduced]): не вращается.
class ShapePlate extends StatelessWidget {
  const ShapePlate({
    required this.kind,
    required this.size,
    required this.color,
    required this.child,
    this.isRotating = false,
    super.key,
  });

  final ShapePlateKind kind;

  /// Сторона плашки. Фигура растягивается по bounds, поэтому только квадрат.
  final double size;
  final Color color;
  final Widget child;
  final bool isRotating;

  @override
  Widget build(BuildContext context) {
    final shape = M3EShapeContainer(
      kind: kind._m3eKind,
      width: size,
      height: size,
      color: color,
    );

    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isRotating) _SlowRotation(child: shape) else shape,
          child,
        ],
      ),
    );
  }
}

/// Бесконечное медленное вращение — фоновое «дыхание», а не индикатор.
class _SlowRotation extends StatefulWidget {
  const _SlowRotation({required this.child});

  final Widget child;

  @override
  State<_SlowRotation> createState() => _SlowRotationState();
}

class _SlowRotationState extends State<_SlowRotation>
    with SingleTickerProviderStateMixin {
  /// Один оборот. Медленно, чтобы движение читалось фоном, а не отвлекало.
  static const _period = Duration(seconds: 24);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _period,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (AppMotion.reduced(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: RotationTransition(turns: _controller, child: widget.child),
    );
  }
}
