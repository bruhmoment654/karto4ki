// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'groups_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GroupsListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title) groupAdded,
    required TResult Function(int groupId) groupDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title)? groupAdded,
    TResult? Function(int groupId)? groupDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title)? groupAdded,
    TResult Function(int groupId)? groupDeleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GroupsListEvent$Started value) started,
    required TResult Function(_GroupsListEvent$GroupAdded value) groupAdded,
    required TResult Function(_GroupsListEvent$GroupDeleted value) groupDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupsListEvent$Started value)? started,
    TResult? Function(_GroupsListEvent$GroupAdded value)? groupAdded,
    TResult? Function(_GroupsListEvent$GroupDeleted value)? groupDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupsListEvent$Started value)? started,
    TResult Function(_GroupsListEvent$GroupAdded value)? groupAdded,
    TResult Function(_GroupsListEvent$GroupDeleted value)? groupDeleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupsListEventCopyWith<$Res> {
  factory $GroupsListEventCopyWith(
          GroupsListEvent value, $Res Function(GroupsListEvent) then) =
      _$GroupsListEventCopyWithImpl<$Res, GroupsListEvent>;
}

/// @nodoc
class _$GroupsListEventCopyWithImpl<$Res, $Val extends GroupsListEvent>
    implements $GroupsListEventCopyWith<$Res> {
  _$GroupsListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GroupsListEvent$StartedImplCopyWith<$Res> {
  factory _$$GroupsListEvent$StartedImplCopyWith(
          _$GroupsListEvent$StartedImpl value,
          $Res Function(_$GroupsListEvent$StartedImpl) then) =
      __$$GroupsListEvent$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GroupsListEvent$StartedImplCopyWithImpl<$Res>
    extends _$GroupsListEventCopyWithImpl<$Res, _$GroupsListEvent$StartedImpl>
    implements _$$GroupsListEvent$StartedImplCopyWith<$Res> {
  __$$GroupsListEvent$StartedImplCopyWithImpl(
      _$GroupsListEvent$StartedImpl _value,
      $Res Function(_$GroupsListEvent$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GroupsListEvent$StartedImpl implements _GroupsListEvent$Started {
  const _$GroupsListEvent$StartedImpl();

  @override
  String toString() {
    return 'GroupsListEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupsListEvent$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title) groupAdded,
    required TResult Function(int groupId) groupDeleted,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title)? groupAdded,
    TResult? Function(int groupId)? groupDeleted,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title)? groupAdded,
    TResult Function(int groupId)? groupDeleted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GroupsListEvent$Started value) started,
    required TResult Function(_GroupsListEvent$GroupAdded value) groupAdded,
    required TResult Function(_GroupsListEvent$GroupDeleted value) groupDeleted,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupsListEvent$Started value)? started,
    TResult? Function(_GroupsListEvent$GroupAdded value)? groupAdded,
    TResult? Function(_GroupsListEvent$GroupDeleted value)? groupDeleted,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupsListEvent$Started value)? started,
    TResult Function(_GroupsListEvent$GroupAdded value)? groupAdded,
    TResult Function(_GroupsListEvent$GroupDeleted value)? groupDeleted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _GroupsListEvent$Started implements GroupsListEvent {
  const factory _GroupsListEvent$Started() = _$GroupsListEvent$StartedImpl;
}

/// @nodoc
abstract class _$$GroupsListEvent$GroupAddedImplCopyWith<$Res> {
  factory _$$GroupsListEvent$GroupAddedImplCopyWith(
          _$GroupsListEvent$GroupAddedImpl value,
          $Res Function(_$GroupsListEvent$GroupAddedImpl) then) =
      __$$GroupsListEvent$GroupAddedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title});
}

