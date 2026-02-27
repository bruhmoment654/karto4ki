part of 'group_detail_bloc.dart';

/// События экрана деталки группы.
@freezed
sealed class GroupDetailEvent with _$GroupDetailEvent {
  /// Загрузить данные группы.
  const factory GroupDetailEvent.started({
    required int groupId,
  }) = _GroupDetailEvent$Started;

  /// Добавить тест в группу.
  const factory GroupDetailEvent.testAdded({
    required String title,
    String? description,
  }) = _GroupDetailEvent$TestAdded;

  /// Убрать тест из группы.
  const factory GroupDetailEvent.testRemoved({
    required int testId,
  }) = _GroupDetailEvent$TestRemoved;

  /// Обновить название группы.
  const factory GroupDetailEvent.titleUpdated({
    required String title,
  }) = _GroupDetailEvent$TitleUpdated;
}
