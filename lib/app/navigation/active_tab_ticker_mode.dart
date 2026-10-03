import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

/// Глушит тикеры таба, пока он неактивен.
///
/// `AutoTabsScaffold` держит все табы смонтированными в `IndexedStack` и
/// тикеры скрытых табов не выключает: бесконечные анимации (вращение плашек,
/// лоадеры) продолжали бы гонять кадры за кадром. Ставится в корень страницы
/// таба — там `context.routeData` и есть маршрут таба.
class ActiveTabTickerMode extends StatefulWidget {
  final Widget child;

  const ActiveTabTickerMode({required this.child, super.key});

  @override
  State<ActiveTabTickerMode> createState() => _ActiveTabTickerModeState();
}

class _ActiveTabTickerModeState extends State<ActiveTabTickerMode> {
  TabsRouter? _tabsRouter;
  String? _routeName;
  bool _isActive = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeName = context.routeData.name;

    // `stateHash` таб-роутера не включает активный индекс, поэтому
    // подписка на сам роутер, а не через `watchTabsRouter`.
    final tabsRouter = context.tabsRouter;
    if (!identical(tabsRouter, _tabsRouter)) {
      _tabsRouter?.removeListener(_syncIsActive);
      _tabsRouter = tabsRouter..addListener(_syncIsActive);
    }
    _isActive = _resolveIsActive();
  }

  @override
  void dispose() {
    _tabsRouter?.removeListener(_syncIsActive);
    super.dispose();
  }

  bool _resolveIsActive() => _tabsRouter?.current.name == _routeName;

  void _syncIsActive() {
    final isActive = _resolveIsActive();
    if (isActive != _isActive) setState(() => _isActive = isActive);
  }

  @override
  Widget build(BuildContext context) {
    return TickerMode(enabled: _isActive, child: widget.child);
  }
}
