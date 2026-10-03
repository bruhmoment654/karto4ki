import 'package:flutter/material.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Основа дизайн-системы: цвета, радиусы, типографика, отступы.
class FoundationSection extends StatelessWidget {
  const FoundationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CatalogItem(
          title: 'ColorScheme',
          description: 'Роли M3 из AppTheme (seed — акцент из настроек)',
          child: _ColorRoles(),
        ),
        CatalogItem(
          title: 'AppThemeColorSchemeX',
          description: 'Дополнительные цвета приложения',
          child: _ExtraColors(),
        ),
        CatalogItem(
          title: 'AppDimens',
          description: 'Радиусы скругления',
          child: _Radii(),
        ),
        CatalogItem(
          title: 'TextTheme',
          description: 'Шрифт Nexa',
          child: _Typography(),
        ),
        CatalogItem(
          title: 'Height / Width',
          description: 'Отступы вместо SizedBox',
          child: _Spacing(),
        ),
      ],
    );
  }
}

class _ColorRoles extends StatelessWidget {
  const _ColorRoles();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _Swatch(name: 'primary', color: cs.primary, textColor: cs.onPrimary),
        _Swatch(
          name: 'primaryContainer',
          color: cs.primaryContainer,
          textColor: cs.onPrimaryContainer,
        ),
        _Swatch(
          name: 'secondary',
          color: cs.secondary,
          textColor: cs.onSecondary,
        ),
        _Swatch(
          name: 'secondaryContainer',
          color: cs.secondaryContainer,
          textColor: cs.onSecondaryContainer,
        ),
        _Swatch(name: 'tertiary', color: cs.tertiary, textColor: cs.onTertiary),
        _Swatch(
          name: 'tertiaryContainer',
          color: cs.tertiaryContainer,
          textColor: cs.onTertiaryContainer,
        ),
        _Swatch(name: 'error', color: cs.error, textColor: cs.onError),
        _Swatch(
          name: 'errorContainer',
          color: cs.errorContainer,
          textColor: cs.onErrorContainer,
        ),
        _Swatch(name: 'surface', color: cs.surface, textColor: cs.onSurface),
        _Swatch(
          name: 'surfaceContainerLow',
          color: cs.surfaceContainerLow,
          textColor: cs.onSurface,
        ),
        _Swatch(
          name: 'surfaceContainer',
          color: cs.surfaceContainer,
          textColor: cs.onSurface,
        ),
        _Swatch(
          name: 'surfaceContainerHigh',
          color: cs.surfaceContainerHigh,
          textColor: cs.onSurface,
        ),
        _Swatch(
          name: 'surfaceContainerHighest',
          color: cs.surfaceContainerHighest,
          textColor: cs.onSurface,
        ),
        _Swatch(name: 'outline', color: cs.outline, textColor: cs.surface),
        _Swatch(
          name: 'outlineVariant',
          color: cs.outlineVariant,
          textColor: cs.onSurface,
        ),
      ],
    );
  }
}

class _ExtraColors extends StatelessWidget {
  const _ExtraColors();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _Swatch(name: 'success', color: cs.success, textColor: cs.onSuccess),
        _Swatch(name: 'warning', color: cs.warning, textColor: cs.surface),
        _Swatch(name: 'info', color: cs.info, textColor: cs.surface),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  final String name;
  final Color color;
  final Color textColor;

  const _Swatch({
    required this.name,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 92,
      height: 64,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Text(
        name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.labelSmall?.copyWith(color: textColor),
      ),
    );
  }
}

class _Radii extends StatelessWidget {
  const _Radii();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _RadiusBox(name: 'radius4', radius: AppDimens.radius4),
        _RadiusBox(name: 'radius8', radius: AppDimens.radius8),
        _RadiusBox(name: 'radius12', radius: AppDimens.radius12),
        _RadiusBox(name: 'radius16', radius: AppDimens.radius16),
        _RadiusBox(name: 'radius20', radius: AppDimens.radius20),
        _RadiusBox(name: 'radius28', radius: AppDimens.radius28),
        _RadiusBox(name: 'radius32', radius: AppDimens.radius32),
      ],
    );
  }
}

class _RadiusBox extends StatelessWidget {
  final String name;
  final double radius;

  const _RadiusBox({required this.name, required this.radius});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        const Height(4),
        Text(name, style: theme.textTheme.labelSmall),
      ],
    );
  }
}

class _Typography extends StatelessWidget {
  const _Typography();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final styles = <(String, TextStyle?)>[
      ('displaySmall', textTheme.displaySmall),
      ('headlineLarge', textTheme.headlineLarge),
      ('headlineMedium', textTheme.headlineMedium),
      ('headlineSmall', textTheme.headlineSmall),
      ('titleLarge', textTheme.titleLarge),
      ('titleMedium', textTheme.titleMedium),
      ('titleSmall', textTheme.titleSmall),
      ('bodyLarge', textTheme.bodyLarge),
      ('bodyMedium', textTheme.bodyMedium),
      ('bodySmall', textTheme.bodySmall),
      ('labelLarge', textTheme.labelLarge),
      ('labelMedium', textTheme.labelMedium),
      ('labelSmall', textTheme.labelSmall),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (name, style) in styles)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(name, style: style),
          ),
      ],
    );
  }
}

class _Spacing extends StatelessWidget {
  const _Spacing();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.tertiaryContainer;
    final box = DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimens.radius8),
      ),
      child: const SizedBox.square(dimension: 32),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(children: [box, const Height(16), box]),
        const Width(32),
        Row(children: [box, const Width(8), box, const Width(24), box]),
      ],
    );
  }
}
