import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/feature/test_execution/domain/entity/active_session_launch_params.dart';
import 'package:quizzerg/feature/tinder_test/domain/entity/test_session.dart';

part 'active_test_session.freezed.dart';

/// Активная (последняя) сессия теста, сохранённая в персистентное хранилище.
///
/// Используется для возобновления прохождения теста после
/// перезапуска приложения.
@freezed
sealed class ActiveTestSession with _$ActiveTestSession {
  const factory ActiveTestSession({
    /// Прогресс прохождения и карточки.
    required TestSession session,

    /// Параметры, с которыми тест был запущен.
    required ActiveSessionLaunchParams params,

    /// Название теста — для отображения в карточке «Продолжить».
    required String testTitle,

    /// Момент последнего сохранения.
    required DateTime updatedAt,
  }) = _ActiveTestSession;
}
