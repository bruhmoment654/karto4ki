import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/spacing/height.dart';
import 'package:quizzerg/uikit/spacing/width.dart';

/// Постоянный баннер «нужно войти заново» под шапкой.
///
/// Не снек: не перекрывает контент и не исчезает сам, пока пользователь
/// не перелогинится. Кнопка «Позже» скрывает баннер до перезапуска —
/// состояние всё равно остаётся видно в индикаторе шапки.
class SyncReauthBanner extends StatefulWidget {
  final StateStreamable<SyncState> syncState;
  final VoidCallback onSignInTap;

  const SyncReauthBanner({
    required this.syncState,
    required this.onSignInTap,
    super.key,
  });

  @override
  State<SyncReauthBanner> createState() => _SyncReauthBannerState();
}

class _SyncReauthBannerState extends State<SyncReauthBanner> {
  final ValueNotifier<bool> _isDismissed = ValueNotifier(false);

  @override
  void dispose() {
    _isDismissed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isDismissed,
      builder: (context, isDismissed, child) {
        if (isDismissed) return const SizedBox.shrink();

        return StateStreamableBuilder<SyncState>(
          bloc: widget.syncState,
          builder: (context, state) {
            if (!state.status.isExpired) return const SizedBox.shrink();

            return _Banner(
              onSignInTap: widget.onSignInTap,
              onLaterTap: () => _isDismissed.value = true,
            );
          },
        );
      },
    );
  }
}

class _Banner extends StatelessWidget {
  final VoidCallback onSignInTap;
  final VoidCallback onLaterTap;

  const _Banner({required this.onSignInTap, required this.onLaterTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.lock_person,
              size: 22,
              color: colorScheme.onErrorContainer,
            ),
            const Width(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.syncReauthTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onErrorContainer,
                    ),
                  ),
                  const Height(3),
                  Text(
                    l10n.syncReauthBody,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onErrorContainer
                          .withValues(alpha: 0.9),
                    ),
                  ),
                  const Height(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: onLaterTap,
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.onErrorContainer,
                        ),
                        child: Text(l10n.syncReauthLater),
                      ),
                      const Width(8),
                      FilledButton(
                        onPressed: onSignInTap,
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.onErrorContainer,
                          foregroundColor: colorScheme.errorContainer,
                        ),
                        child: Text(l10n.syncReauthSignIn),
                      ),
                    ],
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
