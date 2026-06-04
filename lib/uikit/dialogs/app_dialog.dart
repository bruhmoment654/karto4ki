import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/dialogs/app_dialog_action.dart';

/// Базовый M3-диалог приложения.
///
/// Фон `surfaceContainerHigh`, радиус 28, actions — `TextButton`
/// (берутся из `dialogTheme`).
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

  /// Показывает диалог подтверждения с кнопками «Отмена» и «Подтвердить».
  ///
  /// Возвращает `true` при подтверждении, `false` при отмене.
  static Future<bool?> confirm({
    required BuildContext context,
    required String title,
    required String message,
    required String cancelLabel,
    required String confirmLabel,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AppDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          AppDialogAction<bool>(label: cancelLabel, result: false),
          AppDialogAction<bool>(label: confirmLabel, result: true),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: actions,
    );
  }
}
