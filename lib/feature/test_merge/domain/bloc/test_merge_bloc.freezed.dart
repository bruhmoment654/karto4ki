// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_merge_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TestMergeEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int initialTestId) started,
    required TResult Function(String testId) testToggled,
    required TResult Function(String title) mergeConfirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int initialTestId)? started,
    TResult? Function(String testId)? testToggled,
    TResult? Function(String title)? mergeConfirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int initialTestId)? started,
    TResult Function(String testId)? testToggled,
    TResult Function(String title)? mergeConfirmed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TestMergeEvent$Started value) started,
    required TResult Function(_TestMergeEvent$TestToggled value) testToggled,
    required TResult Function(_TestMergeEvent$MergeConfirmed value)
        mergeConfirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestMergeEvent$Started value)? started,
    TResult? Function(_TestMergeEvent$TestToggled value)? testToggled,
    TResult? Function(_TestMergeEvent$MergeConfirmed value)? mergeConfirmed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestMergeEvent$Started value)? started,
    TResult Function(_TestMergeEvent$TestToggled value)? testToggled,
    TResult Function(_TestMergeEvent$MergeConfirmed value)? mergeConfirmed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestMergeEventCopyWith<$Res> {
  factory $TestMergeEventCopyWith(
          TestMergeEvent value, $Res Function(TestMergeEvent) then) =
      _$TestMergeEventCopyWithImpl<$Res, TestMergeEvent>;
}

/// @nodoc
class _$TestMergeEventCopyWithImpl<$Res, $Val extends TestMergeEvent>
    implements $TestMergeEventCopyWith<$Res> {
  _$TestMergeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TestMergeEvent$StartedImplCopyWith<$Res> {
  factory _$$TestMergeEvent$StartedImplCopyWith(
          _$TestMergeEvent$StartedImpl value,
          $Res Function(_$TestMergeEvent$StartedImpl) then) =
      __$$TestMergeEvent$StartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int initialTestId});
}

