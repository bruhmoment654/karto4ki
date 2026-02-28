import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/core/feature/core/exension/string_title_x.dart';
import 'package:quizzerg/core/feature/core/failure.dart';
import 'package:quizzerg/core/feature/core/failures/unknown_failure.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/groups_list/domain/repository/i_groups_list_repository.dart';

part 'groups_list_event.dart';
part 'groups_list_state.dart';
part 'groups_list_bloc.freezed.dart';

/// BLoC для экрана списка групп.
final class GroupsListBloc extends Bloc<GroupsListEvent, GroupsListState> {
  final IGroupsListRepository _repository;
  StreamSubscription<void>? _changesSubscription;

  GroupsListBloc({required IGroupsListRepository repository})
      : _repository = repository,
        super(const GroupsListState.loading()) {
    on<GroupsListEvent>(
      (event, emit) => switch (event) {
        _GroupsListEvent$Started() => _onStarted(event, emit),
        _GroupsListEvent$GroupAdded() => _onGroupAdded(event, emit),
        _GroupsListEvent$GroupDeleted() => _onGroupDeleted(event, emit),
      },
    );

    _changesSubscription = _repository.groupChanges
        .skip(1)
        .debounceTime(const Duration(milliseconds: 300))
        .listen((_) => add(const GroupsListEvent.started()));
  }

  Future<void> _onStarted(
    _GroupsListEvent$Started event,
    Emitter<GroupsListState> emit,
  ) async {
    if (state is! GroupsListState$Loaded) {
      emit(const GroupsListState.loading());
    }

    final result = await _repository.getGroups();
    switch (result) {
      case ResultOk(:final data):
        emit(GroupsListState.loaded(groups: data));
      case ResultFailed(:final error, :final stackTrace):
        emit(GroupsListState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onGroupAdded(
    _GroupsListEvent$GroupAdded event,
    Emitter<GroupsListState> emit,
  ) async {
    final addResult = await _repository.addGroup(
      title: event.title.toCapitalized,
    );
    switch (addResult) {
      case ResultOk():
        final groupsResult = await _repository.getGroups();
        switch (groupsResult) {
          case ResultOk(:final data):
            emit(GroupsListState.loaded(groups: data));
          case ResultFailed(:final error, :final stackTrace):
            emit(GroupsListState.error(
              failure: UnknownFailure.fromException(error, stackTrace),
            ));
        }
      case ResultFailed(:final error, :final stackTrace):
        emit(GroupsListState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onGroupDeleted(
    _GroupsListEvent$GroupDeleted event,
    Emitter<GroupsListState> emit,
  ) async {
    final deleteResult = await _repository.deleteGroup(event.groupId);
    switch (deleteResult) {
      case ResultOk():
        final groupsResult = await _repository.getGroups();
        switch (groupsResult) {
          case ResultOk(:final data):
            emit(GroupsListState.loaded(groups: data));
          case ResultFailed(:final error, :final stackTrace):
            emit(GroupsListState.error(
              failure: UnknownFailure.fromException(error, stackTrace),
            ));
        }
      case ResultFailed(:final error, :final stackTrace):
        emit(GroupsListState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  @override
  Future<void> close() {
    _changesSubscription?.cancel();
    return super.close();
  }
}
