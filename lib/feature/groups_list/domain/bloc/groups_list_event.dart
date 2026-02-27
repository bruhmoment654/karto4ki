part of 'groups_list_bloc.dart';

/// События экрана списка групп.
@freezed
sealed class GroupsListEvent with _$GroupsListEvent {
  /// Загрузить список групп.
  const factory GroupsListEvent.started() = _GroupsListEvent$Started;

  /// Добавить новую группу.
  const factory GroupsListEvent.groupAdded({
    required String title,
  }) = _GroupsListEvent$GroupAdded;

  /// Удалить группу.
  const factory GroupsListEvent.groupDeleted({
    required int groupId,
  }) = _GroupsListEvent$GroupDeleted;
}
