import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/presentation/sync_status_visual.dart';
import 'package:quizzerg/feature/sync/presentation/widget/sync_status_glyph.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/progress/wave_progress_bar.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Карточка состояния синхронизации.
///
/// Поток состояний и действия приходят снаружи — из ViewModel экрана,
/// на котором карточка показывается.
class SyncStatusCard extends StatelessWidget {
  final StateStreamable<SyncState> syncState;

  /// Тап по действию «Войти» — навигация остаётся снаружи.
  final VoidCallback onSignInTap;

  /// Тап по действию «Синхронизировать».
  final VoidCallback onSyncTap;

  /// Тап по самой карточке — открытие диалога остаётся снаружи.
  final VoidCallback onCardTap;

  const SyncStatusCard({
    required this.syncState,
    required this.onSignInTap,
    required this.onSyncTap,
    required this.onCardTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StateStreamableBuilder<SyncState>(
      bloc: syncState,
      builder: (context, state) {
        if (!state.status.isVisible) return const SizedBox.shrink();

        return SyncStatusCardView(
          state: state,
          onSignInTap: onSignInTap,
          onSyncTap: onSyncTap,
          onCardTap: onCardTap,
        );
      },
    );
  }
}

/// Явная строка состояния синхронизации в профиле.
///
/// Отдельная карточка, а не мелкий чип: пользователь должен видеть, что его
/// карточки лежат на сервере, без догадок. Про блок ничего не знает —
/// поэтому проверяется golden-тестами на голом состоянии.
class SyncStatusCardView extends StatelessWidget {
  final SyncState state;
  final VoidCallback onSignInTap;
  final VoidCallback onSyncTap;
  final VoidCallback onCardTap;

  /// «Сейчас» для относительной подписи. Задаётся в тестах, чтобы golden
  /// не менялся на границе минуты.
  final DateTime? now;

  const SyncStatusCardView({
    required this.state,
    required this.onSignInTap,
    required this.onSyncTap,
    required this.onCardTap,
    this.now,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visual = syncStatusVisual(
      status: state.status,
      colorScheme: theme.colorScheme,
      l10n: context.l10n,
      now: now ?? DateTime.now().toUtc(),
      lastSyncedSource: state.lastSyncedSource,
    );
    final progress = state.status.progress;

    return Semantics(
      label: visual.title,
      button: true,
      child: ScalePressable(
        onTap: onCardTap,
        child: ContentCard(
          padding: const EdgeInsets.all(16),
          type: ContentCardType.large,
          child: Column(
            children: [
              Row(
                children: [
                  SyncStatusGlyph(visual: visual),
                  const Width(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          visual.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: visual.isNeutral
                                ? theme.colorScheme.onSurface
                                : visual.color,
                          ),
                        ),
                        const Height(2),
                        Text(
                          visual.subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (visual.action != null) ...[
                    const Width(12),
                    _ActionButton(
                      action: visual.action!,
                      onPressed: visual.action == SyncStatusAction.signIn
                          ? onSignInTap
                          : onSyncTap,
                      isSignIn: visual.action == SyncStatusAction.signIn,
                    ),
                  ],
                ],
              ),
              if (state.status.isSyncing) ...[
                const Height(12),
                WaveProgressBar(
                  value: progress?.value,
                  color: visual.color,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final SyncStatusAction action;
  final VoidCallback onPressed;
  final bool isSignIn;

  const _ActionButton({
    required this.action,
    required this.onPressed,
    required this.isSignIn,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      onPressed: onPressed,
      tooltip: action.label(context.l10n),
      icon: Icon(action.icon, size: 22),
      style: IconButton.styleFrom(
        fixedSize: const Size.square(44),
        backgroundColor:
            isSignIn ? colorScheme.primary : colorScheme.surfaceContainerHighest,
        foregroundColor: isSignIn ? colorScheme.onPrimary : colorScheme.onSurface,
      ),
    );
  }
}
