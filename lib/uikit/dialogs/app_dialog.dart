import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog_action.dart';

/// Общий декоратор диалогов приложения.
///
/// Оборачивает контент в [ContentCard] с градиентным фоном и скруглениями.
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
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: ContentCard(
        type: ContentCardType.medium,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null)
              DefaultTextStyle(
                style: textTheme.titleLarge ?? const TextStyle(),
                child: title!,
              ),
            if (title != null && content != null) const SizedBox(height: 16),
            if (content != null)
              DefaultTextStyle(
                style: textTheme.bodyMedium ?? const TextStyle(),
                child: content!,
              ),
            if (actions != null && actions!.isNotEmpty) ...[
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
