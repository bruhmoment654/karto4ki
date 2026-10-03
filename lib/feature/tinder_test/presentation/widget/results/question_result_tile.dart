import 'package:flutter/material.dart';
import 'package:quizzerg/feature/test_execution/domain/entity/attempt_summary.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/spacing/width.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';

/// Иконка тренда: в строке вопроса и на фильтре по тренду.
extension QuestionTrendIcon on QuestionTrend {
  IconData get icon => switch (this) {
    QuestionTrend.firstCorrect => Icons.auto_awesome,
    QuestionTrend.fixed => Icons.trending_up,
    QuestionTrend.forgot => Icons.trending_down,
    QuestionTrend.repeatedMistake => Icons.replay,
    QuestionTrend.stable => Icons.check,
  };
}

/// Строка разбора: текущий ответ, вопрос с ответом и справа — иконка тренда
/// с историей или, если вопрос в тесте впервые, «Знаю / Не знаю».
class QuestionResultTile extends StatelessWidget {
  final QuestionResult result;

  const QuestionResultTile({required this.result, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colors = AppColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final tone = result.isCorrect ? colors.success : colorScheme.error;
    final trend = result.trend;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            result.isCorrect ? Icons.check_circle : Icons.cancel,
            size: 24,
            color: tone,
          ),
          const Width(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.card.front,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium,
                ),
                Text(
                  result.card.formattedBack,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Width(12),
          if (trend == null)
            Text(
              result.isCorrect
                  ? context.l10n.tinderTestResultsAnswerKnow
                  : context.l10n.tinderTestResultsAnswerDontKnow,
              style: textTheme.labelMedium?.copyWith(color: tone),
            )
          else ...[
            _TrendIcon(trend: trend),
            const Width(6),
            _HistoryDots(history: result.history),
          ],
        ],
      ),
    );
  }
}

/// Ответы на вопрос в прохождениях теста; свежий — крупнее.
class _HistoryDots extends StatelessWidget {
  final List<bool> history;

  const _HistoryDots({required this.history});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colors = AppColors.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < history.length; i++) ...[
          if (i > 0) const Width(5),
          _Dot(
            color: history[i] ? colors.success : colorScheme.error,
            isLatest: i == history.length - 1,
          ),
        ],
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  final bool isLatest;

  const _Dot({required this.color, required this.isLatest});

  @override
  Widget build(BuildContext context) {
    final size = isLatest ? 12.0 : 8.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: isLatest ? color : color.withValues(alpha: 0.55),
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Тренд без подписи — по иконке и цвету; подпись только для диктора.
class _TrendIcon extends StatelessWidget {
  final QuestionTrend trend;

  const _TrendIcon({required this.trend});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colors = AppColors.of(context);
    final l10n = context.l10n;
    final (label, color) = switch (trend) {
      QuestionTrend.firstCorrect => (
        l10n.tinderTestResultsTrendFirstCorrect,
        colors.success,
      ),
      QuestionTrend.fixed => (
        l10n.tinderTestResultsTrendFixed,
        colors.success,
      ),
      QuestionTrend.forgot => (
        l10n.tinderTestResultsTrendForgot,
        colorScheme.error,
      ),
      QuestionTrend.repeatedMistake => (
        l10n.tinderTestResultsTrendRepeatedMistake,
        colorScheme.error,
      ),
      QuestionTrend.stable => (
        l10n.tinderTestResultsTrendStable,
        colorScheme.onSurfaceVariant,
      ),
    };

    return Icon(trend.icon, size: 16, color: color, semanticLabel: label);
  }
}