/// @nodoc
class __$$TestMergeEvent$StartedImplCopyWithImpl<$Res>
    extends _$TestMergeEventCopyWithImpl<$Res, _$TestMergeEvent$StartedImpl>
    implements _$$TestMergeEvent$StartedImplCopyWith<$Res> {
  __$$TestMergeEvent$StartedImplCopyWithImpl(
      _$TestMergeEvent$StartedImpl _value,
      $Res Function(_$TestMergeEvent$StartedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialTestId = null,
  }) {
    return _then(_$TestMergeEvent$StartedImpl(
      initialTestId: null == initialTestId
          ? _value.initialTestId
          : initialTestId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TestMergeEvent$StartedImpl implements _TestMergeEvent$Started {
  const _$TestMergeEvent$StartedImpl({required this.initialTestId});

  @override
  final int initialTestId;

  @override
  String toString() {
    return 'TestMergeEvent.started(initialTestId: $initialTestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestMergeEvent$StartedImpl &&
            (identical(other.initialTestId, initialTestId) ||
                other.initialTestId == initialTestId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, initialTestId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestMergeEvent$StartedImplCopyWith<_$TestMergeEvent$StartedImpl>
      get copyWith => __$$TestMergeEvent$StartedImplCopyWithImpl<
          _$TestMergeEvent$StartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int initialTestId) started,
    required TResult Function(String testId) testToggled,
    required TResult Function(String title) mergeConfirmed,
  }) {
    return started(initialTestId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int initialTestId)? started,
    TResult? Function(String testId)? testToggled,
    TResult? Function(String title)? mergeConfirmed,
  }) {
    return started?.call(initialTestId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int initialTestId)? started,
    TResult Function(String testId)? testToggled,
    TResult Function(String title)? mergeConfirmed,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(initialTestId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TestMergeEvent$Started value) started,
    required TResult Function(_TestMergeEvent$TestToggled value) testToggled,
    required TResult Function(_TestMergeEvent$MergeConfirmed value)
        mergeConfirmed,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestMergeEvent$Started value)? started,
    TResult? Function(_TestMergeEvent$TestToggled value)? testToggled,
    TResult? Function(_TestMergeEvent$MergeConfirmed value)? mergeConfirmed,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestMergeEvent$Started value)? started,
    TResult Function(_TestMergeEvent$TestToggled value)? testToggled,
    TResult Function(_TestMergeEvent$MergeConfirmed value)? mergeConfirmed,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _TestMergeEvent$Started implements TestMergeEvent {
  const factory _TestMergeEvent$Started({required final int initialTestId}) =
      _$TestMergeEvent$StartedImpl;

  int get initialTestId;
  @JsonKey(ignore: true)
  _$$TestMergeEvent$StartedImplCopyWith<_$TestMergeEvent$StartedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestMergeEvent$TestToggledImplCopyWith<$Res> {
  factory _$$TestMergeEvent$TestToggledImplCopyWith(
          _$TestMergeEvent$TestToggledImpl value,
          $Res Function(_$TestMergeEvent$TestToggledImpl) then) =
      __$$TestMergeEvent$TestToggledImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String testId});
}

/// @nodoc
class __$$TestMergeEvent$TestToggledImplCopyWithImpl<$Res>
    extends _$TestMergeEventCopyWithImpl<$Res, _$TestMergeEvent$TestToggledImpl>
    implements _$$TestMergeEvent$TestToggledImplCopyWith<$Res> {
  __$$TestMergeEvent$TestToggledImplCopyWithImpl(
      _$TestMergeEvent$TestToggledImpl _value,
      $Res Function(_$TestMergeEvent$TestToggledImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
  }) {
    return _then(_$TestMergeEvent$TestToggledImpl(
      testId: null == testId
          ? _value.testId
          : testId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TestMergeEvent$TestToggledImpl implements _TestMergeEvent$TestToggled {
  const _$TestMergeEvent$TestToggledImpl({required this.testId});

  @override
  final String testId;

  @override
  String toString() {
    return 'TestMergeEvent.testToggled(testId: $testId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestMergeEvent$TestToggledImpl &&
            (identical(other.testId, testId) || other.testId == testId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, testId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestMergeEvent$TestToggledImplCopyWith<_$TestMergeEvent$TestToggledImpl>
      get copyWith => __$$TestMergeEvent$TestToggledImplCopyWithImpl<
          _$TestMergeEvent$TestToggledImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int initialTestId) started,
    required TResult Function(String testId) testToggled,
    required TResult Function(String title) mergeConfirmed,
  }) {
    return testToggled(testId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int initialTestId)? started,
    TResult? Function(String testId)? testToggled,
    TResult? Function(String title)? mergeConfirmed,
  }) {
    return testToggled?.call(testId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int initialTestId)? started,
    TResult Function(String testId)? testToggled,
    TResult Function(String title)? mergeConfirmed,
    required TResult orElse(),
  }) {
    if (testToggled != null) {
      return testToggled(testId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TestMergeEvent$Started value) started,
    required TResult Function(_TestMergeEvent$TestToggled value) testToggled,
    required TResult Function(_TestMergeEvent$MergeConfirmed value)
        mergeConfirmed,
  }) {
    return testToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestMergeEvent$Started value)? started,
    TResult? Function(_TestMergeEvent$TestToggled value)? testToggled,
    TResult? Function(_TestMergeEvent$MergeConfirmed value)? mergeConfirmed,
  }) {
    return testToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestMergeEvent$Started value)? started,
    TResult Function(_TestMergeEvent$TestToggled value)? testToggled,
    TResult Function(_TestMergeEvent$MergeConfirmed value)? mergeConfirmed,
    required TResult orElse(),
  }) {
    if (testToggled != null) {
      return testToggled(this);
    }
    return orElse();
  }
}

abstract class _TestMergeEvent$TestToggled implements TestMergeEvent {
  const factory _TestMergeEvent$TestToggled({required final String testId}) =
      _$TestMergeEvent$TestToggledImpl;

  String get testId;
  @JsonKey(ignore: true)
  _$$TestMergeEvent$TestToggledImplCopyWith<_$TestMergeEvent$TestToggledImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestMergeEvent$MergeConfirmedImplCopyWith<$Res> {
  factory _$$TestMergeEvent$MergeConfirmedImplCopyWith(
          _$TestMergeEvent$MergeConfirmedImpl value,
          $Res Function(_$TestMergeEvent$MergeConfirmedImpl) then) =
      __$$TestMergeEvent$MergeConfirmedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title});
}

