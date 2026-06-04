import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// Число, которое «накручивается» от 0 до [value] при появлении (ease-out).
///
/// Для процентов/счётчиков передавайте [suffix] (например `'%'`). При смене
/// [value] анимация проигрывается заново от текущего показанного значения.
///
/// reduced-motion ([AppMotion.reduced]): сразу показывает финальное значение.
class CountUpText extends StatelessWidget {
  const CountUpText({
    required this.value,
    this.suffix = '',
    this.style,
    this.duration = const Duration(milliseconds: 850),
    super.key,
  });

  final int value;
  final String suffix;
  final TextStyle? style;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.toDouble()),
      duration: AppMotion.reduced(context) ? Duration.zero : duration,
      curve: Curves.easeOutCubic,
      builder: (_, current, __) =>
          Text('${current.round()}$suffix', style: style),
    );
  }
}
