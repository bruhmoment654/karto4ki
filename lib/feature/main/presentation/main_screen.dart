import 'package:flutter/material.dart';
import 'package:karto4ki/feature/main/presentation/main_view.dart';

/// Главный экран приложения.
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

/// Интерфейс ViewModel для главного экрана.
///
/// Определяет контракт взаимодействия между [MainScreen] и [MainView].
abstract interface class IMainViewModel {}