/// @nodoc
class __$$TestMergeEvent$MergeConfirmedImplCopyWithImpl<$Res>
    extends _$TestMergeEventCopyWithImpl<$Res,
        _$TestMergeEvent$MergeConfirmedImpl>
    implements _$$TestMergeEvent$MergeConfirmedImplCopyWith<$Res> {
  __$$TestMergeEvent$MergeConfirmedImplCopyWithImpl(
      _$TestMergeEvent$MergeConfirmedImpl _value,
      $Res Function(_$TestMergeEvent$MergeConfirmedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
  }) {
    return _then(_$TestMergeEvent$MergeConfirmedImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TestMergeEvent$MergeConfirmedImpl
    implements _TestMergeEvent$MergeConfirmed {
  const _$TestMergeEvent$MergeConfirmedImpl({required this.title});

  @override
  final String title;

  @override
  String toString() {
    return 'TestMergeEvent.mergeConfirmed(title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestMergeEvent$MergeConfirmedImpl &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestMergeEvent$MergeConfirmedImplCopyWith<
          _$TestMergeEvent$MergeConfirmedImpl>
      get copyWith => __$$TestMergeEvent$MergeConfirmedImplCopyWithImpl<
          _$TestMergeEvent$MergeConfirmedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int initialTestId) started,
    required TResult Function(String testId) testToggled,
    required TResult Function(String title) mergeConfirmed,
  }) {
    return mergeConfirmed(title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int initialTestId)? started,
    TResult? Function(String testId)? testToggled,
    TResult? Function(String title)? mergeConfirmed,
  }) {
    return mergeConfirmed?.call(title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int initialTestId)? started,
    TResult Function(String testId)? testToggled,
    TResult Function(String title)? mergeConfirmed,
    required TResult orElse(),
  }) {
    if (mergeConfirmed != null) {
      return mergeConfirmed(title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TestMergeEvent$Started value) started,
    required TResult Function(_TestMergeEvent$TestToggled value) testToggled,
    required TResult Function(_TestMergeEvent$MergeConfirmed value)
        mergeConfirmed,
  }) {
    return mergeConfirmed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestMergeEvent$Started value)? started,
    TResult? Function(_TestMergeEvent$TestToggled value)? testToggled,
    TResult? Function(_TestMergeEvent$MergeConfirmed value)? mergeConfirmed,
  }) {
    return mergeConfirmed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestMergeEvent$Started value)? started,
    TResult Function(_TestMergeEvent$TestToggled value)? testToggled,
    TResult Function(_TestMergeEvent$MergeConfirmed value)? mergeConfirmed,
    required TResult orElse(),
  }) {
    if (mergeConfirmed != null) {
      return mergeConfirmed(this);
    }
    return orElse();
  }
}

abstract class _TestMergeEvent$MergeConfirmed implements TestMergeEvent {
  const factory _TestMergeEvent$MergeConfirmed({required final String title}) =
      _$TestMergeEvent$MergeConfirmedImpl;

