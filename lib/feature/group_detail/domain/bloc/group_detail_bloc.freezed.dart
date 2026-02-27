// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GroupDetailEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int groupId) started,
    required TResult Function(String title, String? description) testAdded,
    required TResult Function(int testId) testRemoved,
    required TResult Function(String title) titleUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int groupId)? started,
    TResult? Function(String title, String? description)? testAdded,
    TResult? Function(int testId)? testRemoved,
    TResult? Function(String title)? titleUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int groupId)? started,
    TResult Function(String title, String? description)? testAdded,
    TResult Function(int testId)? testRemoved,
    TResult Function(String title)? titleUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GroupDetailEvent$Started value) started,
    required TResult Function(_GroupDetailEvent$TestAdded value) testAdded,
    required TResult Function(_GroupDetailEvent$TestRemoved value) testRemoved,
    required TResult Function(_GroupDetailEvent$TitleUpdated value)
        titleUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupDetailEvent$Started value)? started,
    TResult? Function(_GroupDetailEvent$TestAdded value)? testAdded,
    TResult? Function(_GroupDetailEvent$TestRemoved value)? testRemoved,
    TResult? Function(_GroupDetailEvent$TitleUpdated value)? titleUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupDetailEvent$Started value)? started,
    TResult Function(_GroupDetailEvent$TestAdded value)? testAdded,
    TResult Function(_GroupDetailEvent$TestRemoved value)? testRemoved,
    TResult Function(_GroupDetailEvent$TitleUpdated value)? titleUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupDetailEventCopyWith<$Res> {
  factory $GroupDetailEventCopyWith(
          GroupDetailEvent value, $Res Function(GroupDetailEvent) then) =
      _$GroupDetailEventCopyWithImpl<$Res, GroupDetailEvent>;
}

/// @nodoc
class _$GroupDetailEventCopyWithImpl<$Res, $Val extends GroupDetailEvent>
    implements $GroupDetailEventCopyWith<$Res> {
  _$GroupDetailEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GroupDetailEvent$StartedImplCopyWith<$Res> {
  factory _$$GroupDetailEvent$StartedImplCopyWith(
          _$GroupDetailEvent$StartedImpl value,
          $Res Function(_$GroupDetailEvent$StartedImpl) then) =
      __$$GroupDetailEvent$StartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int groupId});
}

/// @nodoc
class __$$GroupDetailEvent$StartedImplCopyWithImpl<$Res>
    extends _$GroupDetailEventCopyWithImpl<$Res, _$GroupDetailEvent$StartedImpl>
    implements _$$GroupDetailEvent$StartedImplCopyWith<$Res> {
  __$$GroupDetailEvent$StartedImplCopyWithImpl(
      _$GroupDetailEvent$StartedImpl _value,
      $Res Function(_$GroupDetailEvent$StartedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
  }) {
    return _then(_$GroupDetailEvent$StartedImpl(
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GroupDetailEvent$StartedImpl implements _GroupDetailEvent$Started {
  const _$GroupDetailEvent$StartedImpl({required this.groupId});

  @override
  final int groupId;

  @override
  String toString() {
    return 'GroupDetailEvent.started(groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupDetailEvent$StartedImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, groupId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupDetailEvent$StartedImplCopyWith<_$GroupDetailEvent$StartedImpl>
      get copyWith => __$$GroupDetailEvent$StartedImplCopyWithImpl<
          _$GroupDetailEvent$StartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int groupId) started,
    required TResult Function(String title, String? description) testAdded,
    required TResult Function(int testId) testRemoved,
    required TResult Function(String title) titleUpdated,
  }) {
    return started(groupId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int groupId)? started,
    TResult? Function(String title, String? description)? testAdded,
    TResult? Function(int testId)? testRemoved,
    TResult? Function(String title)? titleUpdated,
  }) {
    return started?.call(groupId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int groupId)? started,
    TResult Function(String title, String? description)? testAdded,
    TResult Function(int testId)? testRemoved,
    TResult Function(String title)? titleUpdated,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(groupId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GroupDetailEvent$Started value) started,
    required TResult Function(_GroupDetailEvent$TestAdded value) testAdded,
    required TResult Function(_GroupDetailEvent$TestRemoved value) testRemoved,
    required TResult Function(_GroupDetailEvent$TitleUpdated value)
        titleUpdated,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupDetailEvent$Started value)? started,
    TResult? Function(_GroupDetailEvent$TestAdded value)? testAdded,
    TResult? Function(_GroupDetailEvent$TestRemoved value)? testRemoved,
    TResult? Function(_GroupDetailEvent$TitleUpdated value)? titleUpdated,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupDetailEvent$Started value)? started,
    TResult Function(_GroupDetailEvent$TestAdded value)? testAdded,
    TResult Function(_GroupDetailEvent$TestRemoved value)? testRemoved,
    TResult Function(_GroupDetailEvent$TitleUpdated value)? titleUpdated,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _GroupDetailEvent$Started implements GroupDetailEvent {
  const factory _GroupDetailEvent$Started({required final int groupId}) =
      _$GroupDetailEvent$StartedImpl;

  int get groupId;
  @JsonKey(ignore: true)
  _$$GroupDetailEvent$StartedImplCopyWith<_$GroupDetailEvent$StartedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupDetailEvent$TestAddedImplCopyWith<$Res> {
  factory _$$GroupDetailEvent$TestAddedImplCopyWith(
          _$GroupDetailEvent$TestAddedImpl value,
          $Res Function(_$GroupDetailEvent$TestAddedImpl) then) =
      __$$GroupDetailEvent$TestAddedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title, String? description});
}

