import 'package:flutter/material.dart';

import 'package:quizzerg/feature/test_execution/domain/entity/active_test_session.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Карточка «Продолжить активную сессию» на главном экране.
class ActiveSessionCard extends StatelessWidget {
  final ActiveTestSession session;
  final VoidCallback onResume;
  final VoidCallback onDismiss;

  const ActiveSessionCard({
    required this.session,
    required this.onResume,
    required this.onDismiss,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final accent = colorScheme.primary;
    final total = session.session.cards.length;
    final current = session.session.currentIndex.clamp(0, total);
    final progress = total == 0 ? 0.0 : current / total;

    return ScalePressable(
      onTap: onResume,
      child: ContentCard(
        borderColor: accent.withValues(alpha: 0.4),
        borderWidth: 0.5,
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: accent,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.groupsListActiveSessionTitle(
                      session.testTitle,
                    ),
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.foreground,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Height(6),
                  Text(
                    context.l10n.groupsListActiveSessionProgress(
                      current,
                      total,
                    ),
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Height(8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 4,
                      backgroundColor: accent.withValues(alpha: 0.15),
                      valueColor: AlwaysStoppedAnimation<Color>(accent),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: context.l10n.groupsListActiveSessionDismiss,
              icon: Icon(
                Icons.close_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
              onPressed: onDismiss,
            ),
          ],
        ),
      ),
    );
  }
}
