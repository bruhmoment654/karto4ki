import 'package:flutter/material.dart';
import 'package:karto4ki/feature/main/presentation/main_view.dart';

/// Main application screen.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> implements IMainViewModel {
  @override
  Widget build(BuildContext context) {
    return MainView(viewModel: this);
  }
}

/// ViewModel interface for main screen.
///
/// Defines interaction contract between [MainScreen] and [MainView].
abstract interface class IMainViewModel {}
