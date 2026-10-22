import 'package:flutter/material.dart';

import 'package:quizzerg/uikit/dialogs/app_dialog_action.dart';

/// Базовый M3-диалог приложения.
///
/// Фон `surfaceContainerHigh`, радиус 28, actions — `TextButton`
/// (берутся из `dialogTheme`). Диалог всегда во всю ширину экрана за
/// вычетом внешних полей 16.
///
/// Заголовок и содержимое прокручиваются вместе: высокий диалог (или
/// открытая клавиатура) не выталкивает содержимое за край. Пункты-`ListTile`
/// встают по краю содержимого, без своего внутреннего отступа поверх
/// отступа диалога.
class AppDialog extends StatelessWidget {
  /// Иконка над заголовком (M3: заголовок тогда по центру).
  final Widget? icon;
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;

  const AppDialog({
    this.icon,
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
    final content = this.content;

    return AlertDialog(
      scrollable: true,
      icon: icon,
      title: title,
      // Без явной ширины AlertDialog ужимается до ширины содержимого
      // (минимум 280), и у узких диалогов поля по бокам снова шире 16.
      content: content == null
          ? null
          : SizedBox(
              width: double.maxFinite,
              child: ListTileTheme.merge(
                contentPadding: EdgeInsets.zero,
                child: content,
              ),
            ),
      actions: actions,
    );
  }
}
