import 'package:flutter/material.dart';
import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/settings/domain/bloc/settings_bloc.dart';
import 'package:quizzerg/feature/settings/presentation/settings_screen.dart';
import 'package:quizzerg/feature/settings/presentation/widget/attempt_history_card.dart';
import 'package:quizzerg/feature/settings/presentation/widget/settings_card.dart';
import 'package:quizzerg/feature/test_execution/domain/bloc/attempt_history_bloc.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/expandable/expandable_section.dart';
import 'package:quizzerg/uikit/question_card/question_card.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/skeleton_gif/skeleton_gif.dart';
import 'package:quizzerg/uikit/slider/app_slider.dart';
import 'package:quizzerg/uikit/slider/hue_slider.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

class SettingsView extends StatelessWidget {
  final ISettingsViewModel viewModel;

  const SettingsView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: DefaultAppBar.withBack(
        title: Text(context.l10n.settingsTitle),
        onBackPressed: viewModel.onBackPressed,
      ),
      body: StateStreamableBuilder<SettingsState>(
        bloc: viewModel.settingsState,
        builder: (context, state) => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            SettingsCard(
              icon: Icons.palette,
              title: 'Внешний вид',
              children: [
                _ThemeModeSection(
                  viewModel: viewModel,
                  themeMode: state.settings.themeMode,
                ),
                const Height(22),
                _AccentColorSection(
                  viewModel: viewModel,
                  accentColorHue: state.accentColorHue,
                ),
                const Height(22),
                _AnimationSpeedSection(
                  viewModel: viewModel,
                  animationDurationMs: state.settings.animationDurationMs,
                ),
              ],
            ),
            const Height(16),
            SettingsCard(
              icon: Icons.dashboard_customize_outlined,
              title: 'Карточки',
              fadeInDelay: const Duration(milliseconds: 80),
              children: [
                _CardFontSizeSection(
                  viewModel: viewModel,
                  cardFontSize: state.settings.cardFontSize,
                ),
              ],
            ),
            const Height(16),
            StateStreamableBuilder<AttemptHistoryState>(
              bloc: viewModel.attemptHistoryState,
              builder: (context, historyState) => AttemptHistoryCard(
                state: historyState,
                onClearPressed: viewModel.onAttemptHistoryClearPressed,
                fadeInDelay: const Duration(milliseconds: 160),
              ),
            ),
            const Height(32),
            _StatsExportSection(
              isExporting: state.isExporting,
              onPressed: viewModel.onStatsExportPressed,
            ),
            const Height(32),
            const SkeletonGif(),
            const SizedBox(height: 16),
            _VersionLabel(version: state.appVersion),
          ],
        ),
      ),
    );
  }
}

/// Подзаголовок секции внутри карточки настроек.
class _SettingsSectionLabel extends StatelessWidget {
  final String text;

  const _SettingsSectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      text,
      style: theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _StatsExportSection extends StatelessWidget {
  final bool isExporting;
  final VoidCallback onPressed;

  const _StatsExportSection({
    required this.isExporting,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Экспорт статистики',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Height(8),
        Text(
          'Сохранит два CSV: question_stats и cards. '
          'В stats — счётчики ответов и компоненты score под текущими весами.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const Height(12),
        FilledButton.tonalIcon(
          onPressed: isExporting ? null : onPressed,
          icon: isExporting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.download),
          label: const Text('Экспортировать в CSV'),
        ),
      ],
    );
  }
}

class _AccentColorSection extends StatelessWidget {
  final ISettingsViewModel viewModel;
  final double accentColorHue;

  const _AccentColorSection({
    required this.viewModel,
    required this.accentColorHue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SettingsSectionLabel(context.l10n.profileAccentColorTitle),
        const Height(12),
        HueSlider(
          hue: accentColorHue,
          onChanged: viewModel.onAccentColorHueChanged,
          semanticLabel: context.l10n.profileAccentColorTitle,
        ),
      ],
    );
  }
}

class _VersionLabel extends StatelessWidget {
  final String version;