  String get title;
  @JsonKey(ignore: true)
  _$$TestMergeEvent$MergeConfirmedImplCopyWith<
          _$TestMergeEvent$MergeConfirmedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TestMergeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestEntity> tests,
            Set<String> selectedTestIds, String initialTestId)
        loaded,
    required TResult Function() merging,
    required TResult Function(int newTestId) success,
    required TResult Function(Failure failure) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestEntity> tests, Set<String> selectedTestIds,
            String initialTestId)?
        loaded,
    TResult? Function()? merging,
    TResult? Function(int newTestId)? success,
    TResult? Function(Failure failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestEntity> tests, Set<String> selectedTestIds,
            String initialTestId)?
        loaded,
    TResult Function()? merging,
    TResult Function(int newTestId)? success,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestMergeState$Loading value) loading,
    required TResult Function(TestMergeState$Loaded value) loaded,
    required TResult Function(TestMergeState$Merging value) merging,
    required TResult Function(TestMergeState$Success value) success,
    required TResult Function(TestMergeState$Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestMergeState$Loading value)? loading,
    TResult? Function(TestMergeState$Loaded value)? loaded,
    TResult? Function(TestMergeState$Merging value)? merging,
    TResult? Function(TestMergeState$Success value)? success,
    TResult? Function(TestMergeState$Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestMergeState$Loading value)? loading,
    TResult Function(TestMergeState$Loaded value)? loaded,
    TResult Function(TestMergeState$Merging value)? merging,
    TResult Function(TestMergeState$Success value)? success,
    TResult Function(TestMergeState$Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestMergeStateCopyWith<$Res> {
  factory $TestMergeStateCopyWith(
          TestMergeState value, $Res Function(TestMergeState) then) =
      _$TestMergeStateCopyWithImpl<$Res, TestMergeState>;
}

/// @nodoc
class _$TestMergeStateCopyWithImpl<$Res, $Val extends TestMergeState>
    implements $TestMergeStateCopyWith<$Res> {
  _$TestMergeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TestMergeState$LoadingImplCopyWith<$Res> {
  factory _$$TestMergeState$LoadingImplCopyWith(
          _$TestMergeState$LoadingImpl value,
          $Res Function(_$TestMergeState$LoadingImpl) then) =
      __$$TestMergeState$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TestMergeState$LoadingImplCopyWithImpl<$Res>
    extends _$TestMergeStateCopyWithImpl<$Res, _$TestMergeState$LoadingImpl>
    implements _$$TestMergeState$LoadingImplCopyWith<$Res> {
  __$$TestMergeState$LoadingImplCopyWithImpl(
      _$TestMergeState$LoadingImpl _value,
      $Res Function(_$TestMergeState$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TestMergeState$LoadingImpl extends TestMergeState$Loading {
  const _$TestMergeState$LoadingImpl() : super._();

  @override
  String toString() {
    return 'TestMergeState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestMergeState$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestEntity> tests,
            Set<String> selectedTestIds, String initialTestId)
        loaded,
    required TResult Function() merging,
    required TResult Function(int newTestId) success,
    required TResult Function(Failure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestEntity> tests, Set<String> selectedTestIds,
            String initialTestId)?
        loaded,
    TResult? Function()? merging,
    TResult? Function(int newTestId)? success,
    TResult? Function(Failure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestEntity> tests, Set<String> selectedTestIds,
            String initialTestId)?
        loaded,
    TResult Function()? merging,
    TResult Function(int newTestId)? success,
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
    required TResult Function(TestMergeState$Loading value) loading,
    required TResult Function(TestMergeState$Loaded value) loaded,
    required TResult Function(TestMergeState$Merging value) merging,
    required TResult Function(TestMergeState$Success value) success,
    required TResult Function(TestMergeState$Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestMergeState$Loading value)? loading,
    TResult? Function(TestMergeState$Loaded value)? loaded,
    TResult? Function(TestMergeState$Merging value)? merging,
    TResult? Function(TestMergeState$Success value)? success,
    TResult? Function(TestMergeState$Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestMergeState$Loading value)? loading,
    TResult Function(TestMergeState$Loaded value)? loaded,
    TResult Function(TestMergeState$Merging value)? merging,
    TResult Function(TestMergeState$Success value)? success,
    TResult Function(TestMergeState$Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TestMergeState$Loading extends TestMergeState {
  const factory TestMergeState$Loading() = _$TestMergeState$LoadingImpl;
  const TestMergeState$Loading._() : super._();
}

/// @nodoc
abstract class _$$TestMergeState$LoadedImplCopyWith<$Res> {
  factory _$$TestMergeState$LoadedImplCopyWith(
          _$TestMergeState$LoadedImpl value,
          $Res Function(_$TestMergeState$LoadedImpl) then) =
      __$$TestMergeState$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<TestEntity> tests,
      Set<String> selectedTestIds,
      String initialTestId});
}

/// @nodoc
class __$$TestMergeState$LoadedImplCopyWithImpl<$Res>
    extends _$TestMergeStateCopyWithImpl<$Res, _$TestMergeState$LoadedImpl>
    implements _$$TestMergeState$LoadedImplCopyWith<$Res> {
  __$$TestMergeState$LoadedImplCopyWithImpl(_$TestMergeState$LoadedImpl _value,
      $Res Function(_$TestMergeState$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tests = null,
    Object? selectedTestIds = null,
    Object? initialTestId = null,
  }) {
    return _then(_$TestMergeState$LoadedImpl(
      tests: null == tests
          ? _value._tests
          : tests // ignore: cast_nullable_to_non_nullable
              as List<TestEntity>,
      selectedTestIds: null == selectedTestIds
          ? _value._selectedTestIds
          : selectedTestIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      initialTestId: null == initialTestId
          ? _value.initialTestId
          : initialTestId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TestMergeState$LoadedImpl extends TestMergeState$Loaded {
  const _$TestMergeState$LoadedImpl(
      {required final List<TestEntity> tests,
      required final Set<String> selectedTestIds,
      required this.initialTestId})
      : _tests = tests,
        _selectedTestIds = selectedTestIds,
        super._();

  final List<TestEntity> _tests;
  @override
  List<TestEntity> get tests {
    if (_tests is EqualUnmodifiableListView) return _tests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tests);
  }

  final Set<String> _selectedTestIds;
  @override
  Set<String> get selectedTestIds {
    if (_selectedTestIds is EqualUnmodifiableSetView) return _selectedTestIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedTestIds);
  }

  @override
  final String initialTestId;

  @override
  String toString() {
    return 'TestMergeState.loaded(tests: $tests, selectedTestIds: $selectedTestIds, initialTestId: $initialTestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestMergeState$LoadedImpl &&
            const DeepCollectionEquality().equals(other._tests, _tests) &&
            const DeepCollectionEquality()
                .equals(other._selectedTestIds, _selectedTestIds) &&
            (identical(other.initialTestId, initialTestId) ||
                other.initialTestId == initialTestId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tests),
      const DeepCollectionEquality().hash(_selectedTestIds),
      initialTestId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestMergeState$LoadedImplCopyWith<_$TestMergeState$LoadedImpl>
      get copyWith => __$$TestMergeState$LoadedImplCopyWithImpl<
          _$TestMergeState$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestEntity> tests,
            Set<String> selectedTestIds, String initialTestId)
        loaded,
    required TResult Function() merging,
    required TResult Function(int newTestId) success,
    required TResult Function(Failure failure) error,
  }) {
    return loaded(tests, selectedTestIds, initialTestId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestEntity> tests, Set<String> selectedTestIds,
            String initialTestId)?
        loaded,
    TResult? Function()? merging,
    TResult? Function(int newTestId)? success,
    TResult? Function(Failure failure)? error,
  }) {
    return loaded?.call(tests, selectedTestIds, initialTestId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestEntity> tests, Set<String> selectedTestIds,
            String initialTestId)?
        loaded,
    TResult Function()? merging,
    TResult Function(int newTestId)? success,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(tests, selectedTestIds, initialTestId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestMergeState$Loading value) loading,
    required TResult Function(TestMergeState$Loaded value) loaded,
    required TResult Function(TestMergeState$Merging value) merging,
    required TResult Function(TestMergeState$Success value) success,
    required TResult Function(TestMergeState$Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestMergeState$Loading value)? loading,
    TResult? Function(TestMergeState$Loaded value)? loaded,
    TResult? Function(TestMergeState$Merging value)? merging,
    TResult? Function(TestMergeState$Success value)? success,
    TResult? Function(TestMergeState$Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestMergeState$Loading value)? loading,
    TResult Function(TestMergeState$Loaded value)? loaded,
    TResult Function(TestMergeState$Merging value)? merging,
    TResult Function(TestMergeState$Success value)? success,
    TResult Function(TestMergeState$Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TestMergeState$Loaded extends TestMergeState {
  const factory TestMergeState$Loaded(
      {required final List<TestEntity> tests,
      required final Set<String> selectedTestIds,
      required final String initialTestId}) = _$TestMergeState$LoadedImpl;
  const TestMergeState$Loaded._() : super._();

  List<TestEntity> get tests;
  Set<String> get selectedTestIds;
  String get initialTestId;
  @JsonKey(ignore: true)
  _$$TestMergeState$LoadedImplCopyWith<_$TestMergeState$LoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestMergeState$MergingImplCopyWith<$Res> {
  factory _$$TestMergeState$MergingImplCopyWith(
          _$TestMergeState$MergingImpl value,
          $Res Function(_$TestMergeState$MergingImpl) then) =
      __$$TestMergeState$MergingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TestMergeState$MergingImplCopyWithImpl<$Res>
    extends _$TestMergeStateCopyWithImpl<$Res, _$TestMergeState$MergingImpl>
    implements _$$TestMergeState$MergingImplCopyWith<$Res> {
  __$$TestMergeState$MergingImplCopyWithImpl(
      _$TestMergeState$MergingImpl _value,
      $Res Function(_$TestMergeState$MergingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TestMergeState$MergingImpl extends TestMergeState$Merging {
  const _$TestMergeState$MergingImpl() : super._();

  @override
  String toString() {
    return 'TestMergeState.merging()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestMergeState$MergingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestEntity> tests,
            Set<String> selectedTestIds, String initialTestId)
        loaded,
    required TResult Function() merging,
    required TResult Function(int newTestId) success,
    required TResult Function(Failure failure) error,
  }) {
    return merging();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestEntity> tests, Set<String> selectedTestIds,
            String initialTestId)?
        loaded,
    TResult? Function()? merging,
    TResult? Function(int newTestId)? success,
    TResult? Function(Failure failure)? error,
  }) {
    return merging?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestEntity> tests, Set<String> selectedTestIds,
            String initialTestId)?
        loaded,
    TResult Function()? merging,
    TResult Function(int newTestId)? success,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (merging != null) {
      return merging();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestMergeState$Loading value) loading,
    required TResult Function(TestMergeState$Loaded value) loaded,
    required TResult Function(TestMergeState$Merging value) merging,
    required TResult Function(TestMergeState$Success value) success,
    required TResult Function(TestMergeState$Error value) error,
  }) {
    return merging(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestMergeState$Loading value)? loading,
    TResult? Function(TestMergeState$Loaded value)? loaded,
    TResult? Function(TestMergeState$Merging value)? merging,
    TResult? Function(TestMergeState$Success value)? success,
    TResult? Function(TestMergeState$Error value)? error,
  }) {
    return merging?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestMergeState$Loading value)? loading,
    TResult Function(TestMergeState$Loaded value)? loaded,
    TResult Function(TestMergeState$Merging value)? merging,
    TResult Function(TestMergeState$Success value)? success,
    TResult Function(TestMergeState$Error value)? error,
    required TResult orElse(),
  }) {
    if (merging != null) {
      return merging(this);
    }
    return orElse();
  }
}

abstract class TestMergeState$Merging extends TestMergeState {
  const factory TestMergeState$Merging() = _$TestMergeState$MergingImpl;
  const TestMergeState$Merging._() : super._();
}

/// @nodoc
abstract class _$$TestMergeState$SuccessImplCopyWith<$Res> {
  factory _$$TestMergeState$SuccessImplCopyWith(
          _$TestMergeState$SuccessImpl value,
          $Res Function(_$TestMergeState$SuccessImpl) then) =
      __$$TestMergeState$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int newTestId});
}

/// @nodoc
class __$$TestMergeState$SuccessImplCopyWithImpl<$Res>
    extends _$TestMergeStateCopyWithImpl<$Res, _$TestMergeState$SuccessImpl>
    implements _$$TestMergeState$SuccessImplCopyWith<$Res> {
  __$$TestMergeState$SuccessImplCopyWithImpl(
      _$TestMergeState$SuccessImpl _value,
      $Res Function(_$TestMergeState$SuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newTestId = null,
  }) {
    return _then(_$TestMergeState$SuccessImpl(
      newTestId: null == newTestId
          ? _value.newTestId
          : newTestId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TestMergeState$SuccessImpl extends TestMergeState$Success {
  const _$TestMergeState$SuccessImpl({required this.newTestId}) : super._();

  @override
  final int newTestId;

  @override
  String toString() {
    return 'TestMergeState.success(newTestId: $newTestId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestMergeState$SuccessImpl &&
            (identical(other.newTestId, newTestId) ||
                other.newTestId == newTestId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newTestId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestMergeState$SuccessImplCopyWith<_$TestMergeState$SuccessImpl>
      get copyWith => __$$TestMergeState$SuccessImplCopyWithImpl<
          _$TestMergeState$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestEntity> tests,
            Set<String> selectedTestIds, String initialTestId)
        loaded,
    required TResult Function() merging,
    required TResult Function(int newTestId) success,
    required TResult Function(Failure failure) error,
  }) {
    return success(newTestId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestEntity> tests, Set<String> selectedTestIds,
            String initialTestId)?
        loaded,
    TResult? Function()? merging,
    TResult? Function(int newTestId)? success,
    TResult? Function(Failure failure)? error,
  }) {
    return success?.call(newTestId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestEntity> tests, Set<String> selectedTestIds,
            String initialTestId)?
        loaded,
    TResult Function()? merging,
    TResult Function(int newTestId)? success,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(newTestId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestMergeState$Loading value) loading,
    required TResult Function(TestMergeState$Loaded value) loaded,
    required TResult Function(TestMergeState$Merging value) merging,
    required TResult Function(TestMergeState$Success value) success,
    required TResult Function(TestMergeState$Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestMergeState$Loading value)? loading,
    TResult? Function(TestMergeState$Loaded value)? loaded,
    TResult? Function(TestMergeState$Merging value)? merging,
    TResult? Function(TestMergeState$Success value)? success,
    TResult? Function(TestMergeState$Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestMergeState$Loading value)? loading,
    TResult Function(TestMergeState$Loaded value)? loaded,
    TResult Function(TestMergeState$Merging value)? merging,
    TResult Function(TestMergeState$Success value)? success,
    TResult Function(TestMergeState$Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class TestMergeState$Success extends TestMergeState {
  const factory TestMergeState$Success({required final int newTestId}) =
      _$TestMergeState$SuccessImpl;
  const TestMergeState$Success._() : super._();

  int get newTestId;
  @JsonKey(ignore: true)
  _$$TestMergeState$SuccessImplCopyWith<_$TestMergeState$SuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestMergeState$ErrorImplCopyWith<$Res> {
  factory _$$TestMergeState$ErrorImplCopyWith(_$TestMergeState$ErrorImpl value,
          $Res Function(_$TestMergeState$ErrorImpl) then) =
      __$$TestMergeState$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});
}

/// @nodoc
class __$$TestMergeState$ErrorImplCopyWithImpl<$Res>
    extends _$TestMergeStateCopyWithImpl<$Res, _$TestMergeState$ErrorImpl>
    implements _$$TestMergeState$ErrorImplCopyWith<$Res> {
  __$$TestMergeState$ErrorImplCopyWithImpl(_$TestMergeState$ErrorImpl _value,
      $Res Function(_$TestMergeState$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$TestMergeState$ErrorImpl(
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

/// @nodoc

class _$TestMergeState$ErrorImpl extends TestMergeState$Error {
  const _$TestMergeState$ErrorImpl({required this.failure}) : super._();

  @override
  final Failure failure;

  @override
  String toString() {
    return 'TestMergeState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestMergeState$ErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestMergeState$ErrorImplCopyWith<_$TestMergeState$ErrorImpl>
      get copyWith =>
          __$$TestMergeState$ErrorImplCopyWithImpl<_$TestMergeState$ErrorImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<TestEntity> tests,
            Set<String> selectedTestIds, String initialTestId)
        loaded,
    required TResult Function() merging,
    required TResult Function(int newTestId) success,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TestEntity> tests, Set<String> selectedTestIds,
            String initialTestId)?
        loaded,
    TResult? Function()? merging,
    TResult? Function(int newTestId)? success,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TestEntity> tests, Set<String> selectedTestIds,
            String initialTestId)?
        loaded,
    TResult Function()? merging,
    TResult Function(int newTestId)? success,
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
    required TResult Function(TestMergeState$Loading value) loading,
    required TResult Function(TestMergeState$Loaded value) loaded,
    required TResult Function(TestMergeState$Merging value) merging,
    required TResult Function(TestMergeState$Success value) success,
    required TResult Function(TestMergeState$Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestMergeState$Loading value)? loading,
    TResult? Function(TestMergeState$Loaded value)? loaded,
    TResult? Function(TestMergeState$Merging value)? merging,
    TResult? Function(TestMergeState$Success value)? success,
    TResult? Function(TestMergeState$Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestMergeState$Loading value)? loading,
    TResult Function(TestMergeState$Loaded value)? loaded,
    TResult Function(TestMergeState$Merging value)? merging,
    TResult Function(TestMergeState$Success value)? success,
    TResult Function(TestMergeState$Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TestMergeState$Error extends TestMergeState {
  const factory TestMergeState$Error({required final Failure failure}) =
      _$TestMergeState$ErrorImpl;
  const TestMergeState$Error._() : super._();

  Failure get failure;
  @JsonKey(ignore: true)
  _$$TestMergeState$ErrorImplCopyWith<_$TestMergeState$ErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
