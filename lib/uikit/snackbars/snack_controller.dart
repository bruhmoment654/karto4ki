import 'package:flutter/material.dart';

/// Единая точка показа снеков.
///
/// Экраны не собирают [SnackBar] руками: вызов идёт через [show] или
/// [showError], поэтому оформление и длительность правятся в одном месте.
/// Ошибки пока выглядят так же, как обычные снеки — [showError] размечает
/// места вызова, чтобы будущее оформление ошибок не пришлось искать по экранам.
class SnackController {
  const SnackController._();

  /// Длительность по умолчанию: совпадает с материальной для короткого текста.
  static const defaultDuration = Duration(seconds: 4);

  /// Длительность для длинных многострочных сообщений (пути к файлам и т.п.).
  static const longDuration = Duration(seconds: 6);

  /// Показывает информационный снек.
  static void show(
    BuildContext context,
    String message, {
    Duration duration = defaultDuration,
  }) {
    _show(context, message, duration);
  }

  /// Показывает снек об ошибке.
  static void showError(
    BuildContext context,
    String message, {
    Duration duration = defaultDuration,
  }) {
    _show(context, message, duration);
  }

  /// Гасит текущий снек, если он ещё висит.
  static void hide(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static void _show(BuildContext context, String message, Duration duration) {
    // Предыдущий снек гасим: иначе быстрые события выстраиваются в очередь
    // и пользователь читает уже неактуальные сообщения.
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), duration: duration));
  }
}
