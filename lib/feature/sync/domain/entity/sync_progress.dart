import 'package:equatable/equatable.dart';

/// Прогресс первичной загрузки в серверных единицах — событиях журнала.
class SyncProgress extends Equatable {
  /// Показанная доля (0..1). Не убывает никогда.
  final double value;

  /// Сколько событий уже отдано.
  final int done;

  /// Сколько событий всего. Растёт, если во время загрузки появились новые.
  final int total;

  @override
  List<Object?> get props => [value, done, total];

  const SyncProgress({
    required this.value,
    required this.done,
    required this.total,
  });
}
