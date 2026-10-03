import 'package:freezed_annotation/freezed_annotation.dart';

part 'attempt_history_usage.freezed.dart';

/// Сколько места на устройстве занимает история прохождений.
@freezed
sealed class AttemptHistoryUsage with _$AttemptHistoryUsage {
  /// Истории нет.
  static const empty = AttemptHistoryUsage(bytes: 0);

  const AttemptHistoryUsage._();

  const factory AttemptHistoryUsage({
    required int bytes,

    /// Размер оценён по числу строк, а не посчитан по страницам базы.
    @Default(false) bool isEstimate,
  }) = _AttemptHistoryUsage;

  bool get isEmpty => bytes == 0;
}
