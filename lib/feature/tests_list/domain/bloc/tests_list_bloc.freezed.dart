// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tests_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TestsListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title, String? description) testAdded,
    required TResult Function(int testId) testDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title, String? description)? testAdded,
    TResult? Function(int testId)? testDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title, String? description)? testAdded,
    TResult Function(int testId)? testDeleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TestsListEvent$Started value) started,
    required TResult Function(_TestsListEvent$TestAdded value) testAdded,
    required TResult Function(_TestsListEvent$TestDeleted value) testDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestsListEvent$Started value)? started,
    TResult? Function(_TestsListEvent$TestAdded value)? testAdded,
    TResult? Function(_TestsListEvent$TestDeleted value)? testDeleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestsListEvent$Started value)? started,
    TResult Function(_TestsListEvent$TestAdded value)? testAdded,
    TResult Function(_TestsListEvent$TestDeleted value)? testDeleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestsListEventCopyWith<$Res> {
  factory $TestsListEventCopyWith(
          TestsListEvent value, $Res Function(TestsListEvent) then) =
      _$TestsListEventCopyWithImpl<$Res, TestsListEvent>;
}

/// @nodoc
class _$TestsListEventCopyWithImpl<$Res, $Val extends TestsListEvent>
    implements $TestsListEventCopyWith<$Res> {
  _$TestsListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TestsListEvent$StartedImplCopyWith<$Res> {
  factory _$$TestsListEvent$StartedImplCopyWith(
          _$TestsListEvent$StartedImpl value,
          $Res Function(_$TestsListEvent$StartedImpl) then) =
      __$$TestsListEvent$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TestsListEvent$StartedImplCopyWithImpl<$Res>
    extends _$TestsListEventCopyWithImpl<$Res, _$TestsListEvent$StartedImpl>
    implements _$$TestsListEvent$StartedImplCopyWith<$Res> {
  __$$TestsListEvent$StartedImplCopyWithImpl(
      _$TestsListEvent$StartedImpl _value,
      $Res Function(_$TestsListEvent$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TestsListEvent$StartedImpl implements _TestsListEvent$Started {
  const _$TestsListEvent$StartedImpl();

  @override
  String toString() {
    return 'TestsListEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestsListEvent$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title, String? description) testAdded,
    required TResult Function(int testId) testDeleted,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title, String? description)? testAdded,
    TResult? Function(int testId)? testDeleted,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title, String? description)? testAdded,
    TResult Function(int testId)? testDeleted,
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
    required TResult Function(_TestsListEvent$Started value) started,
    required TResult Function(_TestsListEvent$TestAdded value) testAdded,
    required TResult Function(_TestsListEvent$TestDeleted value) testDeleted,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestsListEvent$Started value)? started,
    TResult? Function(_TestsListEvent$TestAdded value)? testAdded,
    TResult? Function(_TestsListEvent$TestDeleted value)? testDeleted,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestsListEvent$Started value)? started,
    TResult Function(_TestsListEvent$TestAdded value)? testAdded,
    TResult Function(_TestsListEvent$TestDeleted value)? testDeleted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _TestsListEvent$Started implements TestsListEvent {
  const factory _TestsListEvent$Started() = _$TestsListEvent$StartedImpl;
}

/// @nodoc
abstract class _$$TestsListEvent$TestAddedImplCopyWith<$Res> {
  factory _$$TestsListEvent$TestAddedImplCopyWith(
          _$TestsListEvent$TestAddedImpl value,
          $Res Function(_$TestsListEvent$TestAddedImpl) then) =
      __$$TestsListEvent$TestAddedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title, String? description});
}

/// @nodoc
class __$$TestsListEvent$TestAddedImplCopyWithImpl<$Res>
    extends _$TestsListEventCopyWithImpl<$Res, _$TestsListEvent$TestAddedImpl>
    implements _$$TestsListEvent$TestAddedImplCopyWith<$Res> {
  __$$TestsListEvent$TestAddedImplCopyWithImpl(
      _$TestsListEvent$TestAddedImpl _value,
      $Res Function(_$TestsListEvent$TestAddedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
  }) {
    return _then(_$TestsListEvent$TestAddedImpl(
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

class _$TestsListEvent$TestAddedImpl implements _TestsListEvent$TestAdded {
  const _$TestsListEvent$TestAddedImpl({required this.title, this.description});

  @override
  final String title;
  @override
  final String? description;

  @override
  String toString() {
    return 'TestsListEvent.testAdded(title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestsListEvent$TestAddedImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestsListEvent$TestAddedImplCopyWith<_$TestsListEvent$TestAddedImpl>
      get copyWith => __$$TestsListEvent$TestAddedImplCopyWithImpl<
          _$TestsListEvent$TestAddedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title, String? description) testAdded,
    required TResult Function(int testId) testDeleted,
  }) {
    return testAdded(title, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title, String? description)? testAdded,
    TResult? Function(int testId)? testDeleted,
  }) {
    return testAdded?.call(title, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title, String? description)? testAdded,
    TResult Function(int testId)? testDeleted,
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
    required TResult Function(_TestsListEvent$Started value) started,
    required TResult Function(_TestsListEvent$TestAdded value) testAdded,
    required TResult Function(_TestsListEvent$TestDeleted value) testDeleted,
  }) {
    return testAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestsListEvent$Started value)? started,
    TResult? Function(_TestsListEvent$TestAdded value)? testAdded,
    TResult? Function(_TestsListEvent$TestDeleted value)? testDeleted,
  }) {
    return testAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestsListEvent$Started value)? started,
    TResult Function(_TestsListEvent$TestAdded value)? testAdded,
    TResult Function(_TestsListEvent$TestDeleted value)? testDeleted,
    required TResult orElse(),
  }) {
    if (testAdded != null) {
      return testAdded(this);
    }
    return orElse();
  }
}