/// @nodoc
class __$$GroupDetailEvent$TestAddedImplCopyWithImpl<$Res>
    extends _$GroupDetailEventCopyWithImpl<$Res,
        _$GroupDetailEvent$TestAddedImpl>
    implements _$$GroupDetailEvent$TestAddedImplCopyWith<$Res> {
  __$$GroupDetailEvent$TestAddedImplCopyWithImpl(
      _$GroupDetailEvent$TestAddedImpl _value,
      $Res Function(_$GroupDetailEvent$TestAddedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
  }) {
    return _then(_$GroupDetailEvent$TestAddedImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GroupDetailEvent$TestAddedImpl implements _GroupDetailEvent$TestAdded {
  const _$GroupDetailEvent$TestAddedImpl(
      {required this.title, this.description});

  @override
  final String title;
  @override
  final String? description;

  @override
  String toString() {
    return 'GroupDetailEvent.testAdded(title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupDetailEvent$TestAddedImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupDetailEvent$TestAddedImplCopyWith<_$GroupDetailEvent$TestAddedImpl>
      get copyWith => __$$GroupDetailEvent$TestAddedImplCopyWithImpl<
          _$GroupDetailEvent$TestAddedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int groupId) started,
    required TResult Function(String title, String? description) testAdded,
    required TResult Function(int testId) testRemoved,
    required TResult Function(String title) titleUpdated,
  }) {
    return testAdded(title, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int groupId)? started,
    TResult? Function(String title, String? description)? testAdded,
    TResult? Function(int testId)? testRemoved,
    TResult? Function(String title)? titleUpdated,
  }) {
    return testAdded?.call(title, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int groupId)? started,
    TResult Function(String title, String? description)? testAdded,
    TResult Function(int testId)? testRemoved,
    TResult Function(String title)? titleUpdated,
    required TResult orElse(),
  }) {
    if (testAdded != null) {
      return testAdded(title, description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GroupDetailEvent$Started value) started,
    required TResult Function(_GroupDetailEvent$TestAdded value) testAdded,
    required TResult Function(_GroupDetailEvent$TestRemoved value) testRemoved,
    required TResult Function(_GroupDetailEvent$TitleUpdated value)
        titleUpdated,
  }) {
    return testAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupDetailEvent$Started value)? started,
    TResult? Function(_GroupDetailEvent$TestAdded value)? testAdded,
    TResult? Function(_GroupDetailEvent$TestRemoved value)? testRemoved,
    TResult? Function(_GroupDetailEvent$TitleUpdated value)? titleUpdated,
  }) {
    return testAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupDetailEvent$Started value)? started,
    TResult Function(_GroupDetailEvent$TestAdded value)? testAdded,
    TResult Function(_GroupDetailEvent$TestRemoved value)? testRemoved,
    TResult Function(_GroupDetailEvent$TitleUpdated value)? titleUpdated,
    required TResult orElse(),
  }) {
    if (testAdded != null) {
      return testAdded(this);
    }
    return orElse();
  }
}

