import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/motion/app_motion.dart';

/// Синхронное «дыхание» скелетона: плавно гоняет прозрачность поддерева.
///
/// Один контроллер на всю группу заглушек — блоки пульсируют в такт.
/// Уважает reduced-motion ([AppMotion.reduced]): показывает статичный [child].
class SkeletonPulse extends StatefulWidget {
  const SkeletonPulse({
    required this.child,
    this.period = const Duration(milliseconds: 1100),
    this.minOpacity = 0.45,
    super.key,
  });

  final Widget child;

  /// Длительность полного цикла «затухание → возврат».
  final Duration period;

  /// Нижняя граница прозрачности в цикле.
  final double minOpacity;

  @override
  State<SkeletonPulse> createState() => _SkeletonPulseState();
}

class _SkeletonPulseState extends State<SkeletonPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.period,
  );

  late final Animation<double> _opacity = Tween<double>(
    begin: 1,
    end: widget.minOpacity,
  ).animate(
    CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
  );

  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started || AppMotion.reduced(context)) return;
    _started = true;
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (AppMotion.reduced(context)) return widget.child;

    return FadeTransition(opacity: _opacity, child: widget.child);
  }
}
