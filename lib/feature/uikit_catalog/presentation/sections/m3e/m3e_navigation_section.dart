import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// Навигация material_3_expressive: вкладки, панели навигации, тулбары и
/// верхний app bar.
class M3ENavigationSection extends StatelessWidget {
  const M3ENavigationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CatalogItem(
          title: 'M3ETabs',
          description: 'Primary: иконка + подпись, бейджи',
          child: _PrimaryTabsDemo(),
        ),
        CatalogItem(
          title: 'M3ETabs',
          description: 'Secondary: только подписи',
          child: _SecondaryTabsDemo(),
        ),
        CatalogItem(
          title: 'M3ENavigationBar',
          description: 'Нижняя навигация с бейджами, safeArea выключен',
          child: _NavigationBarDemo(),
        ),
        CatalogItem(
          title: 'M3ENavigationRail',
          description: 'Свёрнутая рейка с FAB; меню раскрывает её',
          child: _NavigationRailDemo(),
        ),
        CatalogItem(
          title: 'M3EToolbar',
          description: 'Floating с FAB: FAB сворачивает и раскрывает тулбар',
          child: _FloatingToolbarDemo(),
        ),
        CatalogItem(
          title: 'M3EToolbar.docked',
          description: 'Активная кнопка; пятое действие уходит в overflow-меню',
          child: _DockedToolbarDemo(),
        ),
        CatalogItem(
          title: 'M3EAppBar.top',
          description: 'Варианты small и medium, safeArea выключен',
          child: _AppBarDemo(),
        ),
      ],
    );
  }
}

class _PrimaryTabsDemo extends StatefulWidget {
  const _PrimaryTabsDemo();

  @override
  State<_PrimaryTabsDemo> createState() => _PrimaryTabsDemoState();
}

class _PrimaryTabsDemoState extends State<_PrimaryTabsDemo> {
  static const _tabs = [
    M3ETab(label: 'Колоды', icon: Icon(M3EIcons.style)),
    M3ETab(label: 'Учить', icon: Icon(M3EIcons.school), badgeCount: 12),
    M3ETab(label: 'Профиль', icon: Icon(M3EIcons.person), badgeDot: true),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        M3ETabs(
          tabs: _tabs,
          selectedIndex: _index,
          onTabSelected: (index) => setState(() => _index = index),
        ),
        const Height(12),
        Text('Выбрана вкладка: ${_tabs[_index].label}'),
      ],
    );
  }
}

class _SecondaryTabsDemo extends StatefulWidget {
  const _SecondaryTabsDemo();

  @override
  State<_SecondaryTabsDemo> createState() => _SecondaryTabsDemoState();
}

class _SecondaryTabsDemoState extends State<_SecondaryTabsDemo> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return M3ETabs(
      variant: M3ETabsVariant.secondary,
      selectedIndex: _index,
      onTabSelected: (index) => setState(() => _index = index),
      tabs: const [
        M3ETab(label: 'День'),
        M3ETab(label: 'Неделя'),
        M3ETab(label: 'Месяц'),
      ],
    );
  }
}

class _NavigationBarDemo extends StatefulWidget {
  const _NavigationBarDemo();

  @override
  State<_NavigationBarDemo> createState() => _NavigationBarDemoState();
}

class _NavigationBarDemoState extends State<_NavigationBarDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return M3ENavigationBar(
      safeArea: false,
      selectedIndex: _index,
      onDestinationSelected: (index) => setState(() => _index = index),
      destinations: const [
        M3ENavigationBarDestination(
          icon: Icon(M3EIcons.home_outlined),
          selectedIcon: Icon(M3EIcons.home),
          label: 'Главная',
        ),
        M3ENavigationBarDestination(
          icon: Icon(M3EIcons.style_outlined),
          selectedIcon: Icon(M3EIcons.style),
          label: 'Колоды',
          badgeCount: 3,
        ),
        M3ENavigationBarDestination(
          icon: Icon(M3EIcons.bar_chart_outlined),
          selectedIcon: Icon(M3EIcons.bar_chart),
          label: 'Статистика',
          badgeDot: true,
        ),
        M3ENavigationBarDestination(
          icon: Icon(M3EIcons.person_outline),
          selectedIcon: Icon(M3EIcons.person),
          label: 'Профиль',
        ),
      ],
    );
  }
}

class _NavigationRailDemo extends StatefulWidget {
  const _NavigationRailDemo();

  @override
  State<_NavigationRailDemo> createState() => _NavigationRailDemoState();
}

