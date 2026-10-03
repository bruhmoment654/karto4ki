import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_3_expressive/material_3_expressive.dart'
    show M3EProgressIndicator;
import 'package:quizzerg/uikit/m3e/m3e_scope.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// Круговой индикатор M3 Expressive (скруглённые концы, зазор active↔track),
/// который при появлении заполняется от 0 до [value]. [child] — по центру.
///
/// Сам виджет пакета значение не анимирует — заполнение ведёт контроллер
/// здесь. Смена [value] после анимации применяется сразу.
///
/// reduced-motion ([AppMotion.reduced]): дуга сразу на финальном значении.
class AnimatedCircularProgress extends StatefulWidget {
  const AnimatedCircularProgress({
    required this.value,
    required this.color,
    required this.trackColor,
    this.size = 132,
    this.strokeWidth = 10,
    this.delay = Duration.zero,
    this.semanticsLabel,
    this.child,
    super.key,
  });

  /// Заполнение 0..1.
  final double value;
  final Color color;
  final Color trackColor;

  /// Диаметр кольца.
  final double size;

  /// Толщина активной дуги и трека.
  final double strokeWidth;

  /// Задержка перед стартом заполнения (для каскада).
  final Duration delay;
  final String? semanticsLabel;
  final Widget? child;

  @override
  State<AnimatedCircularProgress> createState() =>
      _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState extends State<AnimatedCircularProgress>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fill;
  Timer? _delayTimer;
  bool _isStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppMotion.ring);
    _fill = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isStarted) return;
    _isStarted = true;

    if (AppMotion.reduced(context)) {
      _controller.value = 1;
    } else {
      _delayTimer = Timer(widget.delay, _controller.forward);
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
    final target = widget.value.clamp(0.0, 1.0);

    return SizedBox.square(
      dimension: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _fill,
            builder: (_, __) => M3EScope(
              child: M3EProgressIndicator.circular(
                value: _fill.value * target,
                size: widget.size,
                strokeWidth: widget.strokeWidth,
                trackStrokeWidth: widget.strokeWidth,
                color: widget.color,
                trackColor: widget.trackColor,
                semanticsLabel: widget.semanticsLabel,
              ),
            ),
          ),
          if (widget.child case final child?) child,
        ],
      ),
    );
  }
}