  const _VersionLabel({required this.version});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Text(
        version,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ThemeModeSection extends StatelessWidget {
  final ISettingsViewModel viewModel;
  final AppThemeMode themeMode;

  const _ThemeModeSection({required this.viewModel, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SettingsSectionLabel('Тема'),
        const Height(8),
        _ThemeModeSwitch(
          value: themeMode,
          onChanged: viewModel.onThemeModeChanged,
        ),
      ],
    );
  }
}

/// Сегментированный переключатель темы по дизайну: pill с обводкой, сегменты
/// на всю ширину, активный — выделен фоном `secondaryContainer`.
class _ThemeModeSwitch extends StatelessWidget {
  final AppThemeMode value;
  final ValueChanged<AppThemeMode> onChanged;

  const _ThemeModeSwitch({required this.value, required this.onChanged});

  static const _items = <(AppThemeMode, String)>[
    (AppThemeMode.light, 'Светлая'),
    (AppThemeMode.dark, 'Тёмная'),
    (AppThemeMode.system, 'Системная'),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      height: 44,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
      ),
      // Обводка рисуется поверх содержимого, иначе фон активного сегмента
      // перекрывает её по краям из-за клипа скруглённого контейнера.
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: cs.outline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < _items.length; i++) ...[
            if (i > 0)
              ColoredBox(color: cs.outline, child: const SizedBox(width: 1)),
            Expanded(
              child: _ThemeModeSegment(
                label: _items[i].$2,
                selected: _items[i].$1 == value,
                onTap: () => onChanged(_items[i].$1),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ThemeModeSegment extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeModeSegment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final foreground = selected ? cs.onSecondaryContainer : cs.onSurface;

    return Material(
      color: selected ? cs.secondaryContainer : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: foreground,
            ),
          ),
        ),
      ),
    );
  }
}

class _CardFontSizeSection extends StatelessWidget {
  final ISettingsViewModel viewModel;
  final double cardFontSize;

  const _CardFontSizeSection({
    required this.viewModel,
    required this.cardFontSize,
  });

  /// Минимальный размер шрифта на карточке (px).
  static const double minFontSize = 24;

  /// Максимальный размер шрифта на карточке (px).
  static const double maxFontSize = 200;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExpandableSection(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: _SettingsSectionLabel(context.l10n.profileCardFontSizeTitle),
          ),
          const Width(8),
          Text(
            context.l10n.profileCardFontSizeLabel(cardFontSize.round()),
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          const Height(8),
          AppSlider(
            value: cardFontSize,
            min: minFontSize,
            max: maxFontSize,
            onChanged: viewModel.onCardFontSizeChanged,
          ),
          const Height(12),
          _CardFontSizePreview(fontSize: cardFontSize),
        ],
      ),
    );
  }
}

/// Превью карточки теста: повторяет фон, скругление и отступы реальной карточки,
/// а текст рендерится через `CardBodyText` с выбранным размером — так видно,
/// каким он будет на карточке при текущей настройке.
class _CardFontSizePreview extends StatelessWidget {
  /// Базовый отступ контента карточки (`ContentCard.large`) в фиче.
  static const double _baseCardPadding = 24;

  /// Пример текста на карточке.
  static const String _sampleText = '渡る';

  final double fontSize;

  const _CardFontSizePreview({required this.fontSize});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Портретная пропорция, как у карточки в тесте.
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppDimens.radius28),
        ),
        child: Padding(
          padding: const EdgeInsets.all(_baseCardPadding),
          child: Center(
            child: CardBodyText(_sampleText, maxFontSize: fontSize),
          ),
        ),
      ),
    );
  }
}

class _AnimationSpeedSection extends StatelessWidget {
  final ISettingsViewModel viewModel;
  final int animationDurationMs;

  const _AnimationSpeedSection({
    required this.viewModel,
    required this.animationDurationMs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _SettingsSectionLabel(context.l10n.profileAnimationSpeedTitle),
            Text(
              context.l10n.profileAnimationDurationLabel(animationDurationMs),
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const Height(8),
        AppSlider(
          value: animationDurationMs.toDouble(),
          max: 1000,
          divisions: 10,
          onChanged: viewModel.onAnimationDurationChanged,
        ),
      ],
    );
  }
}
