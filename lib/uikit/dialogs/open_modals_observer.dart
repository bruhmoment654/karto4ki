import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Следит за модальными маршрутами (диалоги, шторки, меню) во всех
/// навигаторах приложения.
///
/// Нужен predictive back: жест рассылается всем навигаторам, и экран во
/// вложенном навигаторе считает себя текущим, даже если поверх него в
/// корневом открыт диалог. Пока [isAnyOpen], свайп у страниц выключен
/// ([ModalAwarePageTransitionsBuilder]), и системный back закрывает модалку
/// через роутер.
///
/// Экземпляр на навигатор (Flutter не даёт делить наблюдателя), открытые
/// маршруты — общие.
class OpenModalsObserver extends NavigatorObserver {
  static final _openRoutes = <Route<dynamic>>{};
  static final ValueNotifier<bool> _isAnyOpen = ValueNotifier(false);

  /// Открыта ли хоть одна модалка.
  static ValueListenable<bool> get isAnyOpen => _isAnyOpen;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _add(route);

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _remove(route);

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _remove(route);

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute != null) _remove(oldRoute);
    if (newRoute != null) _add(newRoute);
  }

  static void _add(Route<dynamic> route) {
    if (route is! PopupRoute) return;
    _openRoutes.add(route);
    _isAnyOpen.value = true;
  }

  static void _remove(Route<dynamic> route) {
    _openRoutes.remove(route);
    _isAnyOpen.value = _openRoutes.isNotEmpty;
  }
}

/// Отключает свайп «назад» у страницы, пока открыта модалка
/// ([OpenModalsObserver]); сам переход берёт у [base].
class ModalAwarePageTransitionsBuilder extends PageTransitionsBuilder {
  final PageTransitionsBuilder base;

  const ModalAwarePageTransitionsBuilder(this.base);

  @override
  Duration get transitionDuration => base.transitionDuration;

  @override
  Duration get reverseTransitionDuration => base.reverseTransitionDuration;

  @override
  DelegatedTransitionBuilder? get delegatedTransition =>
      base.delegatedTransition;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return base.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      ValueListenableBuilder<bool>(
        valueListenable: OpenModalsObserver.isAnyOpen,
        builder: (_, isAnyOpen, _) =>
            PopScope(canPop: !isAnyOpen, child: child),
      ),
    );
  }
}
