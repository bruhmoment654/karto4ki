import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/feature/home/presentation/home_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';

/// UI layer for Home screen.
///
/// Contains [AutoRouter] for displaying nested navigation screens.
class HomeView extends StatelessWidget {
  final IHomeViewModel viewModel;

  const HomeView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        MainTabRoute(),
        QuestionStatsRoute(),
        ProfileRoute(),
      ],
      extendBody: true,
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: (index) {
            tabsRouter.setActiveIndex(index);
            // Любое нажатие на таб возвращает его вложенный стек к корню.
            tabsRouter.stackRouterOfIndex(index)?.popUntilRoot();
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: context.l10n.navigationMain,
            ),
            NavigationDestination(
              icon: const Icon(Icons.bar_chart_outlined),
              selectedIcon: const Icon(Icons.bar_chart),
              label: context.l10n.questionStatsTitle,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
              label: context.l10n.navigationProfile,
            ),
          ],
        );
      },
    );
  }
}
