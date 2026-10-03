import 'package:flutter/material.dart';

import 'package:quizzerg/feature/settings/presentation/widget/attempt_history_format.dart';
import 'package:quizzerg/feature/settings/presentation/widget/settings_card.dart';
import 'package:quizzerg/feature/test_execution/domain/bloc/attempt_history_bloc.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/skeleton/skeleton_box.dart';
import 'package:quizzerg/uikit/skeleton/skeleton_pulse.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Карточка «История прохождений»: сколько места она занимает и очистка.
class AttemptHistoryCard extends StatelessWidget {
  final AttemptHistoryState state;
  final VoidCallback onClearPressed;
  final Duration fadeInDelay;

  const AttemptHistoryCard({
    required this.state,
    required this.onClearPressed,
    this.fadeInDelay = Duration.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final state = this.state;

    // Размер не посчитался (`usage == null`) — очистить всё равно можно.
    final canClear = switch (state) {
      AttemptHistoryState$Loading() => false,
      AttemptHistoryState$Loaded(:final usage, :final isClearing) =>
        !isClearing && !(usage?.isEmpty ?? false),
    };

    return SettingsCard(
      icon: Icons.history,
      title: l10n.settingsHistoryTitle,
      fadeInDelay: fadeInDelay,
      children: [
        Row(
          children: [
            Expanded(
              child: switch (state) {
                AttemptHistoryState$Loading() => const _UsageSkeleton(),
                AttemptHistoryState$Loaded(:final usage) => Text(
                  AttemptHistoryFormat.usage(l10n, usage),
                  style: theme.textTheme.titleMedium,
                ),
              },
            ),
            const Width(12),
            _ClearButton(
              isClearing:
                  state is AttemptHistoryState$Loaded && state.isClearing,
              onPressed: canClear ? onClearPressed : null,
            ),
          ],
        ),
        const Height(8),
        Text(
          l10n.settingsHistoryDescription,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _UsageSkeleton extends StatelessWidget {
  const _UsageSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: SkeletonPulse(child: SkeletonBox(width: 136, height: 20)),
    );
  }
}

/// Кнопка очистки: во время очистки вместо иконки — прогресс, как у экспорта.
class _ClearButton extends StatelessWidget {
  final bool isClearing;
  final VoidCallback? onPressed;

  const _ClearButton({required this.isClearing, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: onPressed,
      icon: isClearing
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.delete_outline),
      label: Text(context.l10n.settingsHistoryClear),
    );
  }
}
