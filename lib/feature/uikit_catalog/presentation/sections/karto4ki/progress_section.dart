import 'package:flutter/material.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_replay.dart';
import 'package:quizzerg/uikit/progress/animated_circular_progress.dart';
import 'package:quizzerg/uikit/progress/animated_linear_progress.dart';
import 'package:quizzerg/uikit/progress/app_linear_progress.dart';
import 'package:quizzerg/uikit/progress/app_loading_indicator.dart';
import 'package:quizzerg/uikit/progress/app_wavy_circular_progress.dart';
import 'package:quizzerg/uikit/progress/liquid_score_ring.dart';
import 'package:quizzerg/uikit/progress/streak_week_progress.dart';
import 'package:quizzerg/uikit/progress/wave_fill_bar.dart';
import 'package:quizzerg/uikit/shape/shape_plate.dart';
import 'package:quizzerg/uikit/slider/app_slider.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/switch/app_switch.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Индикаторы прогресса и статистики.
class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CatalogItem(
          title: 'AnimatedLinearProgress',
          description: 'Плавно догоняет значение из ValueListenable',
          child: _LinearProgressDemo(),
        ),
        const CatalogItem(
          title: 'AppLinearProgress',
          description: 'M3E linear: плоская и «змейка», оба режима',
          child: _AppLinearProgressDemo(),
        ),
        CatalogItem(
          title: 'AppLoadingIndicator',
          description: 'M3E: неопределённая загрузка, размер 24..240',
          child: Row(
            children: [
              const AppLoadingIndicator(size: 24),
              const Width(16),
              const AppLoadingIndicator(size: 40),
              const Width(16),
              AppLoadingIndicator(size: 48, color: colorScheme.tertiary),
            ],
          ),
        ),
        CatalogItem(
          title: 'WaveFillBar',
          description: 'Волновое заполнение с бликом при появлении',
          child: CatalogReplay(
            child: WaveFillBar(
              value: 0.72,
              color: colorScheme.success,
              backgroundColor: colorScheme.surfaceContainerHighest,
            ),
          ),
        ),
        CatalogItem(
          title: 'AnimatedCircularProgress',
          description: 'M3E circular: заполнение от 0 с задержкой',
          child: CatalogReplay(
            child: Row(
              children: [
                AnimatedCircularProgress(
                  value: 0.84,
                  color: colorScheme.success,
                  trackColor: colorScheme.surfaceContainerHigh,
                  child: const Text('84%'),
                ),
                const Width(16),
                AnimatedCircularProgress(
                  value: 0.23,
                  color: colorScheme.warning,
                  trackColor: colorScheme.surfaceContainerHigh,
                  size: 88,
                  strokeWidth: 8,
                  delay: const Duration(milliseconds: 200),
                ),
              ],
            ),
          ),
        ),
        CatalogItem(
          title: 'AppWavyCircularProgress',
          description: 'M3E circular wavy: неопределённый и 60%',
          child: Row(
            children: [
              AppWavyCircularProgress(
                size: 40,
                color: colorScheme.primary,
                trackColor: colorScheme.secondaryContainer,
              ),
              const Width(16),
              AppWavyCircularProgress(
                value: 0.6,
                size: 40,
                color: colorScheme.primary,
                trackColor: colorScheme.secondaryContainer,
              ),
            ],
          ),
        ),
        CatalogItem(
          title: 'ShapePlate',
          description: 'Плашки-фигуры Material Shapes, фон медленно вращается',
          child: Row(
            children: [
              for (final kind in ShapePlateKind.values) ...[
                ShapePlate(
                  kind: kind,
                  size: 48,
                  color: colorScheme.tertiaryContainer,
                  isRotating: true,
                  child: Icon(
                    Icons.local_fire_department,
                    size: 22,
                    color: colorScheme.onTertiaryContainer,
                  ),
                ),
                const Width(12),
              ],
            ],
          ),
        ),
        const CatalogItem(
          title: 'LiquidScoreRing',
          description: 'Цвет зависит от процента (spectrumColor)',
          child: CatalogReplay(
            child: Center(
              child: LiquidScoreRing(
                pct: 72,
                correct: 18,
                total: 25,
                icon: Icons.emoji_events_outlined,
                size: 180,
              ),
            ),
          ),
        ),
        CatalogItem(
          title: 'StreakWeekProgress',
          child: StreakWeekProgress(
            activity: const [true, true, false, true, true, true, false],
            dayLabels: const ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'],
          ),
        ),
      ],
    );
  }
}

class _LinearProgressDemo extends StatefulWidget {
  const _LinearProgressDemo();

  @override
  State<_LinearProgressDemo> createState() => _LinearProgressDemoState();
}

class _LinearProgressDemoState extends State<_LinearProgressDemo> {
  final _progress = ValueNotifier<double>(0.3);

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        AnimatedLinearProgress(
          progress: _progress,
          backgroundColor: colorScheme.surfaceContainerHighest,
          valueColor: colorScheme.info,
        ),
        const Height(8),
        ValueListenableBuilder<double>(
          valueListenable: _progress,
          builder: (context, value, _) => AppSlider(
            value: value,
            divisions: 10,
            onChanged: (value) => _progress.value = value,
          ),
        ),
      ],
    );
  }
}

class _AppLinearProgressDemo extends StatefulWidget {
  const _AppLinearProgressDemo();

  @override
  State<_AppLinearProgressDemo> createState() => _AppLinearProgressDemoState();
}

class _AppLinearProgressDemoState extends State<_AppLinearProgressDemo> {
  double _value = 0.45;
  bool _isIndeterminate = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        AppLinearProgress(
          value: _isIndeterminate ? null : _value,
          color: colorScheme.primary,
          trackColor: colorScheme.surfaceContainerHighest,
        ),
        const Height(16),
        AppLinearProgress(
          value: _isIndeterminate ? null : _value,
          color: colorScheme.primary,
          trackColor: colorScheme.surfaceContainerHighest,
          isWavy: true,
        ),
        const Height(8),
        AppSlider(
          value: _value,
          onChanged: _isIndeterminate
              ? null
              : (value) => setState(() => _value = value),
        ),
        Row(
          children: [
            const Expanded(child: Text('Неопределённый')),
            const Width(8),
            AppSwitch(
              value: _isIndeterminate,
              onChanged: (value) => setState(() => _isIndeterminate = value),
            ),
          ],
        ),
      ],
    );
  }
}
