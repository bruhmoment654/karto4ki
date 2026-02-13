import 'package:flutter/material.dart';
import 'package:quizzerg/feature/home/presentation/home_view.dart';

/// Container screen for nested navigation.
///
/// Responsible for displaying nested router and, if needed,
/// common navigation elements (e.g., bottom navigation bar).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements IHomeViewModel {
  @override
  Widget build(BuildContext context) {
    return HomeView(viewModel: this);
  }
}

/// ViewModel interface for Home screen.
///
/// Defines interaction contract between [HomeScreen] and [HomeView].
abstract interface class IHomeViewModel {}
