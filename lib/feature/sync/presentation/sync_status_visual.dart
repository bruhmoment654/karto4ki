import 'package:flutter/material.dart';

import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/domain/entity/sync_meta_keys.dart';
import 'package:quizzerg/feature/sync/presentation/sync_time_format.dart';
import 'package:quizzerg/l10n/app_localizations.dart';
import 'package:quizzerg/uikit/theme/app_theme.dart';

/// Действие, которое предлагает статус.
enum SyncStatusAction {
  /// Синхронизировать сейчас.
  sync,

  /// Повторить упавший прогон.
  retry,

  /// Перелогиниться.
  signIn,
}

/// Иконка, цвет и подписи одного состояния синхронизации.
class SyncStatusVisual {
  /// Глиф. `null`, когда вместо него крутится спиннер.
  final IconData? icon;

  /// Рисовать спиннер вместо глифа: симметричный, корректно вращается
  /// вокруг центра (асимметричные иконки при вращении выглядят криво).
  final bool isSpinner;

  final Color color;

  /// Нейтральный тон: офлайн — это режим работы, а не ошибка, и красить
  /// его в акцент нельзя.
  final bool isNeutral;

  final String title;
  final String subtitle;
  final SyncStatusAction? action;

  /// Точка-attention в углу бейджа.
  final bool needsAttention;

  const SyncStatusVisual({
    required this.color,
    required this.title,
    required this.subtitle,
    this.icon,
    this.isSpinner = false,
    this.isNeutral = false,
    this.action,
    this.needsAttention = false,
  });
}

/// Единственное место, где статус превращается в иконку, цвет и подписи.
///
/// Чистая функция: всё, что ей нужно, приходит аргументами — поэтому
/// покрывается юнит-тестом без виджетов.
SyncStatusVisual syncStatusVisual({
  required SyncStatus status,
  required ColorScheme colorScheme,
  required AppLocalizations l10n,
  required DateTime now,
  SyncTimeSource lastSyncedSource = SyncTimeSource.server,
}) {
  final lastSyncedAt = status.lastSyncedAt;

  return switch (status) {
    SyncStatus$Disabled() || SyncStatus$Synced() => SyncStatusVisual(
        icon: Icons.cloud_done,
        color: colorScheme.success,
        title: l10n.syncTitleSynced,
        subtitle: _syncedSubtitle(
          l10n: l10n,
          lastSyncedAt: lastSyncedAt,
          now: now,
          source: lastSyncedSource,
        ),
        action: SyncStatusAction.sync,
      ),
    SyncStatus$Syncing(:final progress) => SyncStatusVisual(
        isSpinner: true,
        color: colorScheme.primary,
        title: l10n.syncTitleSyncing,
        subtitle: progress == null
            ? l10n.syncSubtitleSyncingPlain
            : l10n.syncSubtitleSyncingCounted(progress.done, progress.total),
      ),
    SyncStatus$NotSynced(:final pending) => SyncStatusVisual(
        icon: Icons.cloud_upload,
        color: colorScheme.warning,
        title: l10n.syncTitleNotSynced,
        subtitle: l10n.syncSubtitlePending(pending),
        action: SyncStatusAction.sync,
        needsAttention: true,
      ),
    SyncStatus$Offline() => SyncStatusVisual(
        icon: Icons.cloud_off,
        color: colorScheme.onSurfaceVariant,
        isNeutral: true,
        title: l10n.syncTitleOffline,
        subtitle: l10n.syncSubtitleOffline,
        action: SyncStatusAction.retry,
      ),
    SyncStatus$Expired() => SyncStatusVisual(
        icon: Icons.lock_person,
        color: colorScheme.error,
        title: l10n.syncTitleExpired,
        subtitle: l10n.syncSubtitleExpired,
        action: SyncStatusAction.signIn,
        needsAttention: true,
      ),
    // В дизайне пять состояний, и error-тон занят под протухший токен.
    // Отдельного визуала под сетевую ошибку нет, поэтому рисуем как
    // «не синхронизировано», только с честным заголовком.
    SyncStatus$Failed() => SyncStatusVisual(
        icon: Icons.cloud_upload,
        color: colorScheme.warning,
        title: l10n.syncTitleFailed,
        subtitle: l10n.syncSubtitleFailed,
        action: SyncStatusAction.retry,
        needsAttention: true,
      ),
  };
}

/// Подпись «синхронизировано»: относительная, если время серверное.
///
/// При `local` (сборка бэкенда без `serverTime`) относительную не
/// показываем вовсе — врать точнее, чем врать точно.
String _syncedSubtitle({
  required AppLocalizations l10n,
  required DateTime? lastSyncedAt,
  required DateTime now,
  required SyncTimeSource source,
}) {
  if (lastSyncedAt == null) return l10n.syncSubtitleNever;
  if (source == SyncTimeSource.local) return l10n.syncSubtitleSyncedNoTime;

  return l10n.syncSubtitleSyncedRelative(
    SyncTimeFormat.relative(
      l10n: l10n,
      lastSyncedAt: lastSyncedAt,
      now: now,
    ),
  );
}

/// Подпись действия в кнопке.
extension SyncStatusActionX on SyncStatusAction {
  String label(AppLocalizations l10n) => switch (this) {
        SyncStatusAction.sync => l10n.syncActionSync,
        SyncStatusAction.retry => l10n.syncActionRetry,
        SyncStatusAction.signIn => l10n.syncActionSignIn,
      };

  IconData get icon => switch (this) {
        SyncStatusAction.sync || SyncStatusAction.retry => Icons.sync,
        SyncStatusAction.signIn => Icons.login,
      };
}
