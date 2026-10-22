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

  /// Переименовать группу.
  const factory GroupsListEvent.groupRenamed({
    required String groupId,
    required String title,
  }) = _GroupsListEvent$GroupRenamed;

  /// Удалить группу.
  const factory GroupsListEvent.groupDeleted({
    required String groupId,
  }) = _GroupsListEvent$GroupDeleted;
}
