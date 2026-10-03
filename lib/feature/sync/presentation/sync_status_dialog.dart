import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_meta_keys.dart';
import 'package:quizzerg/feature/sync/presentation/sync_status_visual.dart';
import 'package:quizzerg/feature/sync/presentation/sync_time_format.dart';
import 'package:quizzerg/feature/sync/presentation/widget/sync_status_glyph.dart';
import 'package:quizzerg/l10n/app_localizations.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/dialogs/app_dialog.dart';
import 'package:quizzerg/uikit/progress/app_linear_progress.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Диалог состояния синхронизации.
///
/// Открывается по тапу на индикатор в шапке. Заголовок — статус, ниже
/// пояснение, когда была последняя синхронизация, и действие. Поток состояний
/// и действия приходят из ViewModel экрана.
Future<void> showSyncStatusDialog({
  required BuildContext context,
  required StateStreamable<SyncState> syncState,
  required VoidCallback onSignInTap,
  required VoidCallback onSyncTap,
}) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => _SyncStatusDialog(
      syncState: syncState,
      onSignInTap: () {
        Navigator.of(dialogContext).pop();
        onSignInTap();
      },
      onSyncTap: () {
        Navigator.of(dialogContext).pop();
        onSyncTap();
      },
    ),
  );
}

class _SyncStatusDialog extends StatelessWidget {
  final StateStreamable<SyncState> syncState;
  final VoidCallback onSignInTap;
  final VoidCallback onSyncTap;

  const _SyncStatusDialog({
    required this.syncState,
    required this.onSignInTap,
    required this.onSyncTap,
  });

  @override
  Widget build(BuildContext context) {
    return StateStreamableBuilder<SyncState>(
      bloc: syncState,
      builder: (context, state) => SyncStatusDialogView(
        state: state,
        onSignInTap: onSignInTap,
        onSyncTap: onSyncTap,
        onCloseTap: Navigator.of(context).pop,
      ),
    );
  }
}

/// Тело диалога. Про блок ничего не знает, поэтому проверяется
/// golden-тестами на голом состоянии.
class SyncStatusDialogView extends StatelessWidget {
  final SyncState state;
  final VoidCallback onSignInTap;
  final VoidCallback onSyncTap;
  final VoidCallback onCloseTap;

  /// «Сейчас» для подписей времени. Задаётся в тестах, чтобы golden
  /// не менялся на границе минуты.
  final DateTime? now;

  const SyncStatusDialogView({
    required this.state,
    required this.onSignInTap,
    required this.onSyncTap,
    required this.onCloseTap,
    this.now,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final at = now ?? DateTime.now().toUtc();
    final visual = syncStatusVisual(
      status: state.status,
      colorScheme: Theme.of(context).colorScheme,
      l10n: context.l10n,
      now: at,
      lastSyncedSource: state.lastSyncedSource,
    );

    return AppDialog(
      title: _Title(visual: visual),
      content: _Content(state: state, visual: visual, now: at),
      actions: _actions(context, visual),
    );
  }

  List<Widget> _actions(BuildContext context, SyncStatusVisual visual) {
    final action = visual.action;

    return [
      TextButton(
        onPressed: onCloseTap,
        child: Text(context.l10n.syncDialogClose),
      ),
      // При syncing действия нет — нажимать нечего, прогон уже идёт.
      if (action != null && !state.status.isSyncing)
        _ActionButton(
          action: action,
          onPressed: action == SyncStatusAction.signIn
              ? onSignInTap
              : onSyncTap,
        ),
    ];
  }
}

class _ActionButton extends StatelessWidget {
  final SyncStatusAction action;
  final VoidCallback onPressed;

  const _ActionButton({required this.action, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final label = Text(action.label(context.l10n));
    final icon = Icon(action.icon, size: 18);

    if (action == SyncStatusAction.signIn) {
      return FilledButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: label,
      );
    }

    return FilledButton.tonalIcon(
      onPressed: onPressed,
      icon: icon,
      label: label,
    );
  }
}

class _Title extends StatelessWidget {
  final SyncStatusVisual visual;

  const _Title({required this.visual});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        SyncStatusGlyph(visual: visual),
        const Width(14),
        Expanded(
          child: Text(
            visual.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: visual.isNeutral
                  ? theme.colorScheme.onSurface
                  : visual.color,
            ),
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final SyncState state;
  final SyncStatusVisual visual;
  final DateTime now;

  const _Content({
    required this.state,
    required this.visual,
    required this.now,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _dialogBody(state.status, context.l10n),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const Height(18),
        _LastSyncBox(state: state, visual: visual, now: now),
      ],
    );
  }
}

class _LastSyncBox extends StatelessWidget {
  final SyncState state;
  final SyncStatusVisual visual;
  final DateTime now;

  const _LastSyncBox({
    required this.state,
    required this.visual,
    required this.now,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final progress = state.status.progress;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.syncDialogLastSyncLabel,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const Height(3),
          Text(
            _lastSyncLabel(state, l10n, now),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          if (state.status.isSyncing) ...[
            const Height(12),
            AppLinearProgress(
              value: progress?.value,
              color: visual.color,
              // Блок лежит на surfaceContainer — трек берём на тон выше,
              // иначе полоска сливается с подложкой.
              trackColor: theme.colorScheme.surfaceContainerHighest,
              isWavy: true,
            ),
            const Height(8),
            Text(
              visual.subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ] else if (state.status.pending > 0) ...[
            const Height(6),
            Text(
              l10n.syncSubtitlePending(state.status.pending),
              style: theme.textTheme.bodySmall?.copyWith(color: visual.color),
            ),
          ],
        ],
      ),
    );
  }
}

/// Абсолютная подпись момента синхронизации.
///
/// При локальном источнике времени формулировка мягче: часы устройства
/// могут врать, и обещать точный циферблат нельзя.
String _lastSyncLabel(SyncState state, AppLocalizations l10n, DateTime now) {
  final lastSyncedAt = state.status.lastSyncedAt;
  if (lastSyncedAt == null) return l10n.syncSubtitleNever;

  final label = SyncTimeFormat.absolute(
    l10n: l10n,
    lastSyncedAt: lastSyncedAt,
    now: now,
  );

  return state.lastSyncedSource == SyncTimeSource.local
      ? l10n.syncDialogLastSyncApprox(label)
      : label;
}

String _dialogBody(SyncStatus status, AppLocalizations l10n) => switch (status) {
      SyncStatus$Disabled() || SyncStatus$Synced() => l10n.syncDialogBodySynced,
      SyncStatus$Syncing() => l10n.syncDialogBodySyncing,
      SyncStatus$NotSynced(:final pending) =>
        l10n.syncDialogBodyNotSynced(pending),
      SyncStatus$Offline() => l10n.syncDialogBodyOffline,
      SyncStatus$Expired() => l10n.syncDialogBodyExpired,
      SyncStatus$Failed() => l10n.syncDialogBodyFailed,
    };
