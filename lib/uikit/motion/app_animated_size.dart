import 'package:flutter/widgets.dart';
import 'package:quizzerg/uikit/motion/app_animated_switcher.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// [AnimatedSize] с длительностью и кривой приложения — пара к
/// [AppAnimatedSwitcher]: свитчер сменяет содержимое, этот виджет плавно
/// подгоняет под него размер.
///
/// При отключённых в системе анимациях ([AppMotion.reduced]) размер
/// меняется сразу. `AnimatedSize` с нулевой длительностью для этого не
/// годится: контроллер завершается прямо в раскладке и роняет assert
/// «RenderAnimatedSize was mutated in its own performLayout».
class AppAnimatedSize extends StatelessWidget {
  final Widget child;
  final AlignmentGeometry alignment;

  const AppAnimatedSize({
    required this.child,
    this.alignment = Alignment.topCenter,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (AppMotion.reduced(context)) return child;

    return AnimatedSize(
      duration: AppAnimatedSwitcher.duration,
      curve: AppMotion.emphasized,
      alignment: alignment,
      child: child,
    );
  }
}