abstract class _TestsListEvent$TestAdded implements TestsListEvent {
  const factory _TestsListEvent$TestAdded(
      {required final String title,
      final String? description}) = _$TestsListEvent$TestAddedImpl;

  String get title;
  String? get description;
  @JsonKey(ignore: true)
  _$$TestsListEvent$TestAddedImplCopyWith<_$TestsListEvent$TestAddedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestsListEvent$TestDeletedImplCopyWith<$Res> {
  factory _$$TestsListEvent$TestDeletedImplCopyWith(
          _$TestsListEvent$TestDeletedImpl value,
          $Res Function(_$TestsListEvent$TestDeletedImpl) then) =
      __$$TestsListEvent$TestDeletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int testId});
}

/// @nodoc
class __$$TestsListEvent$TestDeletedImplCopyWithImpl<$Res>
    extends _$TestsListEventCopyWithImpl<$Res, _$TestsListEvent$TestDeletedImpl>
    implements _$$TestsListEvent$TestDeletedImplCopyWith<$Res> {
  __$$TestsListEvent$TestDeletedImplCopyWithImpl(
      _$TestsListEvent$TestDeletedImpl _value,
      $Res Function(_$TestsListEvent$TestDeletedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
  }) {
    return _then(_$TestsListEvent$TestDeletedImpl(
      testId: null == testId
          ? _value.testId
          : testId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TestsListEvent$TestDeletedImpl implements _TestsListEvent$TestDeleted {
  const _$TestsListEvent$TestDeletedImpl({required this.testId});

  @override
  final int testId;

  @override
  String toString() {
    return 'TestsListEvent.testDeleted(testId: $testId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestsListEvent$TestDeletedImpl &&
            (identical(other.testId, testId) || other.testId == testId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, testId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestsListEvent$TestDeletedImplCopyWith<_$TestsListEvent$TestDeletedImpl>
      get copyWith => __$$TestsListEvent$TestDeletedImplCopyWithImpl<
          _$TestsListEvent$TestDeletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title, String? description) testAdded,
    required TResult Function(int testId) testDeleted,
  }) {
    return testDeleted(testId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title, String? description)? testAdded,
    TResult? Function(int testId)? testDeleted,
  }) {
    return testDeleted?.call(testId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title, String? description)? testAdded,
    TResult Function(int testId)? testDeleted,
    required TResult orElse(),
  }) {
    if (testDeleted != null) {
      return testDeleted(testId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TestsListEvent$Started value) started,
    required TResult Function(_TestsListEvent$TestAdded value) testAdded,
    required TResult Function(_TestsListEvent$TestDeleted value) testDeleted,
  }) {
    return testDeleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestsListEvent$Started value)? started,
    TResult? Function(_TestsListEvent$TestAdded value)? testAdded,
    TResult? Function(_TestsListEvent$TestDeleted value)? testDeleted,
  }) {
    return testDeleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestsListEvent$Started value)? started,
    TResult Function(_TestsListEvent$TestAdded value)? testAdded,
    TResult Function(_TestsListEvent$TestDeleted value)? testDeleted,
    required TResult orElse(),
  }) {
    if (testDeleted != null) {
      return testDeleted(this);
    }
    return orElse();
  }
}

