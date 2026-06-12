import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzerg/app/di/app_scope.dart';
import 'package:quizzerg/core/sync/domain/entity/sync_status.dart';
import 'package:quizzerg/l10n/app_localizations_x.dart';

/// Бейдж «не синхронизировано»: маленькая точка рядом с названием сущности.
///
/// Виден только когда у сущности есть неотправленные изменения
/// ([SyncStatus.isPending]) и синхронизация вообще сконфигурирована
/// (`authService.isAvailable`). В остальных случаях не занимает места.
class SyncBadge extends StatelessWidget {
  /// Статус синхронизации сущности.
  final SyncStatus syncStatus;

  /// Цвет точки. По умолчанию — `colorScheme.tertiary`.
  final Color? color;

  /// Диаметр точки.
  final double size;

  const SyncBadge({
    required this.syncStatus,
    this.color,
    this.size = 8,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailable = context.read<IAppScope>().authService.isAvailable;
    if (!syncStatus.isPending || !isAvailable) {
      return const SizedBox.shrink();
    }

    return Tooltip(
      message: context.l10n.syncBadgeTooltip,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.tertiary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
