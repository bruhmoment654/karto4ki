import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizzerg/core/bloc/state_streamable_builder.dart';
import 'package:quizzerg/feature/sync/domain/bloc/sync_bloc.dart';
import 'package:quizzerg/feature/sync/presentation/sync_status_visual.dart';
import 'package:quizzerg/feature/sync/presentation/widget/sync_status_glyph.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';
import 'package:quizzerg/uikit/theme/app_colors.dart';

/// Компактный индикатор синхронизации для шапки главной.
///
/// У гостя возвращает пустоту, поэтому шапку менять не нужно — виджет просто
/// вставляется в готовый слот `action`.
class SyncStatusBadge extends StatelessWidget {
  final StateStreamable<SyncState> syncState;

  /// Тап по индикатору — открытие диалога остаётся снаружи.
  final VoidCallback onTap;

  /// Диаметр кнопки.
  final double size;

  const SyncStatusBadge({
    required this.syncState,
    required this.onTap,
    this.size = 44,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StateStreamableBuilder<SyncState>(
      bloc: syncState,
      builder: (context, state) {
        if (!state.status.isVisible) return const SizedBox.shrink();

        return SyncStatusBadgeView(size: size, state: state, onTap: onTap);
      },
    );
  }
}

/// Кружок с иконкой и точкой-attention. Про блок не знает.
class SyncStatusBadgeView extends StatelessWidget {
  final double size;
  final SyncState state;
  final VoidCallback onTap;

  /// «Сейчас» для подписи времени. Задаётся в тестах.
  final DateTime? now;

  const SyncStatusBadgeView({
    required this.size,
    required this.state,
    required this.onTap,
    this.now,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final visual = syncStatusVisual(
      status: state.status,
      colorScheme: colorScheme,
      appColors: AppColors.of(context),
      l10n: context.l10n,
      now: now ?? DateTime.now().toUtc(),
      lastSyncedSource: state.lastSyncedSource,
    );

    return Semantics(
      label: visual.title,
      button: true,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              SyncStatusGlyph(
                visual: visual,
                size: size,
                borderRadius: BorderRadius.circular(size / 2),
              ),
              if (visual.needsAttention)
                Positioned(
                  top: 5,
                  right: 5,
                  child: _AttentionDot(color: visual.color),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AttentionDot extends StatelessWidget {
  final Color color;

  const _AttentionDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Theme.of(context).colorScheme.surface, width: 2),
      ),
    );
  }
}