/// @nodoc
class __$$GroupsListEvent$GroupAddedImplCopyWithImpl<$Res>
    extends _$GroupsListEventCopyWithImpl<$Res,
        _$GroupsListEvent$GroupAddedImpl>
    implements _$$GroupsListEvent$GroupAddedImplCopyWith<$Res> {
  __$$GroupsListEvent$GroupAddedImplCopyWithImpl(
      _$GroupsListEvent$GroupAddedImpl _value,
      $Res Function(_$GroupsListEvent$GroupAddedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
  }) {
    return _then(_$GroupsListEvent$GroupAddedImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GroupsListEvent$GroupAddedImpl implements _GroupsListEvent$GroupAdded {
  const _$GroupsListEvent$GroupAddedImpl({required this.title});

  @override
  final String title;

  @override
  String toString() {
    return 'GroupsListEvent.groupAdded(title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupsListEvent$GroupAddedImpl &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupsListEvent$GroupAddedImplCopyWith<_$GroupsListEvent$GroupAddedImpl>
      get copyWith => __$$GroupsListEvent$GroupAddedImplCopyWithImpl<
          _$GroupsListEvent$GroupAddedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title) groupAdded,
    required TResult Function(int groupId) groupDeleted,
  }) {
    return groupAdded(title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title)? groupAdded,
    TResult? Function(int groupId)? groupDeleted,
  }) {
    return groupAdded?.call(title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title)? groupAdded,
    TResult Function(int groupId)? groupDeleted,
    required TResult orElse(),
  }) {
    if (groupAdded != null) {
      return groupAdded(title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GroupsListEvent$Started value) started,
    required TResult Function(_GroupsListEvent$GroupAdded value) groupAdded,
    required TResult Function(_GroupsListEvent$GroupDeleted value) groupDeleted,
  }) {
    return groupAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupsListEvent$Started value)? started,
    TResult? Function(_GroupsListEvent$GroupAdded value)? groupAdded,
    TResult? Function(_GroupsListEvent$GroupDeleted value)? groupDeleted,
  }) {
    return groupAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupsListEvent$Started value)? started,
    TResult Function(_GroupsListEvent$GroupAdded value)? groupAdded,
    TResult Function(_GroupsListEvent$GroupDeleted value)? groupDeleted,
    required TResult orElse(),
  }) {
    if (groupAdded != null) {
      return groupAdded(this);
    }
    return orElse();
  }
}

abstract class _GroupsListEvent$GroupAdded implements GroupsListEvent {
  const factory _GroupsListEvent$GroupAdded({required final String title}) =
      _$GroupsListEvent$GroupAddedImpl;

  String get title;
  @JsonKey(ignore: true)
  _$$GroupsListEvent$GroupAddedImplCopyWith<_$GroupsListEvent$GroupAddedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupsListEvent$GroupDeletedImplCopyWith<$Res> {
  factory _$$GroupsListEvent$GroupDeletedImplCopyWith(
          _$GroupsListEvent$GroupDeletedImpl value,
          $Res Function(_$GroupsListEvent$GroupDeletedImpl) then) =
      __$$GroupsListEvent$GroupDeletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int groupId});
}

/// @nodoc
class __$$GroupsListEvent$GroupDeletedImplCopyWithImpl<$Res>
    extends _$GroupsListEventCopyWithImpl<$Res,
        _$GroupsListEvent$GroupDeletedImpl>
    implements _$$GroupsListEvent$GroupDeletedImplCopyWith<$Res> {
  __$$GroupsListEvent$GroupDeletedImplCopyWithImpl(
      _$GroupsListEvent$GroupDeletedImpl _value,
      $Res Function(_$GroupsListEvent$GroupDeletedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
  }) {
    return _then(_$GroupsListEvent$GroupDeletedImpl(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GroupsListEvent$GroupDeletedImpl
    implements _GroupsListEvent$GroupDeleted {
  const _$GroupsListEvent$GroupDeletedImpl({required this.groupId});

  @override
  final int groupId;

  @override
  String toString() {
    return 'GroupsListEvent.groupDeleted(groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupsListEvent$GroupDeletedImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupsListEvent$GroupDeletedImplCopyWith<
          _$GroupsListEvent$GroupDeletedImpl>
      get copyWith => __$$GroupsListEvent$GroupDeletedImplCopyWithImpl<
          _$GroupsListEvent$GroupDeletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title) groupAdded,
    required TResult Function(int groupId) groupDeleted,
  }) {
    return groupDeleted(groupId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title)? groupAdded,
    TResult? Function(int groupId)? groupDeleted,
  }) {
    return groupDeleted?.call(groupId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title)? groupAdded,
    TResult Function(int groupId)? groupDeleted,
    required TResult orElse(),
  }) {
    if (groupDeleted != null) {
      return groupDeleted(groupId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GroupsListEvent$Started value) started,
    required TResult Function(_GroupsListEvent$GroupAdded value) groupAdded,
    required TResult Function(_GroupsListEvent$GroupDeleted value) groupDeleted,
  }) {
    return groupDeleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupsListEvent$Started value)? started,
    TResult? Function(_GroupsListEvent$GroupAdded value)? groupAdded,
    TResult? Function(_GroupsListEvent$GroupDeleted value)? groupDeleted,
  }) {
    return groupDeleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupsListEvent$Started value)? started,
    TResult Function(_GroupsListEvent$GroupAdded value)? groupAdded,
    TResult Function(_GroupsListEvent$GroupDeleted value)? groupDeleted,
    required TResult orElse(),
  }) {
    if (groupDeleted != null) {
      return groupDeleted(this);
    }
    return orElse();
  }
}