class _NavigationRailDemoState extends State<_NavigationRailDemo> {
  static const _destinations = [
    M3ENavigationRailDestination(
      icon: Icon(M3EIcons.inbox_outlined),
      selectedIcon: Icon(M3EIcons.inbox),
      label: 'Почта',
      badgeCount: 4,
    ),
    M3ENavigationRailDestination(
      icon: Icon(M3EIcons.star_border),
      selectedIcon: Icon(M3EIcons.star),
      label: 'Важное',
    ),
    M3ENavigationRailDestination(
      icon: Icon(M3EIcons.archive_outlined),
      selectedIcon: Icon(M3EIcons.archive),
      label: 'Архив',
    ),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = M3ETheme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: colorScheme.surfaceContainer,
        child: SizedBox(
          height: 360,
          child: Row(
            children: [
              M3ENavigationRail(
                type: M3ENavigationRailType.collapsed,
                sections: const [
                  M3ENavigationRailSection(destinations: _destinations),
                ],
                selectedIndex: _index,
                onDestinationSelected: (index) {
                  setState(() => _index = index);
                },
                fab: M3ENavigationRailFabSlot(
                  icon: const Icon(M3EIcons.edit),
                  label: 'Создать',
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    _destinations[_index].label,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingToolbarDemo extends StatefulWidget {
  const _FloatingToolbarDemo();

  @override
  State<_FloatingToolbarDemo> createState() => _FloatingToolbarDemoState();
}

class _FloatingToolbarDemoState extends State<_FloatingToolbarDemo> {
  bool _expanded = true;

  @override
  Widget build(BuildContext context) {
    return _ToolbarStage(
      height: 112,
      child: M3EToolbar(
        expanded: _expanded,
        onExpandedChanged: (value) => setState(() => _expanded = value),
        fabExpandIcon: const Icon(M3EIcons.add),
        fabCollapseIcon: const Icon(M3EIcons.close),
        actions: [
          M3EToolbarAction(icon: M3EIcons.edit, onPressed: () {}),
          M3EToolbarAction(icon: M3EIcons.share, onPressed: () {}),
          M3EToolbarAction(icon: M3EIcons.delete_outline, onPressed: () {}),
        ],
      ),
    );
  }
}

class _DockedToolbarDemo extends StatefulWidget {
  const _DockedToolbarDemo();

  @override
  State<_DockedToolbarDemo> createState() => _DockedToolbarDemoState();
}

class _DockedToolbarDemoState extends State<_DockedToolbarDemo> {
  static const _actions = [
    (M3EIcons.format_bold, 'Жирный'),
    (M3EIcons.format_italic, 'Курсив'),
    (M3EIcons.format_underlined, 'Подчёркнутый'),
    (M3EIcons.format_list_bulleted, 'Список'),
    (M3EIcons.link, 'Ссылка'),
  ];

  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return _ToolbarStage(
      height: 96,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: M3EToolbar.docked(
          safeArea: false,
          activeIndex: _activeIndex,
          onActiveIndexChanged: (index) {
            setState(() => _activeIndex = index);
          },
          actions: [
            for (final (icon, tooltip) in _actions)
              M3EToolbarAction(icon: icon, tooltip: tooltip, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

/// Подложка, изображающая экран, на котором лежит тулбар.
class _ToolbarStage extends StatelessWidget {
  final double height;
  final Widget child;

  const _ToolbarStage({required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = M3ETheme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ColoredBox(
        color: colorScheme.surfaceContainerHighest,
        child: SizedBox(height: height, width: double.infinity, child: child),
      ),
    );
  }
}

class _AppBarDemo extends StatelessWidget {
  const _AppBarDemo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _InlineAppBar(variant: M3EAppBarVariant.small),
        Height(12),
        _InlineAppBar(variant: M3EAppBarVariant.medium),
      ],
    );
  }
}

class _InlineAppBar extends StatelessWidget {
  final M3EAppBarVariant variant;

  const _InlineAppBar({required this.variant});

  @override
  Widget build(BuildContext context) {
    final appBar = M3EAppBar.top(
      variant: variant,
      safeArea: false,
      titleText: 'Колоды',
      subtitleText: variant.name,
      leading: M3EIconButton(
        variant: M3EIconButtonVariant.standard,
        icon: const Icon(M3EIcons.arrow_back),
        onPressed: () {},
      ),
      actions: [
        M3EIconButton(
          variant: M3EIconButtonVariant.standard,
          icon: const Icon(M3EIcons.search),
          onPressed: () {},
        ),
        M3EIconButton(
          variant: M3EIconButtonVariant.standard,
          icon: const Icon(M3EIcons.more_vert),
          onPressed: () {},
        ),
      ],
    );

    // Собственный observer, чтобы бар не реагировал на скролл каталога.
    return ScrollNotificationObserver(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(height: appBar.preferredSize.height, child: appBar),
      ),
    );
  }
}
