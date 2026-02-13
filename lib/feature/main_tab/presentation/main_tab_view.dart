import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:quizzerg/feature/main_tab/presentation/main_tab_screen.dart';

/// UI layer for main tab.
///
/// Hosts nested navigation stack for primary flows.
class MainTabView extends StatelessWidget {
  final IMainTabViewModel viewModel;

  const MainTabView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
