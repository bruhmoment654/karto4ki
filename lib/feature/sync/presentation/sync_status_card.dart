import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/presentation/sync_status_visual.dart';
import 'package:quizzerg/feature/sync/presentation/widget/sync_status_glyph.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/content_card/content_card.dart';
import 'package:quizzerg/uikit/content_card/content_card_type.dart';
import 'package:quizzerg/uikit/motion/app_animated_size.dart';
import 'package:quizzerg/uikit/motion/app_animated_switcher.dart';
import 'package:quizzerg/uikit/pressable/scale_pressable.dart';
import 'package:quizzerg/uikit/progress/app_wavy_circular_progress.dart';
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
      // Карточка появляется и скрывается плавно (например, после входа).
      builder: (context, state) => AppAnimatedSize(
        child: AppAnimatedSwitcher(
          alignment: Alignment.topCenter,
          child: state.status.isVisible
              ? SyncStatusCardView(
                  key: const ValueKey('sync_status_card'),
                  state: state,
                  onSignInTap: onSignInTap,
                  onSyncTap: onSyncTap,
                  onCardTap: onCardTap,
                )
              : const SizedBox(width: double.infinity),
        ),
      ),
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
    final isSyncing = state.status.isSyncing;
    final action = visual.action;

    return Semantics(
      label: visual.title,
      button: true,
      child: ScalePressable(
        onTap: onCardTap,
        child: ContentCard(
          padding: const EdgeInsets.all(16),
          type: ContentCardType.large,
          // Смена состояния: подписи и содержимое кнопки сменяются
          // свитчерами, а высота карточки доезжает за ними. Кнопка есть во
          // всех состояниях, поэтому ширина подписей не прыгает.
          child: AppAnimatedSize(
            // Строка прижата к верху, даже если карточке дали фиксированную
            // высоту.
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Row(
                children: [
                  // Загрузку показывает лоадер в кнопке — второй спиннер в
                  // глифе был бы лишним.
                  SyncStatusGlyph(visual: visual, isSpinnerAllowed: false),
                  const Width(14),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppAnimatedSwitcher(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            visual.title,
                            key: ValueKey(visual.title),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: visual.isNeutral
                                  ? theme.colorScheme.onSurface
                                  : visual.color,
                            ),
                          ),
                        ),
                        const Height(2),
                        AppAnimatedSwitcher(
                          alignment: AlignmentDirectional.centerStart,
                          transition: AppSwitcherTransition.slideUp,
                          child: Text(
                            visual.subtitle,
                            key: ValueKey(visual.subtitle),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSyncing || action != null) ...[
                    const Width(12),
                    _ActionButton(
                      action: action,
                      isLoading: isSyncing,
                      progress: progress?.value,
                      loaderColor: visual.color,
                      onPressed: action == SyncStatusAction.signIn
                          ? onSignInTap
                          : onSyncTap,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Круглая кнопка действия. Во время синхронизации вместо иконки крутится
/// лоадер-«змейка», кнопка неактивна.
class _ActionButton extends StatelessWidget {
  static const _size = 44.0;

  /// Лоадер чуть меньше кнопки, чтобы волна не упиралась в края.
  static const _loaderSize = 26.0;

  /// `null` — действия нет (идёт синхронизация).
  final SyncStatusAction? action;
  final bool isLoading;

  /// Прогресс синхронизации 0..1 либо `null`, если он неизвестен.
  final double? progress;
  final Color loaderColor;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.action,
    required this.isLoading,
    required this.loaderColor,
    required this.onPressed,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final action = this.action;
    final isSignIn = !isLoading && action == SyncStatusAction.signIn;
    final background = isSignIn
        ? colorScheme.primary
        : colorScheme.surfaceContainerHighest;
    final foreground = isSignIn ? colorScheme.onPrimary : colorScheme.onSurface;
    final isIdle = !isLoading && action != null;

    return IconButton(
      onPressed: isIdle ? onPressed : null,
      tooltip: isIdle ? action.label(context.l10n) : null,
      icon: AppAnimatedSwitcher(
        child: isIdle
            ? Icon(action.icon, key: ValueKey(action), size: 22)
            : AppWavyCircularProgress(
                key: const ValueKey('sync_loader'),
                value: progress,
                size: _loaderSize,
                color: loaderColor,
                trackColor: colorScheme.secondaryContainer,
                semanticsLabel: context.l10n.syncTitleSyncing,
              ),
      ),
      style: IconButton.styleFrom(
        fixedSize: const Size.square(_size),
        backgroundColor: background,
        foregroundColor: foreground,
        // Во время синхронизации кнопка неактивна, но не должна сереть.
        disabledBackgroundColor: background,
        disabledForegroundColor: foreground,
      ),
    );
  }
}
