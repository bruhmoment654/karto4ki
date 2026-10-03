import 'dart:async';

import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzerg/app/navigation/app_router.dart';
import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/home/presentation/home_screen.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';
import 'package:quizzerg/uikit/theme/animated_theme_scope.dart';

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
      // Смена вкладок — M3 fade through.
      transitionBuilder: (context, child, animation) => FadeThroughTransition(
        animation: AppMotion.reduced(context)
            ? const AlwaysStoppedAnimation(1)
            : animation,
        secondaryAnimation: kAlwaysDismissedAnimation,
        fillColor: Colors.transparent,
        child: child,
      ),
      extendBody: true,
      // Панель видна и на настройках, где меняют тему, — перетекает вместе
      // с экраном (см. AnimatedThemeScope).
      bottomNavigationBuilder: (context, tabsRouter) {
        return AnimatedThemeScope(
          child: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: (index) {
              final previousIndex = tabsRouter.activeIndex;
              tabsRouter.setActiveIndex(index);
              // Любое нажатие на таб возвращает его вложенный стек к корню.
              tabsRouter.stackRouterOfIndex(index)?.popUntilRoot();
              // Покинутый таб тоже сбрасываем: predictive back рассылается всем
              // навигаторам, и скрытый верхний экран неактивного таба закрылся
              // бы вместе с видимым. При возврате стек и так сбрасывается.
              if (previousIndex != index) {
                tabsRouter.stackRouterOfIndex(previousIndex)?.popUntilRoot();
              }
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
                icon: _ProfileTabIcon(
                  syncState: viewModel.syncState,
                  child: const _DebugEntryPoint(
                    child: Icon(Icons.person_outline),
                  ),
                ),
                selectedIcon: _ProfileTabIcon(
                  syncState: viewModel.syncState,
                  child: const _DebugEntryPoint(child: Icon(Icons.person)),
                ),
                label: context.l10n.navigationProfile,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Бейдж на табе профиля, когда сессия истекла: перелогин — единственное
/// действие, которое пользователь должен заметить сам.
class _ProfileTabIcon extends StatelessWidget {
  final StateStreamable<SyncState> syncState;
  final Widget child;

  const _ProfileTabIcon({required this.syncState, required this.child});

  @override
  Widget build(BuildContext context) {
    return StateStreamableBuilder<SyncState>(
      bloc: syncState,
      builder: (context, state) => Badge(
        isLabelVisible: state.status.isExpired,
        child: child,
      ),
    );
  }
}

/// Скрытый вход в дебаг-экран: лонг-тап по иконке таба профиля.
///
/// В релизной сборке — обычная иконка без жеста.
class _DebugEntryPoint extends StatelessWidget {
  final Widget child;

  const _DebugEntryPoint({required this.child});

  @override
  Widget build(BuildContext context) {
    // if (!kDebugMode) return child;

    return GestureDetector(
      // Обычный тап должен по-прежнему доходить до NavigationBar.
      behavior: HitTestBehavior.translucent,
      onLongPress: () {
        unawaited(HapticFeedback.mediumImpact());
        unawaited(context.router.root.push(const DeveloperDebugRoute()));
      },
      child: child,
    );
  }
}
