import 'package:flutter/material.dart';

import 'package:quizzerg/feature/test_execution/domain/entity/active_test_session.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/app_radii.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/progress/app_linear_progress.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Карточка «Продолжить тест» над списком групп.
///
/// Продолжить можно и кнопкой, и тапом по карточке.
class ActiveSessionCard extends StatelessWidget {
  final ActiveTestSession session;

  /// Группа, из которой запущен тест; `null` — строку не показываем.
  final String? groupTitle;
  final VoidCallback onResume;
  final VoidCallback onDismiss;

  const ActiveSessionCard({
    required this.session,
    required this.onResume,
    required this.onDismiss,
    this.groupTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final total = session.session.cards.length;
    final current = session.session.currentIndex.clamp(0, total);
    final groupTitle = this.groupTitle;

    return ScalePressable(
      onTap: onResume,
      child: ContentCard(
        backgroundColor: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppDimens.radius28),
        padding: const EdgeInsets.fromLTRB(20, 16, 8, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.groupsListActiveSessionLabel,
                          style: textTheme.labelLarge?.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                        const Height(2),
                        Text(
                          session.testTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (groupTitle != null)
                          Text(
                            groupTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const Width(8),
                IconButton(
                  tooltip: context.l10n.groupsListActiveSessionDismiss,
                  icon: Icon(Icons.close, color: colorScheme.onSurfaceVariant),
                  onPressed: onDismiss,
                ),
              ],
            ),
            const Height(14),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: AppLinearProgress(
                value: total == 0 ? 0 : current / total,
                color: colorScheme.primary,
                trackColor: colorScheme.surfaceContainerHighest,
                isWavy: true,
              ),
            ),
            const Height(12),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.groupsListActiveSessionCards(current, total),
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const Width(12),
                  FilledButton.icon(
                    onPressed: onResume,
                    icon: const Icon(Icons.play_arrow),
                    label: Text(context.l10n.groupsListActiveSessionResume),
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
