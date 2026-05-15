import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/feature/tinder_test/domain/mixup/mixup_algorithm.dart';

part 'active_session_launch_params.freezed.dart';

/// Параметры запуска теста, сохранённые вместе с активной сессией.
///
/// Используются при возобновлении сессии, чтобы восстановить настройки,
/// с которыми тест был запущен изначально.
@freezed
sealed class ActiveSessionLaunchParams with _$ActiveSessionLaunchParams {
  const factory ActiveSessionLaunchParams({
    required bool swapSides,
    required int answerIndex,
    required bool mixup,
    required int mixupMin,
    required int mixupMax,
    required MixupAlgorithm algorithm,
  }) = _ActiveSessionLaunchParams;
}