abstract class _GroupDetailEvent$TestAdded implements GroupDetailEvent {
  const factory _GroupDetailEvent$TestAdded(
      {required final String title,
      final String? description}) = _$GroupDetailEvent$TestAddedImpl;

  String get title;
  String? get description;
  @JsonKey(ignore: true)
  _$$GroupDetailEvent$TestAddedImplCopyWith<_$GroupDetailEvent$TestAddedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupDetailEvent$TestRemovedImplCopyWith<$Res> {
  factory _$$GroupDetailEvent$TestRemovedImplCopyWith(
          _$GroupDetailEvent$TestRemovedImpl value,
          $Res Function(_$GroupDetailEvent$TestRemovedImpl) then) =
      __$$GroupDetailEvent$TestRemovedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int testId});
}

/// @nodoc
class __$$GroupDetailEvent$TestRemovedImplCopyWithImpl<$Res>
    extends _$GroupDetailEventCopyWithImpl<$Res,
        _$GroupDetailEvent$TestRemovedImpl>
    implements _$$GroupDetailEvent$TestRemovedImplCopyWith<$Res> {
  __$$GroupDetailEvent$TestRemovedImplCopyWithImpl(
      _$GroupDetailEvent$TestRemovedImpl _value,
      $Res Function(_$GroupDetailEvent$TestRemovedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
  }) {
    return _then(_$GroupDetailEvent$TestRemovedImpl(
      testId: null == testId
          ? _value.testId
          : testId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$GroupDetailEvent$TestRemovedImpl
    implements _GroupDetailEvent$TestRemoved {
  const _$GroupDetailEvent$TestRemovedImpl({required this.testId});

  @override
  final int testId;

  @override
  String toString() {
    return 'GroupDetailEvent.testRemoved(testId: $testId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupDetailEvent$TestRemovedImpl &&
            (identical(other.testId, testId) || other.testId == testId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, testId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupDetailEvent$TestRemovedImplCopyWith<
          _$GroupDetailEvent$TestRemovedImpl>
      get copyWith => __$$GroupDetailEvent$TestRemovedImplCopyWithImpl<
          _$GroupDetailEvent$TestRemovedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int groupId) started,
    required TResult Function(String title, String? description) testAdded,
    required TResult Function(int testId) testRemoved,
    required TResult Function(String title) titleUpdated,
  }) {
    return testRemoved(testId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int groupId)? started,
    TResult? Function(String title, String? description)? testAdded,
    TResult? Function(int testId)? testRemoved,
    TResult? Function(String title)? titleUpdated,
  }) {
    return testRemoved?.call(testId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int groupId)? started,
    TResult Function(String title, String? description)? testAdded,
    TResult Function(int testId)? testRemoved,
    TResult Function(String title)? titleUpdated,
    required TResult orElse(),
  }) {
    if (testRemoved != null) {
      return testRemoved(testId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GroupDetailEvent$Started value) started,
    required TResult Function(_GroupDetailEvent$TestAdded value) testAdded,
    required TResult Function(_GroupDetailEvent$TestRemoved value) testRemoved,
    required TResult Function(_GroupDetailEvent$TitleUpdated value)
        titleUpdated,
  }) {
    return testRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupDetailEvent$Started value)? started,
    TResult? Function(_GroupDetailEvent$TestAdded value)? testAdded,
    TResult? Function(_GroupDetailEvent$TestRemoved value)? testRemoved,
    TResult? Function(_GroupDetailEvent$TitleUpdated value)? titleUpdated,
  }) {
    return testRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupDetailEvent$Started value)? started,
    TResult Function(_GroupDetailEvent$TestAdded value)? testAdded,
    TResult Function(_GroupDetailEvent$TestRemoved value)? testRemoved,
    TResult Function(_GroupDetailEvent$TitleUpdated value)? titleUpdated,
    required TResult orElse(),
  }) {
    if (testRemoved != null) {
      return testRemoved(this);
    }
    return orElse();
  }
}

abstract class _GroupDetailEvent$TestRemoved implements GroupDetailEvent {
  const factory _GroupDetailEvent$TestRemoved({required final int testId}) =
      _$GroupDetailEvent$TestRemovedImpl;

