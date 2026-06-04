import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// Каскадное появление элемента списка: fade + лёгкий сдвиг снизу.
///
/// Оборачивайте в неё элемент внутри `itemBuilder`, а сам список (или ближайший
/// общий предок) — в [AnimationLimiter]. [position] — индекс элемента, задаёт
/// шаг каскада.
///
/// Уважает reduced-motion ([AppMotion.reduced]): при отключённых анимациях
/// возвращает [child] без обёртки.
class StaggeredAppear extends StatelessWidget {
  const StaggeredAppear({
    required this.position,
    required this.child,
    this.verticalOffset = 14,
    super.key,
  });

  /// Индекс элемента в списке — определяет задержку появления.
  final int position;

  /// Начальный сдвиг по вертикали в логических пикселях.
  final double verticalOffset;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (AppMotion.reduced(context)) return child;

    return AnimationConfiguration.staggeredList(
      position: position,
      duration: AppMotion.medium,
      delay: const Duration(milliseconds: 60),
      child: SlideAnimation(
        verticalOffset: verticalOffset,
        curve: AppMotion.emphasized,
        child: FadeInAnimation(
          curve: AppMotion.emphasized,
          child: child,
        ),
      ),
    );
  }
}