abstract class _GroupsListEvent$GroupDeleted implements GroupsListEvent {
  const factory _GroupsListEvent$GroupDeleted({required final int groupId}) =
      _$GroupsListEvent$GroupDeletedImpl;

  int get groupId;
  @JsonKey(ignore: true)
  _$$GroupsListEvent$GroupDeletedImplCopyWith<
          _$GroupsListEvent$GroupDeletedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GroupsListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestGroupEntity> groups) loaded,
    required TResult Function(Failure failure) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestGroupEntity> groups)? loaded,
    TResult? Function(Failure failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestGroupEntity> groups)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupsListState$Loading value) loading,
    required TResult Function(GroupsListState$Loaded value) loaded,
    required TResult Function(GroupsListState$Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupsListState$Loading value)? loading,
    TResult? Function(GroupsListState$Loaded value)? loaded,
    TResult? Function(GroupsListState$Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupsListState$Loading value)? loading,
    TResult Function(GroupsListState$Loaded value)? loaded,
    TResult Function(GroupsListState$Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupsListStateCopyWith<$Res> {
  factory $GroupsListStateCopyWith(
          GroupsListState value, $Res Function(GroupsListState) then) =
      _$GroupsListStateCopyWithImpl<$Res, GroupsListState>;
}

/// @nodoc
class _$GroupsListStateCopyWithImpl<$Res, $Val extends GroupsListState>
    implements $GroupsListStateCopyWith<$Res> {
  _$GroupsListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GroupsListState$LoadingImplCopyWith<$Res> {
  factory _$$GroupsListState$LoadingImplCopyWith(
          _$GroupsListState$LoadingImpl value,
          $Res Function(_$GroupsListState$LoadingImpl) then) =
      __$$GroupsListState$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GroupsListState$LoadingImplCopyWithImpl<$Res>
    extends _$GroupsListStateCopyWithImpl<$Res, _$GroupsListState$LoadingImpl>
    implements _$$GroupsListState$LoadingImplCopyWith<$Res> {
  __$$GroupsListState$LoadingImplCopyWithImpl(
      _$GroupsListState$LoadingImpl _value,
      $Res Function(_$GroupsListState$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GroupsListState$LoadingImpl extends GroupsListState$Loading {
  const _$GroupsListState$LoadingImpl() : super._();

  @override
  String toString() {
    return 'GroupsListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupsListState$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestGroupEntity> groups) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestGroupEntity> groups)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestGroupEntity> groups)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupsListState$Loading value) loading,
    required TResult Function(GroupsListState$Loaded value) loaded,
    required TResult Function(GroupsListState$Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupsListState$Loading value)? loading,
    TResult? Function(GroupsListState$Loaded value)? loaded,
    TResult? Function(GroupsListState$Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupsListState$Loading value)? loading,
    TResult Function(GroupsListState$Loaded value)? loaded,
    TResult Function(GroupsListState$Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class GroupsListState$Loading extends GroupsListState {
  const factory GroupsListState$Loading() = _$GroupsListState$LoadingImpl;
  const GroupsListState$Loading._() : super._();
}

/// @nodoc
abstract class _$$GroupsListState$LoadedImplCopyWith<$Res> {
  factory _$$GroupsListState$LoadedImplCopyWith(
          _$GroupsListState$LoadedImpl value,
          $Res Function(_$GroupsListState$LoadedImpl) then) =
      __$$GroupsListState$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TestGroupEntity> groups});
}

/// @nodoc
class __$$GroupsListState$LoadedImplCopyWithImpl<$Res>
    extends _$GroupsListStateCopyWithImpl<$Res, _$GroupsListState$LoadedImpl>
    implements _$$GroupsListState$LoadedImplCopyWith<$Res> {
  __$$GroupsListState$LoadedImplCopyWithImpl(
      _$GroupsListState$LoadedImpl _value,
      $Res Function(_$GroupsListState$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groups = null,
  }) {
    return _then(_$GroupsListState$LoadedImpl(
      groups: null == groups
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<TestGroupEntity>,
    ));
  }
}

/// @nodoc

class _$GroupsListState$LoadedImpl extends GroupsListState$Loaded {
  const _$GroupsListState$LoadedImpl(
      {required final List<TestGroupEntity> groups})
      : _groups = groups,
        super._();

  final List<TestGroupEntity> _groups;
  @override
  List<TestGroupEntity> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  @override
  String toString() {
    return 'GroupsListState.loaded(groups: $groups)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupsListState$LoadedImpl &&
            const DeepCollectionEquality().equals(other._groups, _groups));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_groups));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupsListState$LoadedImplCopyWith<_$GroupsListState$LoadedImpl>
      get copyWith => __$$GroupsListState$LoadedImplCopyWithImpl<
          _$GroupsListState$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestGroupEntity> groups) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loaded(groups);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestGroupEntity> groups)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loaded?.call(groups);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestGroupEntity> groups)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(groups);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupsListState$Loading value) loading,
    required TResult Function(GroupsListState$Loaded value) loaded,
    required TResult Function(GroupsListState$Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupsListState$Loading value)? loading,
    TResult? Function(GroupsListState$Loaded value)? loaded,
    TResult? Function(GroupsListState$Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupsListState$Loading value)? loading,
    TResult Function(GroupsListState$Loaded value)? loaded,
    TResult Function(GroupsListState$Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class GroupsListState$Loaded extends GroupsListState {
  const factory GroupsListState$Loaded(
          {required final List<TestGroupEntity> groups}) =
      _$GroupsListState$LoadedImpl;
  const GroupsListState$Loaded._() : super._();

  List<TestGroupEntity> get groups;
  @JsonKey(ignore: true)
  _$$GroupsListState$LoadedImplCopyWith<_$GroupsListState$LoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupsListState$ErrorImplCopyWith<$Res> {
  factory _$$GroupsListState$ErrorImplCopyWith(
          _$GroupsListState$ErrorImpl value,
          $Res Function(_$GroupsListState$ErrorImpl) then) =
      __$$GroupsListState$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});
}

/// @nodoc
class __$$GroupsListState$ErrorImplCopyWithImpl<$Res>
    extends _$GroupsListStateCopyWithImpl<$Res, _$GroupsListState$ErrorImpl>
    implements _$$GroupsListState$ErrorImplCopyWith<$Res> {
  __$$GroupsListState$ErrorImplCopyWithImpl(_$GroupsListState$ErrorImpl _value,
      $Res Function(_$GroupsListState$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$GroupsListState$ErrorImpl(
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

/// @nodoc

class _$GroupsListState$ErrorImpl extends GroupsListState$Error {
  const _$GroupsListState$ErrorImpl({required this.failure}) : super._();

  @override
  final Failure failure;

  @override
  String toString() {
    return 'GroupsListState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupsListState$ErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupsListState$ErrorImplCopyWith<_$GroupsListState$ErrorImpl>
      get copyWith => __$$GroupsListState$ErrorImplCopyWithImpl<
          _$GroupsListState$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestGroupEntity> groups) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestGroupEntity> groups)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestGroupEntity> groups)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupsListState$Loading value) loading,
    required TResult Function(GroupsListState$Loaded value) loaded,
    required TResult Function(GroupsListState$Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupsListState$Loading value)? loading,
    TResult? Function(GroupsListState$Loaded value)? loaded,
    TResult? Function(GroupsListState$Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupsListState$Loading value)? loading,
    TResult Function(GroupsListState$Loaded value)? loaded,
    TResult Function(GroupsListState$Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class GroupsListState$Error extends GroupsListState {
  const factory GroupsListState$Error({required final Failure failure}) =
      _$GroupsListState$ErrorImpl;
  const GroupsListState$Error._() : super._();

  Failure get failure;
  @JsonKey(ignore: true)
  _$$GroupsListState$ErrorImplCopyWith<_$GroupsListState$ErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
