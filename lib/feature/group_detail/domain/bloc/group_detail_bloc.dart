import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quizzerg/core/feature/core/entity/result.dart';
import 'package:quizzerg/core/feature/core/exension/string_title_x.dart';
import 'package:quizzerg/core/feature/core/failure.dart';
import 'package:quizzerg/core/feature/core/failures/not_found_failure.dart';
import 'package:quizzerg/core/feature/core/failures/unknown_failure.dart';
import 'package:quizzerg/feature/group_detail/domain/repository/i_group_detail_repository.dart';
import 'package:quizzerg/feature/groups_list/domain/entity/test_group_entity.dart';
import 'package:quizzerg/feature/tests_list/domain/entity/test_entity.dart';

part 'group_detail_event.dart';
part 'group_detail_state.dart';
part 'group_detail_bloc.freezed.dart';

/// BLoC для экрана деталки группы.
final class GroupDetailBloc extends Bloc<GroupDetailEvent, GroupDetailState> {
  final IGroupDetailRepository _repository;
  int? _currentGroupId;

  GroupDetailBloc({required IGroupDetailRepository repository})
      : _repository = repository,
        super(const GroupDetailState.loading()) {
    on<GroupDetailEvent>(
      (event, emit) => switch (event) {
        _GroupDetailEvent$Started() => _onStarted(event, emit),
        _GroupDetailEvent$TestAdded() => _onTestAdded(event, emit),
        _GroupDetailEvent$TestRemoved() => _onTestRemoved(event, emit),
        _GroupDetailEvent$TitleUpdated() => _onTitleUpdated(event, emit),
      },
    );
  }

  Future<void> _onStarted(
    _GroupDetailEvent$Started event,
    Emitter<GroupDetailState> emit,
  ) async {
    emit(const GroupDetailState.loading());
    _currentGroupId = event.groupId;

    await _reloadData(emit);
  }

  Future<void> _onTestAdded(
    _GroupDetailEvent$TestAdded event,
    Emitter<GroupDetailState> emit,
  ) async {
    final groupId = _currentGroupId;
    if (groupId == null) return;

    final result = await _repository.addTestToGroup(
      groupId: groupId,
      title: event.title.toCapitalized,
      description: event.description?.toCapitalized,
    );
    switch (result) {
      case ResultOk():
        await _reloadData(emit);
      case ResultFailed(:final error, :final stackTrace):
        emit(GroupDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onTestRemoved(
    _GroupDetailEvent$TestRemoved event,
    Emitter<GroupDetailState> emit,
  ) async {
    final groupId = _currentGroupId;
    if (groupId == null) return;

    final result = await _repository.removeTestFromGroup(
      groupId: groupId,
      testId: event.testId,
    );
    switch (result) {
      case ResultOk():
        await _reloadData(emit);
      case ResultFailed(:final error, :final stackTrace):
        emit(GroupDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _onTitleUpdated(
    _GroupDetailEvent$TitleUpdated event,
    Emitter<GroupDetailState> emit,
  ) async {
    final groupId = _currentGroupId;
    if (groupId == null) return;

    final result = await _repository.updateGroupTitle(
      groupId: groupId,
      title: event.title.toCapitalized,
    );
    switch (result) {
      case ResultOk():
        await _reloadData(emit);
      case ResultFailed(:final error, :final stackTrace):
        emit(GroupDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }

  Future<void> _reloadData(Emitter<GroupDetailState> emit) async {
    final groupId = _currentGroupId;
    if (groupId == null) return;

    final groupResult = await _repository.getGroupById(groupId);
    switch (groupResult) {
      case ResultOk(:final data):
        if (data == null) {
          emit(const GroupDetailState.error(
            failure: NotFoundFailure(entityName: 'Group'),
          ));
          return;
        }

        final testsResult = await _repository.getTestsByGroupId(groupId);
        switch (testsResult) {
          case ResultOk(:final data):
            emit(GroupDetailState.loaded(
              group: groupResult.dataOrNull!,
              tests: data,
            ));
          case ResultFailed(:final error, :final stackTrace):
            emit(GroupDetailState.error(
              failure: UnknownFailure.fromException(error, stackTrace),
            ));
        }
      case ResultFailed(:final error, :final stackTrace):
        emit(GroupDetailState.error(
          failure: UnknownFailure.fromException(error, stackTrace),
        ));
    }
  }
}
