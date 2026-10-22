import 'package:flutter/material.dart';
import 'package:material_3_expressive/material_3_expressive.dart'
    show M3EButton, M3EButtonStyle, M3ELoadingIndicator, M3ESpring;
import 'package:quizzerg/uikit/m3e/m3e_scope.dart';
import 'package:quizzerg/uikit/motion/app_motion.dart';
import 'package:quizzerg/uikit/spacing/height.dart';

/// Пустое состояние экрана: медленно морфящаяся фигура M3E, заголовок,
/// пояснение и действия — основное (filled) и необязательное
/// дополнительное (text).
class AppEmptyState extends StatelessWidget {
  static const _messageMaxWidth = 300.0;

  const AppEmptyState({
    required this.title,
    required this.message,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    this.primaryIcon = Icons.add_rounded,
    this.secondaryLabel,
    this.secondaryIcon,
    this.onSecondaryPressed,
    super.key,
  });

  final String title;
  final String message;
  final String primaryLabel;
  final IconData primaryIcon;
  final VoidCallback onPrimaryPressed;

  /// Дополнительное действие показывается, только если заданы и подпись,
  /// и обработчик.
  final String? secondaryLabel;
  final IconData? secondaryIcon;
  final VoidCallback? onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryLabel = this.secondaryLabel;
    final secondaryIcon = this.secondaryIcon;
    final onSecondaryPressed = this.onSecondaryPressed;

    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(36, 0, 36, 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AmbientShape(color: theme.colorScheme.primaryContainer),
            const Height(28),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Height(8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _messageMaxWidth),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const Height(28),
            M3EScope(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  M3EButton(
                    onPressed: onPrimaryPressed,
                    icon: Icon(primaryIcon),
                    label: Text(primaryLabel),
                  ),
                  if (secondaryLabel != null && onSecondaryPressed != null) ...[
                    const Height(8),
                    M3EButton(
                      style: M3EButtonStyle.text,
                      onPressed: onSecondaryPressed,
                      icon: secondaryIcon == null ? null : Icon(secondaryIcon),
                      label: Text(secondaryLabel),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Декоративная фигура пустого состояния — неопределённый индикатор M3E,
/// замедленный до «дыхания»: оборот за 12 с, морф раз в 4 с на мягкой
/// пружине. reduced-motion ([AppMotion.reduced]): фигура стоит.
class _AmbientShape extends StatelessWidget {
  static const _size = 112.0;
  static const _rotation = Duration(seconds: 12);
  static const _morphInterval = Duration(seconds: 4);
  static const _morphRotationDegrees = 20.0;
  static const _morphSpring = M3ESpring(stiffness: 30, damping: 1);

  final Color color;

  const _AmbientShape({required this.color});

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: M3EScope(
        child: M3ELoadingIndicator(
          // Фигура заполняет весь бокс, а не 38/48 от него, как у `size`.
          containerWidth: _size,
          containerHeight: _size,
          indicatorSize: _size,
          color: color,
          globalRotationDuration: _rotation,
          morphInterval: _morphInterval,
          morphRotationDegrees: _morphRotationDegrees,
          morphSpring: _morphSpring,
          pulseSpring: _morphSpring,
          rotationTurns: AppMotion.reduced(context) ? 0 : null,
        ),
      ),
    );
  }
}
