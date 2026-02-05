import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:karto4ki/app/navigation/app_router.dart';
import 'package:karto4ki/feature/home/presentation/home_screen.dart';
import 'package:karto4ki/uikit/theme/app_theme.dart';

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
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.scaffoldBackground,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Профиль',
            ),
          ],
        );
      },
    );
  }
}
