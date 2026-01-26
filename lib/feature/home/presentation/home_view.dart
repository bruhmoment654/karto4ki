import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:karto4ki/feature/home/presentation/home_screen.dart';

/// UI-слой Home экрана.
///
/// Содержит [AutoRouter] для отображения вложенных экранов навигации.
class HomeView extends StatelessWidget {
  final IHomeViewModel viewModel;

  const HomeView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