abstract class _TestsListEvent$TestDeleted implements TestsListEvent {
  const factory _TestsListEvent$TestDeleted({required final int testId}) =
      _$TestsListEvent$TestDeletedImpl;

  int get testId;
  @JsonKey(ignore: true)
  _$$TestsListEvent$TestDeletedImplCopyWith<_$TestsListEvent$TestDeletedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TestsListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestEntity> tests) loaded,
    required TResult Function(Object? error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestEntity> tests)? loaded,
    TResult? Function(Object? error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestEntity> tests)? loaded,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestsListState$Loading value) loading,
    required TResult Function(TestsListState$Loaded value) loaded,
    required TResult Function(TestsListState$Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestsListState$Loading value)? loading,
    TResult? Function(TestsListState$Loaded value)? loaded,
    TResult? Function(TestsListState$Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestsListState$Loading value)? loading,
    TResult Function(TestsListState$Loaded value)? loaded,
    TResult Function(TestsListState$Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestsListStateCopyWith<$Res> {
  factory $TestsListStateCopyWith(
          TestsListState value, $Res Function(TestsListState) then) =
      _$TestsListStateCopyWithImpl<$Res, TestsListState>;
}

/// @nodoc
class _$TestsListStateCopyWithImpl<$Res, $Val extends TestsListState>
    implements $TestsListStateCopyWith<$Res> {
  _$TestsListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TestsListState$LoadingImplCopyWith<$Res> {
  factory _$$TestsListState$LoadingImplCopyWith(
          _$TestsListState$LoadingImpl value,
          $Res Function(_$TestsListState$LoadingImpl) then) =
      __$$TestsListState$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TestsListState$LoadingImplCopyWithImpl<$Res>
    extends _$TestsListStateCopyWithImpl<$Res, _$TestsListState$LoadingImpl>
    implements _$$TestsListState$LoadingImplCopyWith<$Res> {
  __$$TestsListState$LoadingImplCopyWithImpl(
      _$TestsListState$LoadingImpl _value,
      $Res Function(_$TestsListState$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TestsListState$LoadingImpl extends TestsListState$Loading {
  const _$TestsListState$LoadingImpl() : super._();

  @override
  String toString() {
    return 'TestsListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestsListState$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestEntity> tests) loaded,
    required TResult Function(Object? error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestEntity> tests)? loaded,
    TResult? Function(Object? error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestEntity> tests)? loaded,
    TResult Function(Object? error)? error,
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
    required TResult Function(TestsListState$Loading value) loading,
    required TResult Function(TestsListState$Loaded value) loaded,
    required TResult Function(TestsListState$Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestsListState$Loading value)? loading,
    TResult? Function(TestsListState$Loaded value)? loaded,
    TResult? Function(TestsListState$Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestsListState$Loading value)? loading,
    TResult Function(TestsListState$Loaded value)? loaded,
    TResult Function(TestsListState$Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TestsListState$Loading extends TestsListState {
  const factory TestsListState$Loading() = _$TestsListState$LoadingImpl;
  const TestsListState$Loading._() : super._();
}

/// @nodoc
abstract class _$$TestsListState$LoadedImplCopyWith<$Res> {
  factory _$$TestsListState$LoadedImplCopyWith(
          _$TestsListState$LoadedImpl value,
          $Res Function(_$TestsListState$LoadedImpl) then) =
      __$$TestsListState$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TestEntity> tests});
}

/// @nodoc
class __$$TestsListState$LoadedImplCopyWithImpl<$Res>
    extends _$TestsListStateCopyWithImpl<$Res, _$TestsListState$LoadedImpl>
    implements _$$TestsListState$LoadedImplCopyWith<$Res> {
  __$$TestsListState$LoadedImplCopyWithImpl(_$TestsListState$LoadedImpl _value,
      $Res Function(_$TestsListState$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tests = null,
  }) {
    return _then(_$TestsListState$LoadedImpl(
      tests: null == tests
          ? _value._tests
          : tests // ignore: cast_nullable_to_non_nullable
              as List<TestEntity>,
    ));
  }
}

/// @nodoc

class _$TestsListState$LoadedImpl extends TestsListState$Loaded {
  const _$TestsListState$LoadedImpl({required final List<TestEntity> tests})
      : _tests = tests,
        super._();

  final List<TestEntity> _tests;
  @override
  List<TestEntity> get tests {
    if (_tests is EqualUnmodifiableListView) return _tests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tests);
  }

  @override
  String toString() {
    return 'TestsListState.loaded(tests: $tests)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestsListState$LoadedImpl &&
            const DeepCollectionEquality().equals(other._tests, _tests));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tests));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestsListState$LoadedImplCopyWith<_$TestsListState$LoadedImpl>
      get copyWith => __$$TestsListState$LoadedImplCopyWithImpl<
          _$TestsListState$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestEntity> tests) loaded,
    required TResult Function(Object? error) error,
  }) {
    return loaded(tests);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestEntity> tests)? loaded,
    TResult? Function(Object? error)? error,
  }) {
    return loaded?.call(tests);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestEntity> tests)? loaded,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(tests);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestsListState$Loading value) loading,
    required TResult Function(TestsListState$Loaded value) loaded,
    required TResult Function(TestsListState$Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestsListState$Loading value)? loading,
    TResult? Function(TestsListState$Loaded value)? loaded,
    TResult? Function(TestsListState$Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestsListState$Loading value)? loading,
    TResult Function(TestsListState$Loaded value)? loaded,
    TResult Function(TestsListState$Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TestsListState$Loaded extends TestsListState {
  const factory TestsListState$Loaded({required final List<TestEntity> tests}) =
      _$TestsListState$LoadedImpl;
  const TestsListState$Loaded._() : super._();

  List<TestEntity> get tests;
  @JsonKey(ignore: true)
  _$$TestsListState$LoadedImplCopyWith<_$TestsListState$LoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestsListState$ErrorImplCopyWith<$Res> {
  factory _$$TestsListState$ErrorImplCopyWith(_$TestsListState$ErrorImpl value,
          $Res Function(_$TestsListState$ErrorImpl) then) =
      __$$TestsListState$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object? error});
}