  int get testId;
  @JsonKey(ignore: true)
  _$$GroupDetailEvent$TestRemovedImplCopyWith<
          _$GroupDetailEvent$TestRemovedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupDetailEvent$TitleUpdatedImplCopyWith<$Res> {
  factory _$$GroupDetailEvent$TitleUpdatedImplCopyWith(
          _$GroupDetailEvent$TitleUpdatedImpl value,
          $Res Function(_$GroupDetailEvent$TitleUpdatedImpl) then) =
      __$$GroupDetailEvent$TitleUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title});
}

/// @nodoc
class __$$GroupDetailEvent$TitleUpdatedImplCopyWithImpl<$Res>
    extends _$GroupDetailEventCopyWithImpl<$Res,
        _$GroupDetailEvent$TitleUpdatedImpl>
    implements _$$GroupDetailEvent$TitleUpdatedImplCopyWith<$Res> {
  __$$GroupDetailEvent$TitleUpdatedImplCopyWithImpl(
      _$GroupDetailEvent$TitleUpdatedImpl _value,
      $Res Function(_$GroupDetailEvent$TitleUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
  }) {
    return _then(_$GroupDetailEvent$TitleUpdatedImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GroupDetailEvent$TitleUpdatedImpl
    implements _GroupDetailEvent$TitleUpdated {
  const _$GroupDetailEvent$TitleUpdatedImpl({required this.title});

  @override
  final String title;

  @override
  String toString() {
    return 'GroupDetailEvent.titleUpdated(title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupDetailEvent$TitleUpdatedImpl &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupDetailEvent$TitleUpdatedImplCopyWith<
          _$GroupDetailEvent$TitleUpdatedImpl>
      get copyWith => __$$GroupDetailEvent$TitleUpdatedImplCopyWithImpl<
          _$GroupDetailEvent$TitleUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int groupId) started,
    required TResult Function(String title, String? description) testAdded,
    required TResult Function(int testId) testRemoved,
    required TResult Function(String title) titleUpdated,
  }) {
    return titleUpdated(title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int groupId)? started,
    TResult? Function(String title, String? description)? testAdded,
    TResult? Function(int testId)? testRemoved,
    TResult? Function(String title)? titleUpdated,
  }) {
    return titleUpdated?.call(title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int groupId)? started,
    TResult Function(String title, String? description)? testAdded,
    TResult Function(int testId)? testRemoved,
    TResult Function(String title)? titleUpdated,
    required TResult orElse(),
  }) {
    if (titleUpdated != null) {
      return titleUpdated(title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GroupDetailEvent$Started value) started,
    required TResult Function(_GroupDetailEvent$TestAdded value) testAdded,
    required TResult Function(_GroupDetailEvent$TestRemoved value) testRemoved,
    required TResult Function(_GroupDetailEvent$TitleUpdated value)
        titleUpdated,
  }) {
    return titleUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GroupDetailEvent$Started value)? started,
    TResult? Function(_GroupDetailEvent$TestAdded value)? testAdded,
    TResult? Function(_GroupDetailEvent$TestRemoved value)? testRemoved,
    TResult? Function(_GroupDetailEvent$TitleUpdated value)? titleUpdated,
  }) {
    return titleUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GroupDetailEvent$Started value)? started,
    TResult Function(_GroupDetailEvent$TestAdded value)? testAdded,
    TResult Function(_GroupDetailEvent$TestRemoved value)? testRemoved,
    TResult Function(_GroupDetailEvent$TitleUpdated value)? titleUpdated,
    required TResult orElse(),
  }) {
    if (titleUpdated != null) {
      return titleUpdated(this);
    }
    return orElse();
  }
}

abstract class _GroupDetailEvent$TitleUpdated implements GroupDetailEvent {
  const factory _GroupDetailEvent$TitleUpdated({required final String title}) =
      _$GroupDetailEvent$TitleUpdatedImpl;

