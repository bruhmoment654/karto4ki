import 'package:flutter/material.dart';
import 'package:karto4ki/feature/home/presentation/home_view.dart';

/// Экран-контейнер для вложенной навигации.
///
/// Отвечает за отображение вложенного роутера и, при необходимости,
/// общих элементов навигации (например, bottom navigation bar).
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

/// Интерфейс ViewModel для Home экрана.
///
/// Определяет контракт взаимодействия между [HomeScreen] и [HomeView].
abstract interface class IHomeViewModel {}
