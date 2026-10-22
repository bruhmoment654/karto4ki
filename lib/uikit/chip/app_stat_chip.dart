import 'package:flutter/material.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Плашка-счётчик статистики на карточке: иконка и короткий текст
/// («16 слабых», «Ещё не начат»).
///
/// Фон — полупрозрачный [color]; акцентная плашка плотнее и с текстом
/// в [color], обычная — с текстом в [textColor].
class AppStatChip extends StatelessWidget {
  static const _height = 28.0;
  static const _iconSize = 16.0;
  static const _backgroundAlpha = 0.13;
  static const _accentBackgroundAlpha = 0.22;

  final IconData icon;
  final String label;

  /// Цвет иконки и фона.
  final Color color;

  /// Цвет текста обычной плашки.
  final Color textColor;
  final bool isAccent;

  const AppStatChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
    this.isAccent = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: const EdgeInsets.only(left: 8, right: 11),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: isAccent ? _accentBackgroundAlpha : _backgroundAlpha,
        ),
        borderRadius: BorderRadius.circular(AppDimens.radius8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _iconSize, color: color),
          const Width(5),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isAccent ? color : textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
