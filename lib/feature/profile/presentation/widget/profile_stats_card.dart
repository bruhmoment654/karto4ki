import 'package:flutter/material.dart';
import 'package:quizzerg/feature/profile/domain/entity/profile_summary_entity.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/motion/count_up_text.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/progress/animated_circular_progress.dart';
import 'package:quizzerg/uikit/shape/shape_plate.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Карточка «Статистика» в профиле: герой-кольцо «Точность» и две метрики
/// строками («Изучено», «Без ошибок»). Тап открывает таб статистики.
class ProfileStatsCard extends StatelessWidget {
  static const _heroGap = 18.0;
  static const _heroMaxSize = 132.0;
  static const _heroMinSize = 88.0;

  /// Ширина, при которой названия метрик в строках не обрезаются.
  static const _rowsMinWidth = 178.0;

  final ProfileSummaryEntity summary;
  final VoidCallback onTap;

  const ProfileStatsCard({
    required this.summary,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return ScalePressable(
      onTap: onTap,
      child: ContentCard(
        type: ContentCardType.large,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const _Header(),
            const Height(18),
            LayoutBuilder(
              builder: (context, constraints) => Row(
                children: [
                  _AccuracyHero(
                    size: _heroSize(constraints.maxWidth),
                    percent: summary.accuracyPercent,
                    label: l10n.profileRingAccuracy,
                    sub: '${summary.correctTotal}/${summary.answersTotal}',
                  ),
                  const Width(_heroGap),
                  Expanded(
                    child: Column(
                      children: [
                        _MetricRow(
                          shape: ShapePlateKind.pentagon,
                          icon: Icons.school,
                          color: cs.primary,
                          label: l10n.profileRingMastered,
                          sub: '${summary.masteredCount}/${summary.totalCards}',
                          percent: summary.masteredPercent,
                          delay: const Duration(milliseconds: 340),
                        ),
                        const Height(14),
                        _MetricRow(
                          shape: ShapePlateKind.cookie7Sided,
                          icon: Icons.verified,
                          color: cs.warning,
                          label: l10n.profileRingFlawless,
                          sub: '${summary.flawlessCount}/${summary.totalCards}',
                          percent: summary.flawlessPercent,
                          delay: const Duration(milliseconds: 460),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Кольцо по дизайну — 132, но на узких экранах (360) уступает место
/// строкам метрик, иначе их названия обрезаются.
double _heroSize(double maxWidth) =>
    (maxWidth - ProfileStatsCard._heroGap - ProfileStatsCard._rowsMinWidth)
        .clamp(ProfileStatsCard._heroMinSize, ProfileStatsCard._heroMaxSize);

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(Icons.insights, size: 22, color: cs.primary),
        const Width(10),
        Expanded(
          child: Text(
            context.l10n.profileStatsCardTitle,
            style: textTheme.titleMedium,
          ),
        ),
        Text(
          context.l10n.profileStatsCardMore,
          style: textTheme.labelLarge?.copyWith(color: cs.primary),
        ),
        Icon(Icons.chevron_right, size: 20, color: cs.primary),
      ],
    );
  }
}

/// Главная метрика: кольцо с процентом, названием и «верные/всего» внутри.
class _AccuracyHero extends StatelessWidget {
  static const _delay = Duration(milliseconds: 140);

  final double size;
  final int percent;
  final String label;
  final String sub;

  const _AccuracyHero({
    required this.size,
    required this.percent,
    required this.label,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final secondaryColor = cs.onSurfaceVariant;

    return AnimatedCircularProgress(
      value: percent / 100,
      color: cs.success,
      trackColor: cs.surfaceContainerHigh,
      size: size,
      strokeWidth: size >= 120 ? 10 : 8,
      delay: _delay,
      semanticsLabel: label,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CountUpText(
            value: percent,
            suffix: '%',
            delay: _delay,
            style: textTheme.headlineMedium?.copyWith(
              // 30 при кольце 132, как в дизайне.
              fontSize: (size * 0.23).roundToDouble(),
              fontWeight: FontWeight.w800,
              height: 1,
              color: cs.success,
            ),
          ),
          const Height(3),
          Text(
            label,
            style: textTheme.labelMedium?.copyWith(color: secondaryColor),
          ),
          Text(sub, style: textTheme.bodySmall?.copyWith(color: secondaryColor)),
        ],
      ),
    );
  }
}

/// Второстепенная метрика: плашка-фигура, название, «n/всего» и процент.
class _MetricRow extends StatelessWidget {
  static const _plateSize = 40.0;

  /// Фиксированная ширина под «100%», чтобы строка не дёргалась во время
  /// накрутки числа.
  static const _percentWidth = 42.0;

  final ShapePlateKind shape;
  final IconData icon;
  final Color color;
  final String label;
  final String sub;
  final int percent;
  final Duration delay;

  const _MetricRow({
    required this.shape,
    required this.icon,
    required this.color,
    required this.label,
    required this.sub,
    required this.percent,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        ShapePlate(
          kind: shape,
          size: _plateSize,
          color: color.withValues(alpha: 0.22),
          isRotating: true,
          child: Icon(icon, size: 18, color: color),
        ),
        const Width(11),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Height(1),
              Text(
                sub,
                style: textTheme.bodySmall?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: _percentWidth,
          child: Align(
            alignment: Alignment.centerRight,
            child: CountUpText(
              value: percent,
              suffix: '%',
              delay: delay,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
