import 'package:flutter/material.dart';

/// Общий декоратор диалогов приложения.
///
/// Оборачивает контент в стилизованный [AlertDialog] без скруглений по углам.
class AppDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;

  const AppDialog({
    this.title,
    this.content,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const BeveledRectangleBorder(),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      title: title,
      content: content,
      actions: actions,
    );
  }
}
