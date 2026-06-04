import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// Entrance-анимация появления контента: плавный fade + лёгкий сдвиг снизу.
///
/// Применяется там, где для появления карточек/блоков явно не указана своя
/// реализация. Для каскада списков задавайте [delay] кратно индексу элемента:
/// `FadeIn(delay: Duration(milliseconds: i * 60), child: ...)`.
///
/// Уважает системную настройку «убрать анимацию» ([AppMotion.reduced]) —
/// в этом случае контент показывается в финальном состоянии без движения.
class FadeIn extends StatefulWidget {
  const FadeIn({
    required this.child,
    this.delay = Duration.zero,
    this.duration = AppMotion.medium,
    this.curve = AppMotion.emphasized,
    this.verticalOffset = 14,
    super.key,
  });

  final Widget child;

  /// Задержка перед запуском анимации (для каскадного появления списков).
  final Duration delay;

  /// Длительность самой анимации появления.
  final Duration duration;

  final Curve curve;

  /// Начальный сдвиг по вертикали в логических пикселях (контент «выезжает»
  /// снизу вверх). 0 — только fade без сдвига.
  final double verticalOffset;

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  Timer? _delayTimer;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;

    if (AppMotion.reduced(context)) {
      _controller.value = 1;
      return;
    }

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      _delayTimer = Timer(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final t = _animation.value;
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * widget.verticalOffset),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
