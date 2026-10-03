import 'package:flutter/material.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_item.dart';
import 'package:quizzerg/feature/uikit_catalog/presentation/widgets/catalog_replay.dart';
import 'package:quizzerg/uikit/progress/animated_linear_progress.dart';
import 'package:quizzerg/uikit/progress/fill_ring.dart';
import 'package:quizzerg/uikit/progress/liquid_score_ring.dart';
import 'package:quizzerg/uikit/progress/streak_week_strip.dart';
import 'package:quizzerg/uikit/progress/wave_fill_bar.dart';
import 'package:quizzerg/uikit/progress/wave_progress_bar.dart';
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
          title: 'WaveProgressBar',
          description: 'Определённый и неопределённый режим',
          child: _WaveProgressDemo(),
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
          title: 'FillRing',
          child: CatalogReplay(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FillRing(
                    percent: 84,
                    color: colorScheme.success,
                    label: 'Точность',
                    sub: '210/250',
                  ),
                ),
                Expanded(
                  child: FillRing(
                    percent: 56,
                    color: colorScheme.primary,
                    label: 'Выучено',
                    sub: '28/50',
                    animationDelay: const Duration(milliseconds: 120),
                  ),
                ),
                Expanded(
                  child: FillRing(
                    percent: 23,
                    color: colorScheme.warning,
                    label: 'Без ошибок',
                    sub: '6/26',
                    animationDelay: const Duration(milliseconds: 240),
                  ),
                ),
              ],
            ),
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
          title: 'StreakWeekStrip',
          child: StreakWeekStrip(
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

class _WaveProgressDemo extends StatefulWidget {
  const _WaveProgressDemo();

  @override
  State<_WaveProgressDemo> createState() => _WaveProgressDemoState();
}

class _WaveProgressDemoState extends State<_WaveProgressDemo> {
  double _value = 0.45;
  bool _isIndeterminate = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        WaveProgressBar(
          value: _isIndeterminate ? null : _value,
          color: colorScheme.primary,
          backgroundColor: colorScheme.surfaceContainerHighest,
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