  String get title;
  @JsonKey(ignore: true)
  _$$GroupDetailEvent$TitleUpdatedImplCopyWith<
          _$GroupDetailEvent$TitleUpdatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GroupDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(TestGroupEntity group, List<TestEntity> tests)
        loaded,
    required TResult Function(Failure failure) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(TestGroupEntity group, List<TestEntity> tests)? loaded,
    TResult? Function(Failure failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(TestGroupEntity group, List<TestEntity> tests)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupDetailState$Loading value) loading,
    required TResult Function(GroupDetailState$Loaded value) loaded,
    required TResult Function(GroupDetailState$Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupDetailState$Loading value)? loading,
    TResult? Function(GroupDetailState$Loaded value)? loaded,
    TResult? Function(GroupDetailState$Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupDetailState$Loading value)? loading,
    TResult Function(GroupDetailState$Loaded value)? loaded,
    TResult Function(GroupDetailState$Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupDetailStateCopyWith<$Res> {
  factory $GroupDetailStateCopyWith(
          GroupDetailState value, $Res Function(GroupDetailState) then) =
      _$GroupDetailStateCopyWithImpl<$Res, GroupDetailState>;
}

/// @nodoc
class _$GroupDetailStateCopyWithImpl<$Res, $Val extends GroupDetailState>
    implements $GroupDetailStateCopyWith<$Res> {
  _$GroupDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$GroupDetailState$LoadingImplCopyWith<$Res> {
  factory _$$GroupDetailState$LoadingImplCopyWith(
          _$GroupDetailState$LoadingImpl value,
          $Res Function(_$GroupDetailState$LoadingImpl) then) =
      __$$GroupDetailState$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GroupDetailState$LoadingImplCopyWithImpl<$Res>
    extends _$GroupDetailStateCopyWithImpl<$Res, _$GroupDetailState$LoadingImpl>
    implements _$$GroupDetailState$LoadingImplCopyWith<$Res> {
  __$$GroupDetailState$LoadingImplCopyWithImpl(
      _$GroupDetailState$LoadingImpl _value,
      $Res Function(_$GroupDetailState$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GroupDetailState$LoadingImpl extends GroupDetailState$Loading {
  const _$GroupDetailState$LoadingImpl() : super._();

  @override
  String toString() {
    return 'GroupDetailState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupDetailState$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(TestGroupEntity group, List<TestEntity> tests)
        loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(TestGroupEntity group, List<TestEntity> tests)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(TestGroupEntity group, List<TestEntity> tests)? loaded,
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
    required TResult Function(GroupDetailState$Loading value) loading,
    required TResult Function(GroupDetailState$Loaded value) loaded,
    required TResult Function(GroupDetailState$Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupDetailState$Loading value)? loading,
    TResult? Function(GroupDetailState$Loaded value)? loaded,
    TResult? Function(GroupDetailState$Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupDetailState$Loading value)? loading,
    TResult Function(GroupDetailState$Loaded value)? loaded,
    TResult Function(GroupDetailState$Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class GroupDetailState$Loading extends GroupDetailState {
  const factory GroupDetailState$Loading() = _$GroupDetailState$LoadingImpl;
  const GroupDetailState$Loading._() : super._();
}

/// @nodoc
abstract class _$$GroupDetailState$LoadedImplCopyWith<$Res> {
  factory _$$GroupDetailState$LoadedImplCopyWith(
          _$GroupDetailState$LoadedImpl value,
          $Res Function(_$GroupDetailState$LoadedImpl) then) =
      __$$GroupDetailState$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TestGroupEntity group, List<TestEntity> tests});

  $TestGroupEntityCopyWith<$Res> get group;
}

/// @nodoc
class __$$GroupDetailState$LoadedImplCopyWithImpl<$Res>
    extends _$GroupDetailStateCopyWithImpl<$Res, _$GroupDetailState$LoadedImpl>
    implements _$$GroupDetailState$LoadedImplCopyWith<$Res> {
  __$$GroupDetailState$LoadedImplCopyWithImpl(
      _$GroupDetailState$LoadedImpl _value,
      $Res Function(_$GroupDetailState$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? tests = null,
  }) {
    return _then(_$GroupDetailState$LoadedImpl(
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as TestGroupEntity,
      tests: null == tests
          ? _value._tests
          : tests // ignore: cast_nullable_to_non_nullable
              as List<TestEntity>,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TestGroupEntityCopyWith<$Res> get group {
    return $TestGroupEntityCopyWith<$Res>(_value.group, (value) {
      return _then(_value.copyWith(group: value));
    });
  }
}

/// @nodoc

class _$GroupDetailState$LoadedImpl extends GroupDetailState$Loaded {
  const _$GroupDetailState$LoadedImpl(
      {required this.group, required final List<TestEntity> tests})
      : _tests = tests,
        super._();

  @override
  final TestGroupEntity group;
  final List<TestEntity> _tests;
  @override
  List<TestEntity> get tests {
    if (_tests is EqualUnmodifiableListView) return _tests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tests);
  }

  @override
  String toString() {
    return 'GroupDetailState.loaded(group: $group, tests: $tests)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupDetailState$LoadedImpl &&
            (identical(other.group, group) || other.group == group) &&
            const DeepCollectionEquality().equals(other._tests, _tests));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, group, const DeepCollectionEquality().hash(_tests));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupDetailState$LoadedImplCopyWith<_$GroupDetailState$LoadedImpl>
      get copyWith => __$$GroupDetailState$LoadedImplCopyWithImpl<
          _$GroupDetailState$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(TestGroupEntity group, List<TestEntity> tests)
        loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loaded(group, tests);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(TestGroupEntity group, List<TestEntity> tests)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loaded?.call(group, tests);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(TestGroupEntity group, List<TestEntity> tests)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(group, tests);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GroupDetailState$Loading value) loading,
    required TResult Function(GroupDetailState$Loaded value) loaded,
    required TResult Function(GroupDetailState$Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupDetailState$Loading value)? loading,
    TResult? Function(GroupDetailState$Loaded value)? loaded,
    TResult? Function(GroupDetailState$Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupDetailState$Loading value)? loading,
    TResult Function(GroupDetailState$Loaded value)? loaded,
    TResult Function(GroupDetailState$Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class GroupDetailState$Loaded extends GroupDetailState {
  const factory GroupDetailState$Loaded(
      {required final TestGroupEntity group,
      required final List<TestEntity> tests}) = _$GroupDetailState$LoadedImpl;
  const GroupDetailState$Loaded._() : super._();

  TestGroupEntity get group;
  List<TestEntity> get tests;
  @JsonKey(ignore: true)
  _$$GroupDetailState$LoadedImplCopyWith<_$GroupDetailState$LoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GroupDetailState$ErrorImplCopyWith<$Res> {
  factory _$$GroupDetailState$ErrorImplCopyWith(
          _$GroupDetailState$ErrorImpl value,
          $Res Function(_$GroupDetailState$ErrorImpl) then) =
      __$$GroupDetailState$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});
}

/// @nodoc
class __$$GroupDetailState$ErrorImplCopyWithImpl<$Res>
    extends _$GroupDetailStateCopyWithImpl<$Res, _$GroupDetailState$ErrorImpl>
    implements _$$GroupDetailState$ErrorImplCopyWith<$Res> {
  __$$GroupDetailState$ErrorImplCopyWithImpl(
      _$GroupDetailState$ErrorImpl _value,
      $Res Function(_$GroupDetailState$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$GroupDetailState$ErrorImpl(
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

/// @nodoc

class _$GroupDetailState$ErrorImpl extends GroupDetailState$Error {
  const _$GroupDetailState$ErrorImpl({required this.failure}) : super._();

  @override
  final Failure failure;

  @override
  String toString() {
    return 'GroupDetailState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupDetailState$ErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupDetailState$ErrorImplCopyWith<_$GroupDetailState$ErrorImpl>
      get copyWith => __$$GroupDetailState$ErrorImplCopyWithImpl<
          _$GroupDetailState$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(TestGroupEntity group, List<TestEntity> tests)
        loaded,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(TestGroupEntity group, List<TestEntity> tests)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(TestGroupEntity group, List<TestEntity> tests)? loaded,
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
    required TResult Function(GroupDetailState$Loading value) loading,
    required TResult Function(GroupDetailState$Loaded value) loaded,
    required TResult Function(GroupDetailState$Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GroupDetailState$Loading value)? loading,
    TResult? Function(GroupDetailState$Loaded value)? loaded,
    TResult? Function(GroupDetailState$Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GroupDetailState$Loading value)? loading,
    TResult Function(GroupDetailState$Loaded value)? loaded,
    TResult Function(GroupDetailState$Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class GroupDetailState$Error extends GroupDetailState {
  const factory GroupDetailState$Error({required final Failure failure}) =
      _$GroupDetailState$ErrorImpl;
  const GroupDetailState$Error._() : super._();

  Failure get failure;
  @JsonKey(ignore: true)
  _$$GroupDetailState$ErrorImplCopyWith<_$GroupDetailState$ErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
