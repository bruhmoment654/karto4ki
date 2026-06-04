import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/question_stats/domain/service/i_stats_export_service.dart';
import 'package:quizzerg/feature/settings/presentation/settings_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/question_card/question_card.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/skeleton_gif/skeleton_gif.dart';
import 'package:quizzerg/uikit/slider/app_slider.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

class SettingsView extends StatelessWidget {
  final ISettingsViewModel viewModel;

  const SettingsView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: DefaultAppBar(title: Text(context.l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          _SettingsCard(
            icon: Icons.palette,
            title: 'Внешний вид',
            children: [
              _ThemeModeSection(viewModel: viewModel),
              const Height(22),
              _AccentColorSection(viewModel: viewModel),
              const Height(22),
              _AnimationSpeedSection(viewModel: viewModel),
            ],
          ),
          const Height(16),
          _SettingsCard(
            icon: Icons.dashboard_customize_outlined,
            title: 'Карточки',
            fadeInDelay: const Duration(milliseconds: 80),
            children: [
              _CardFontSizeSection(viewModel: viewModel),
            ],
          ),
          const Height(32),
          const _StatsExportSection(),
          const Height(32),
          const SkeletonGif(),
          const SizedBox(height: 16),
          _VersionLabel(version: viewModel.appVersion),
        ],
      ),
    );
  }
}

/// Карточка-блок настроек по дизайну: иконка + заголовок и список секций.
class _SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;
  final Duration fadeInDelay;

  const _SettingsCard({
    required this.icon,
    required this.title,
    required this.children,
    this.fadeInDelay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ContentCard(
      fadeIn: true,
      fadeInDelay: fadeInDelay,
      borderRadius: BorderRadius.circular(AppDimens.radius28),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: theme.colorScheme.primary),
              const Width(10),
              Text(title, style: theme.textTheme.titleMedium),
            ],
          ),
          const Height(16),
          ...children,
        ],
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

class _StatsExportSection extends StatefulWidget {
  const _StatsExportSection();

  @override
  State<_StatsExportSection> createState() => _StatsExportSectionState();
}

class _StatsExportSectionState extends State<_StatsExportSection> {
  bool _isExporting = false;

  Future<void> _onPressed() async {
    if (_isExporting) return;
    setState(() => _isExporting = true);

    final service = context.read<IAppScope>().statsExportService;
    final messenger = ScaffoldMessenger.of(context);
    final result = await service.export();

    if (!mounted) return;
    setState(() => _isExporting = false);

    final message = switch (result) {
      StatsExportSuccess() =>
        'Экспорт: ${result.questionCount} вопросов, ${result.cardCount} карточек\n'
            '${result.statsFilePath}\n${result.cardsFilePath}',
      StatsExportCancelled() => 'Экспорт отменён',
      StatsExportEmpty() => 'Нет данных для экспорта',
      StatsExportFailure() => 'Ошибка экспорта: ${result.message}',
    };
    messenger.showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 6)),
    );
  }

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
          onPressed: _isExporting ? null : _onPressed,
          icon: _isExporting
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

  const _AccentColorSection({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SettingsSectionLabel(context.l10n.profileAccentColorTitle),
        const Height(8),
        _HueSlider(
          hue: viewModel.accentColorHue,
          previewColor: viewModel.previewAccentColor,
          onChanged: viewModel.onAccentColorHueChanged,
        ),
      ],
    );
  }
}

class _HueSlider extends StatelessWidget {
  final double hue;
  final Color previewColor;
  final ValueChanged<double> onChanged;

  const _HueSlider({
    required this.hue,
    required this.previewColor,
    required this.onChanged,
  });

  static const _thumbPadding = 20.0;
  static const _previewSize = 28.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = constraints.maxWidth - 2 * _thumbPadding;
        final thumbX = _thumbPadding + (hue / 360) * trackWidth;

        return Column(
          children: [
            SizedBox(
              height: _previewSize + 4,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: thumbX - _previewSize / 2,
                    child: _ColorPreview(color: previewColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 12,
              margin: const EdgeInsets.symmetric(horizontal: _thumbPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                  colors: List.generate(
                    7,
                    (i) => HSLColor.fromAHSL(1, i * 60.0, 1, 0.57).toColor(),
                  ),
                ),
              ),
            ),
            AppSlider(
              value: hue,
              max: 360,
              onChanged: onChanged,
            ),
          ],
        );
      },
    );
  }
}

class _ColorPreview extends StatelessWidget {
  final Color color;

  const _ColorPreview({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _HueSlider._previewSize,
      height: _HueSlider._previewSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white24,
          width: 1.5,
        ),
      ),
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

  const _ThemeModeSection({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SettingsSectionLabel('Тема'),
        const Height(8),
        _ThemeModeSwitch(
          value: viewModel.themeMode,
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

class _CardFontSizeSection extends StatefulWidget {
  final ISettingsViewModel viewModel;

  const _CardFontSizeSection({required this.viewModel});

  /// Минимальный размер шрифта на карточке (px).
  static const double minFontSize = 24;

  /// Максимальный размер шрифта на карточке (px).
  static const double maxFontSize = 200;

  @override
  State<_CardFontSizeSection> createState() => _CardFontSizeSectionState();
}

class _CardFontSizeSectionState extends State<_CardFontSizeSection> {
  late final ValueNotifier<double> _fontSize =
      ValueNotifier(widget.viewModel.cardFontSize);

  void _onChanged(double value) {
    _fontSize.value = value;
    widget.viewModel.onCardFontSizeChanged(value);
  }

  @override
  void dispose() {
    _fontSize.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder<double>(
      valueListenable: _fontSize,
      builder: (context, fontSize, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SettingsSectionLabel(context.l10n.profileCardFontSizeTitle),
                Text(
                  context.l10n.profileCardFontSizeLabel(fontSize.round()),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const Height(8),
            AppSlider(
              value: fontSize,
              min: _CardFontSizeSection.minFontSize,
              max: _CardFontSizeSection.maxFontSize,
              onChanged: _onChanged,
            ),
            const Height(12),
            _CardFontSizePreview(fontSize: fontSize),
          ],
        );
      },
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

  const _AnimationSpeedSection({required this.viewModel});

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
              context.l10n.profileAnimationDurationLabel(
                viewModel.animationDurationMs,
              ),
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const Height(8),
        AppSlider(
          value: viewModel.animationDurationMs.toDouble(),
          max: 1000,
          divisions: 10,
          onChanged: viewModel.onAnimationDurationChanged,
        ),
      ],
    );
  }
}
