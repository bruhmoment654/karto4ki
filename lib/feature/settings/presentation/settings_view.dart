import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/feature/question_stats/domain/service/i_stats_export_service.dart';
import 'package:quizzerg/feature/settings/presentation/settings_screen.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/persistence/settings/data/settings_dto.dart';
import 'package:quizzerg/uikit/appbar/karto4ki_app_bar.dart';
import 'package:quizzerg/uikit/scaffold/app_scaffold.dart';
import 'package:quizzerg/uikit/skeleton_gif/skeleton_gif.dart';
import 'package:quizzerg/uikit/slider/app_slider.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/switch/app_switch.dart';

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
          _ThemeModeSection(viewModel: viewModel),
          const Height(32),
          _ShaderAnimationSection(viewModel: viewModel),
          const Height(32),
          _AccentColorSection(viewModel: viewModel),
          const Height(32),
          _AnimationSpeedSection(viewModel: viewModel),
          const Height(32),
          _CardFontSizeSection(viewModel: viewModel),
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
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.profileAccentColorTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
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

class _ShaderAnimationSection extends StatelessWidget {
  final ISettingsViewModel viewModel;

  const _ShaderAnimationSection({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            context.l10n.profileShaderAnimationTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        AppSwitch(
          value: viewModel.shaderAnimationEnabled,
          onChanged: (value) => viewModel.onShaderAnimationToggled(value: value),
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

  const _ThemeModeSection({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Тема',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SegmentedButton<AppThemeMode>(
          style: const ButtonStyle(
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 8),
            ),
            iconSize: WidgetStatePropertyAll(18),
          ),
          segments: const [
            ButtonSegment(
              value: AppThemeMode.system,
              label: Text('Системная'),
              icon: Icon(Icons.settings_brightness),
            ),
            ButtonSegment(
              value: AppThemeMode.light,
              label: Text('Светлая'),
              icon: Icon(Icons.light_mode),
            ),
            ButtonSegment(
              value: AppThemeMode.dark,
              label: Text('Тёмная'),
              icon: Icon(Icons.dark_mode),
            ),
          ],
          selected: {viewModel.themeMode},
          onSelectionChanged: (selected) {
            viewModel.onThemeModeChanged(selected.first);
          },
        ),
      ],
    );
  }
}

class _CardFontSizeSection extends StatelessWidget {
  final ISettingsViewModel viewModel;

  const _CardFontSizeSection({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fontSize = viewModel.cardFontSize;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.profileCardFontSizeTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Height(16),
        AppSlider(
          value: fontSize,
          min: 14,
          max: 40,
          divisions: 13,
          onChanged: viewModel.onCardFontSizeChanged,
        ),
        const Height(4),
        Center(
          child: Text(
            context.l10n.profileCardFontSizeLabel(fontSize.round()),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const Height(12),
        Center(
          child: Text(
            'Aa Бб',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
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
        Text(
          context.l10n.profileAnimationSpeedTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        AppSlider(
          value: viewModel.animationDurationMs.toDouble(),
          max: 1000,
          divisions: 10,
          onChanged: viewModel.onAnimationDurationChanged,
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            context.l10n.profileAnimationDurationLabel(
              viewModel.animationDurationMs,
            ),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
