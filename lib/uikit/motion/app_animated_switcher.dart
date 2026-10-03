import 'package:flutter/widgets.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';

/// {@template app_animated_switcher.class}
/// Плавная смена содержимого: прежнее уходит, новое появляется на его месте.
///
/// [AnimatedSwitcher] с длительностью и кривыми приложения; при отключённых
/// в системе анимациях ([AppMotion.reduced]) смена мгновенная. Раскладку
/// содержимого свитчер не меняет: оно получает те же ограничения, что и без
/// него. Размер не анимирует — для этого снаружи `AnimatedSize`.
///
/// Сменой считается [child] другого типа или с другим ключом. Ключ нужен,
/// только когда тип остаётся прежним, а меняются данные: `Text` с новой
/// строкой — `Text(label, key: ValueKey(label))`. Виджеты разных типов
/// (скелетон, ошибка, данные) сменяются без ключа.
/// {@endtemplate}
class AppAnimatedSwitcher extends StatelessWidget {
  static const Duration duration = AppMotion.fast;
  static const Curve switchInCurve = Curves.easeOutCubic;
  static const Curve switchOutCurve = Curves.easeInCubic;

  final Widget child;

  /// Выравнивание прежнего и нового содержимого разного размера на время
  /// смены.
  final AlignmentGeometry alignment;

  final AppSwitcherTransition transition;

  /// {@macro app_animated_switcher.class}
  const AppAnimatedSwitcher({
    required this.child,
    this.alignment = Alignment.center,
    this.transition = AppSwitcherTransition.fade,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentKey = child.key;

    return AnimatedSwitcher(
      duration: AppMotion.reduced(context) ? Duration.zero : duration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder: switch (transition) {
        AppSwitcherTransition.fade => AnimatedSwitcher.defaultTransitionBuilder,
        AppSwitcherTransition.slideUp => (transitionChild, animation) =>
            _SlideUpTransition(
              animation: animation,
              isIncoming: transitionChild.key == currentKey,
              child: transitionChild,
            ),
      },
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: alignment,
        fit: StackFit.passthrough,
        children: [...previousChildren, ?currentChild],
      ),
      child: child,
    );
  }
}

/// Как [AppAnimatedSwitcher] сменяет содержимое.
enum AppSwitcherTransition {
  /// Прежнее гаснет, новое проявляется на его месте.
  fade,

  /// Новое поднимается снизу с проявлением, прежнее уходит вверх и гаснет.
  /// Для коротких подписей, где почти одинаковые строки («1 из 3» →
  /// «2 из 3») накладываются друг на друга и проявление незаметно.
  slideUp,
}

/// Новое содержимое поднимается снизу, прежнее — уходит вверх: у уходящего
/// анимация идёт назад, поэтому смещение у них с разных сторон.
class _SlideUpTransition extends StatelessWidget {
  /// Смещение на долю высоты: заметно, но строка не вылетает из своей строки.
  static const double _shift = 0.5;

  final Animation<double> animation;
  final bool isIncoming;
  final Widget child;

  const _SlideUpTransition({
    required this.animation,
    required this.isIncoming,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final position = Tween<Offset>(
      begin: Offset(0, isIncoming ? _shift : -_shift),
      end: Offset.zero,
    ).animate(animation);

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(position: position, child: child),
    );
  }
}
