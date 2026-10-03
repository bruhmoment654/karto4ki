import 'package:flutter/material.dart';
import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/settings/domain/bloc/settings_bloc.dart';
import 'package:quizzerg/feature/settings/presentation/settings_screen.dart';
import 'package:quizzerg/feature/settings/presentation/widget/attempt_history_card.dart';
import 'package:quizzerg/feature/settings/presentation/widget/color_style_picker.dart';
import 'package:quizzerg/feature/settings/presentation/widget/settings_card.dart';
import 'package:quizzerg/feature/test_execution/domain/bloc/attempt_history_bloc.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/buttons/app_toggle_button_group.dart';
import 'package:quizzerg/uikit/expandable/expandable_section.dart';
import 'package:quizzerg/uikit/question_card/question_card.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/skeleton_gif/skeleton_gif.dart';
import 'package:quizzerg/uikit/slider/app_slider.dart';
import 'package:quizzerg/uikit/slider/hue_slider.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

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
              title: context.l10n.settingsAppearanceTitle,
              children: [
                _ThemeModeSection(
                  viewModel: viewModel,
                  themeMode: state.settings.themeMode,
                ),
                const Height(22),
                _ColorStyleSection(
                  viewModel: viewModel,
                  colorStyle: state.settings.colorStyle,
                  accentColorHue: state.accentColorHue,
                ),
                const Height(22),
                _AccentColorSection(
                  viewModel: viewModel,
                  accentColorHue: state.accentColorHue,
                  colorStyle: state.settings.colorStyle,
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
  final AppColorStyle colorStyle;

  const _AccentColorSection({
    required this.viewModel,
    required this.accentColorHue,
    required this.colorStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = context.l10n;
    final isColorful = colorStyle == AppColorStyle.colorful;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _SettingsSectionLabel(l10n.profileAccentColorTitle),
            ),
            const _AccentSwatch(),
          ],
        ),
        const Height(6),
        HueSlider(
          hue: accentColorHue,
          onChanged: viewModel.onAccentColorHueChanged,
          semanticLabel: l10n.profileAccentColorTitle,
          // В цветном стиле ручка — сам seed, в монохроме — акцент схемы.
          thumbColor: isColorful ? null : cs.primary,
        ),
        const Height(8),
        Text(
          isColorful
              ? l10n.settingsAccentHintColorful
              : l10n.settingsAccentHintMonochrome,
          style: theme.textTheme.bodySmall?.copyWith(
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

/// Квадратик текущего акцента (`primary`) у подзаголовка.
class _AccentSwatch extends StatelessWidget {
  static const _size = 14.0;

  const _AccentSwatch();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class _ColorStyleSection extends StatelessWidget {
  final ISettingsViewModel viewModel;
  final AppColorStyle colorStyle;
  final double accentColorHue;

  const _ColorStyleSection({
    required this.viewModel,
    required this.colorStyle,
    required this.accentColorHue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SettingsSectionLabel(context.l10n.settingsStyleTitle),
        const Height(10),
        ColorStylePicker(
          value: colorStyle,
          accent: AppTheme.seedColorFromHue(accentColorHue),
          onChanged: viewModel.onColorStyleChanged,
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
  static const _modes = [
    AppThemeMode.light,
    AppThemeMode.dark,
    AppThemeMode.system,
  ];

  final ISettingsViewModel viewModel;
  final AppThemeMode themeMode;

  const _ThemeModeSection({required this.viewModel, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(child: _SettingsSectionLabel(l10n.settingsThemeTitle)),
            Text(
              _labelOf(context, themeMode),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const Height(8),
        AppToggleButtonGroup(
          items: [
            for (final mode in _modes)
              AppToggleButtonItem(
                icon: _iconOf(mode, isSelected: false),
                selectedIcon: _iconOf(mode, isSelected: true),
                semanticLabel: _labelOf(context, mode),
              ),
          ],
          selectedIndex: _modes.indexOf(themeMode),
          onSelectedChanged: (index) =>
              viewModel.onThemeModeChanged(_modes[index]),
        ),
      ],
    );
  }

  String _labelOf(BuildContext context, AppThemeMode mode) {
    final l10n = context.l10n;

    return switch (mode) {
      AppThemeMode.light => l10n.settingsThemeLight,
      AppThemeMode.dark => l10n.settingsThemeDark,
      AppThemeMode.system => l10n.settingsThemeSystem,
    };
  }

  IconData _iconOf(AppThemeMode mode, {required bool isSelected}) =>
      switch (mode) {
        AppThemeMode.light =>
          isSelected ? Icons.light_mode : Icons.light_mode_outlined,
        AppThemeMode.dark =>
          isSelected ? Icons.dark_mode : Icons.dark_mode_outlined,
        AppThemeMode.system =>
          isSelected ? Icons.brightness_auto : Icons.brightness_auto_outlined,
      };
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
