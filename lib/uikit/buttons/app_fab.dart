import 'package:flutter/material.dart';

/// Крупный expressive FAB (64dp, r28, primaryContainer/onPrimaryContainer).
///
/// Параметры размера/формы/цвета берутся из `floatingActionButtonTheme`.
/// [label] используется как tooltip (иконочный FAB по дизайну M3).
class AppFloatingActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  const AppFloatingActionButton({
    required this.label,
    required this.onPressed,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: label,
      child: Icon(icon ?? Icons.add, size: 28),
    );
  }
}
