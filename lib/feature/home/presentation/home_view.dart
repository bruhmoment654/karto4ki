import 'dart:ui' show ImageFilter;

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
    final colorScheme = Theme.of(context).colorScheme;

    return AutoTabsScaffold(
      routes: const [
        MainTabRoute(),
        ProfileRoute(),
      ],
      extendBody: true,
      bottomNavigationBuilder: (context, tabsRouter) {
        return ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colorScheme.surface.withValues(alpha: 0.5),
                border: Border(
                  top: BorderSide(
                    color:
                        colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home_outlined),
                    label: context.l10n.navigationMain,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person_outline),
                    label: context.l10n.navigationProfile,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
