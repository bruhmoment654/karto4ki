import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// Обёртка над переходом экранов, которая уважает системное «убрать
/// анимацию» ([AppMotion.reduced]): экран сменяется без анимации, и
/// уходящий экран тоже не анимируется.
///
/// Переходы SDK (в т. ч. predictive back) на `disableAnimations` не смотрят.
/// Системный back при этом работает — пропадает только анимация.
class ReducedMotionPageTransitionsBuilder extends PageTransitionsBuilder {
  final PageTransitionsBuilder base;

  const ReducedMotionPageTransitionsBuilder(this.base);

  @override
  Duration get transitionDuration => base.transitionDuration;

  @override
  Duration get reverseTransitionDuration => base.reverseTransitionDuration;

  @override
  DelegatedTransitionBuilder? get delegatedTransition {
    final baseTransition = base.delegatedTransition;
    if (baseTransition == null) return null;

    return (context, animation, secondaryAnimation, allowSnapshotting, child) =>
        AppMotion.reduced(context)
            ? child
            : baseTransition(
                context,
                animation,
                secondaryAnimation,
                allowSnapshotting,
                child,
              );
  }

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (AppMotion.reduced(context)) return child;

    return base.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
