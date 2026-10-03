import 'package:flutter/material.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';
import 'package:quizzerg/uikit/theme/app_theme_scope.dart';

/// Выбор стиля палитры: карточки с мини-превью в ряд.
///
/// Превью строится из тёмной палитры самого стиля с текущим акцентом, так
/// что новый стиль получает превью без доработок.
class ColorStylePicker extends StatelessWidget {
  final AppColorStyle value;

  /// Seed-цвет из слайдера акцента.
  final Color accent;
  final ValueChanged<AppColorStyle> onChanged;

  const ColorStylePicker({
    required this.value,
    required this.accent,
    required this.onChanged,
    super.key,
  });

  static const _spacing = 10.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final style in AppColorStyle.values) ...[
          if (style != AppColorStyle.values.first) const Width(_spacing),
          Expanded(
            child: _ColorStyleOption(
              style: style,
              accent: accent,
              isSelected: style == value,
              onTap: () => onChanged(style),
            ),
          ),
        ],
      ],
    );
  }
}

class _ColorStyleOption extends StatelessWidget {
  static const _radius = BorderRadius.all(Radius.circular(16));

  final AppColorStyle style;
  final Color accent;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorStyleOption({
    required this.style,
    required this.accent,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final labelColor = isSelected ? cs.onSecondaryContainer : cs.onSurface;

    return Semantics(
      selected: isSelected,
      button: true,
      child: Material(
        color: isSelected ? cs.secondaryContainer : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: _radius,
          side: isSelected
              ? BorderSide(color: cs.primary, width: 2)
              : BorderSide(color: cs.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ColorStylePreview(
                  scheme: AppThemeScope.paletteOf(
                    style,
                  ).colorScheme(brightness: Brightness.dark, accent: accent),
                ),
                const Height(8),
                // На узком экране подпись с галочкой не влезает в треть
                // карточки — ужимаем, а не переносим посреди слова.
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) ...[
                        Icon(Icons.check, size: 16, color: labelColor),
                        const Width(4),
                      ],
                      Text(
                        _labelOf(context, style),
                        maxLines: 1,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: labelColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Height(2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _labelOf(BuildContext context, AppColorStyle style) {
    final l10n = context.l10n;

    return switch (style) {
      AppColorStyle.colorful => l10n.settingsStyleColorful,
      AppColorStyle.monochrome => l10n.settingsStyleMonochrome,
      AppColorStyle.amoled => l10n.settingsStyleAmoled,
    };
  }
}

/// Мини-экран стиля: фон, три полосы из пула карточек групп и точка акцента.
class _ColorStylePreview extends StatelessWidget {
  static const _height = 72.0;
  static const _dotSize = 16.0;

  final ColorScheme scheme;

  const _ColorStylePreview({required this.scheme});

  @override
  Widget build(BuildContext context) {
    final pool = scheme.groupCardPool;

    return Container(
      height: _height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        // На чёрном фоне AMOLED край превью иначе теряется.
        border: Border.all(color: scheme.surfaceContainerHigh),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < pool.length; i++) ...[
                if (i > 0) const Height(5),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: pool[i].$1,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: _dotSize,
              height: _dotSize,
              decoration: BoxDecoration(
                color: scheme.primary,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
