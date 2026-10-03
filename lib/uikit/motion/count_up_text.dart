import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// Число, которое «накручивается» от 0 до [value] при появлении (ease-out).
///
/// Для процентов/счётчиков передавайте [suffix] (например `'%'`). При смене
/// [value] анимация проигрывается заново от текущего показанного значения.
/// [delay] — пауза перед стартом, пока она идёт, показывается 0.
///
/// reduced-motion ([AppMotion.reduced]): сразу показывает финальное значение.
class CountUpText extends StatefulWidget {
  const CountUpText({
    required this.value,
    this.suffix = '',
    this.style,
    this.duration = const Duration(milliseconds: 850),
    this.delay = Duration.zero,
    super.key,
  });

  final int value;
  final String suffix;
  final TextStyle? style;
  final Duration duration;

  /// Задержка перед стартом (для каскада из нескольких чисел).
  final Duration delay;

  @override
  State<CountUpText> createState() => _CountUpTextState();
}

class _CountUpTextState extends State<CountUpText> {
  Timer? _delayTimer;
  late bool _isStarted = widget.delay == Duration.zero;

  @override
  void initState() {
    super.initState();
    if (!_isStarted) {
      _delayTimer = Timer(widget.delay, () => setState(() => _isStarted = true));
    }
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isReduced = AppMotion.reduced(context);
    final target = _isStarted || isReduced ? widget.value.toDouble() : 0.0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: target),
      duration: isReduced ? Duration.zero : widget.duration,
      curve: Curves.easeOutCubic,
      builder: (_, current, __) =>
          Text('${current.round()}${widget.suffix}', style: widget.style),
    );
  }
}
