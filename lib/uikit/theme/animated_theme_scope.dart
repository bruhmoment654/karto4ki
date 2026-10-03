import 'package:flutter/material.dart';

/// Плавно переводит поддерево на новую тему приложения.
///
/// `MaterialApp` применяет тему за один кадр (`themeAnimationStyle:
/// AnimationStyle.noAnimation`): его покадровая анимация пересобирала бы всё
/// приложение, включая невидимые экраны, и на 120 Гц не укладывалась в кадр.
/// Анимацию оставляем только там, где смену темы видно, — оборачиваем этим
/// виджетом экран, на котором её меняют, и то, что видно рядом с ним.
///
/// Сам виджет зависит от темы, а [child] — нет: на смене темы пересобирается
/// только анимация, а не экран, который её создал.
class AnimatedThemeScope extends StatelessWidget {
  final Widget child;

  const AnimatedThemeScope({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(data: Theme.of(context), child: child);
  }
}
