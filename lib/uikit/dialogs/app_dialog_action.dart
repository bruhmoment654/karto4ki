import 'package:flutter/material.dart';

/// Переиспользуемая кнопка действия для диалогов.
///
/// Оборачивает [TextButton] и закрывает диалог с переданным результатом.
class AppDialogAction<T> extends StatelessWidget {
  final String label;
  final T? result;

  const AppDialogAction({
    required this.label,
    this.result,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(result),
      child: Text(label),
    );
  }
}
