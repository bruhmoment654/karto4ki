import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:quizzerg/gen/assets.gen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';

/// Провайдер входа.
///
/// Пока один: `/auth/apple` на бэкенде нет, и кнопка Apple была бы заведомо
/// нерабочей. Параметр оставлен, чтобы её добавление свелось к одной ветке
/// и ассету — вёрстка колонки от количества провайдеров не зависит.
enum AuthProvider { google }

/// Кнопка провайдера по бренд-гайдлайну.
///
/// Цвета берутся из гайдлайна дословно, а не из темы: у знака Google
/// фиксированная палитра, и `ColorFilter` к нему применять нельзя.
class AuthProviderButton extends StatelessWidget {
  final AuthProvider provider;
  final VoidCallback? onPressed;

  /// Показывать спиннер вместо знака — идёт вход.
  final bool isLoading;

  const AuthProviderButton({
    required this.provider,
    this.onPressed,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final style = isDark ? _googleDark : _googleLight;

    return SizedBox(
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: style.background,
          foregroundColor: style.foreground,
          disabledBackgroundColor: style.background,
          disabledForegroundColor: style.foreground.withValues(alpha: 0.6),
          side: BorderSide(color: style.border),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Mark(isLoading: isLoading, color: style.foreground),
            const SizedBox(width: 12),
            // Подпись на узком экране и в длинных локалях уменьшается,
            // а не обрезается: бренд-надпись должна читаться целиком.
            Flexible(
              child: AutoSizeText(_label(context), maxLines: 1),
            ),
          ],
        ),
      ),
    );
  }

  String _label(BuildContext context) => switch (provider) {
        AuthProvider.google => context.l10n.authGoogleButton,
      };
}

class _Mark extends StatelessWidget {
  final bool isLoading;
  final Color color;

  const _Mark({required this.isLoading, required this.color});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2.5, color: color),
      );
    }

    return SvgPicture.asset(Assets.icons.googleG.path, width: 20, height: 20);
  }
}

/// Палитра кнопки Google из бренд-гайдлайна: берём контрастный к фону
/// вариант, чтобы пилюля была видна.
const _googleDark = _GoogleStyle(
  background: Color(0xFF131314),
  foreground: Color(0xFFE3E3E3),
  border: Color(0xFF8E918F),
);

const _googleLight = _GoogleStyle(
  background: Color(0xFFFFFFFF),
  foreground: Color(0xFF1F1F1F),
  border: Color(0xFF747775),
);

/// Палитра кнопки Google из бренд-гайдлайна.
class _GoogleStyle {
  final Color background;
  final Color foreground;
  final Color border;

  const _GoogleStyle({
    required this.background,
    required this.foreground,
    required this.border,
  });
}