/// @nodoc
class __$$TestsListState$ErrorImplCopyWithImpl<$Res>
    extends _$TestsListStateCopyWithImpl<$Res, _$TestsListState$ErrorImpl>
    implements _$$TestsListState$ErrorImplCopyWith<$Res> {
  __$$TestsListState$ErrorImplCopyWithImpl(_$TestsListState$ErrorImpl _value,
      $Res Function(_$TestsListState$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$TestsListState$ErrorImpl(
      error: freezed == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$TestsListState$ErrorImpl extends TestsListState$Error {
  const _$TestsListState$ErrorImpl({required this.error}) : super._();

  @override
  final Object? error;

  @override
  String toString() {
    return 'TestsListState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestsListState$ErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestsListState$ErrorImplCopyWith<_$TestsListState$ErrorImpl>
      get copyWith =>
          __$$TestsListState$ErrorImplCopyWithImpl<_$TestsListState$ErrorImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestEntity> tests) loaded,
    required TResult Function(Object? error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestEntity> tests)? loaded,
    TResult? Function(Object? error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestEntity> tests)? loaded,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestsListState$Loading value) loading,
    required TResult Function(TestsListState$Loaded value) loaded,
    required TResult Function(TestsListState$Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestsListState$Loading value)? loading,
    TResult? Function(TestsListState$Loaded value)? loaded,
    TResult? Function(TestsListState$Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestsListState$Loading value)? loading,
    TResult Function(TestsListState$Loaded value)? loaded,
    TResult Function(TestsListState$Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TestsListState$Error extends TestsListState {
  const factory TestsListState$Error({required final Object? error}) =
      _$TestsListState$ErrorImpl;
  const TestsListState$Error._() : super._();

  Object? get error;
  @JsonKey(ignore: true)
  _$$TestsListState$ErrorImplCopyWith<_$TestsListState$ErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
