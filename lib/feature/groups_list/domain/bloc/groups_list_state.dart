part of 'groups_list_bloc.dart';

/// Состояние экрана списка групп.
@freezed
sealed class GroupsListState with _$GroupsListState {
  const GroupsListState._();

  /// Начальное состояние загрузки.
  const factory GroupsListState.loading() = GroupsListState$Loading;

  /// Группы загружены.
  const factory GroupsListState.loaded({
    required List<TestGroupEntity> groups,
  }) = GroupsListState$Loaded;

  /// Ошибка.
  const factory GroupsListState.error({
    required Failure failure,
  }) = GroupsListState$Error;

  /// Получить список групп или пустой список.
  List<TestGroupEntity> get groupsOrEmpty => switch (this) {
        GroupsListState$Loaded(:final groups) => groups,
        _ => [],
      };
}
