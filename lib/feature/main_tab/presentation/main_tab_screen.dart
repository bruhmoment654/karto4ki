import 'package:flutter/material.dart';
import 'package:karto4ki/feature/main_tab/presentation/main_tab_view.dart';

/// Container screen for main tab routes.
class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen>
    implements IMainTabViewModel {
  @override
  Widget build(BuildContext context) {
    return MainTabView(viewModel: this);
  }
}

/// ViewModel interface for main tab.
abstract interface class IMainTabViewModel {}
