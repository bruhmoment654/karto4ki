// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tinder_test_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TinderTestEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int testId, bool swapSides) started,
    required TResult Function(String cardId) swipedLeft,
    required TResult Function(String cardId) swipedRight,
    required TResult Function() completed,
    required TResult Function() discard,
    required TResult Function() restarted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int testId, bool swapSides)? started,
    TResult? Function(String cardId)? swipedLeft,
    TResult? Function(String cardId)? swipedRight,
    TResult? Function()? completed,
    TResult? Function()? discard,
    TResult? Function()? restarted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int testId, bool swapSides)? started,
    TResult Function(String cardId)? swipedLeft,
    TResult Function(String cardId)? swipedRight,
    TResult Function()? completed,
    TResult Function()? discard,
    TResult Function()? restarted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TinderTestEvent$Started value) started,
    required TResult Function(_TinderTestEvent$SwipedLeft value) swipedLeft,
    required TResult Function(_TinderTestEvent$SwipedRight value) swipedRight,
    required TResult Function(_TinderTestEvent$Completed value) completed,
    required TResult Function(_TinderTestEvent$Discard value) discard,
    required TResult Function(_TinderTestEvent$Restarted value) restarted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TinderTestEvent$Started value)? started,
    TResult? Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult? Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult? Function(_TinderTestEvent$Completed value)? completed,
    TResult? Function(_TinderTestEvent$Discard value)? discard,
    TResult? Function(_TinderTestEvent$Restarted value)? restarted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TinderTestEvent$Started value)? started,
    TResult Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult Function(_TinderTestEvent$Completed value)? completed,
    TResult Function(_TinderTestEvent$Discard value)? discard,
    TResult Function(_TinderTestEvent$Restarted value)? restarted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TinderTestEventCopyWith<$Res> {
  factory $TinderTestEventCopyWith(
          TinderTestEvent value, $Res Function(TinderTestEvent) then) =
      _$TinderTestEventCopyWithImpl<$Res, TinderTestEvent>;
}

/// @nodoc
class _$TinderTestEventCopyWithImpl<$Res, $Val extends TinderTestEvent>
    implements $TinderTestEventCopyWith<$Res> {
  _$TinderTestEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TinderTestEvent$StartedImplCopyWith<$Res> {
  factory _$$TinderTestEvent$StartedImplCopyWith(
          _$TinderTestEvent$StartedImpl value,
          $Res Function(_$TinderTestEvent$StartedImpl) then) =
      __$$TinderTestEvent$StartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int testId, bool swapSides});
}

/// @nodoc
class __$$TinderTestEvent$StartedImplCopyWithImpl<$Res>
    extends _$TinderTestEventCopyWithImpl<$Res, _$TinderTestEvent$StartedImpl>
    implements _$$TinderTestEvent$StartedImplCopyWith<$Res> {
  __$$TinderTestEvent$StartedImplCopyWithImpl(
      _$TinderTestEvent$StartedImpl _value,
      $Res Function(_$TinderTestEvent$StartedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
    Object? swapSides = null,
  }) {
    return _then(_$TinderTestEvent$StartedImpl(
      testId: null == testId
          ? _value.testId
          : testId // ignore: cast_nullable_to_non_nullable
              as int,
      swapSides: null == swapSides
          ? _value.swapSides
          : swapSides // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TinderTestEvent$StartedImpl implements _TinderTestEvent$Started {
  const _$TinderTestEvent$StartedImpl(
      {required this.testId, this.swapSides = false});

  @override
  final int testId;
  @override
  @JsonKey()
  final bool swapSides;

  @override
  String toString() {
    return 'TinderTestEvent.started(testId: $testId, swapSides: $swapSides)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinderTestEvent$StartedImpl &&
            (identical(other.testId, testId) || other.testId == testId) &&
            (identical(other.swapSides, swapSides) ||
                other.swapSides == swapSides));
  }

  @override
  int get hashCode => Object.hash(runtimeType, testId, swapSides);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TinderTestEvent$StartedImplCopyWith<_$TinderTestEvent$StartedImpl>
      get copyWith => __$$TinderTestEvent$StartedImplCopyWithImpl<
          _$TinderTestEvent$StartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int testId, bool swapSides) started,
    required TResult Function(String cardId) swipedLeft,
    required TResult Function(String cardId) swipedRight,
    required TResult Function() completed,
    required TResult Function() discard,
    required TResult Function() restarted,
  }) {
    return started(testId, swapSides);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int testId, bool swapSides)? started,
    TResult? Function(String cardId)? swipedLeft,
    TResult? Function(String cardId)? swipedRight,
    TResult? Function()? completed,
    TResult? Function()? discard,
    TResult? Function()? restarted,
  }) {
    return started?.call(testId, swapSides);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int testId, bool swapSides)? started,
    TResult Function(String cardId)? swipedLeft,
    TResult Function(String cardId)? swipedRight,
    TResult Function()? completed,
    TResult Function()? discard,
    TResult Function()? restarted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(testId, swapSides);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TinderTestEvent$Started value) started,
    required TResult Function(_TinderTestEvent$SwipedLeft value) swipedLeft,
    required TResult Function(_TinderTestEvent$SwipedRight value) swipedRight,
    required TResult Function(_TinderTestEvent$Completed value) completed,
    required TResult Function(_TinderTestEvent$Discard value) discard,
    required TResult Function(_TinderTestEvent$Restarted value) restarted,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TinderTestEvent$Started value)? started,
    TResult? Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult? Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult? Function(_TinderTestEvent$Completed value)? completed,
    TResult? Function(_TinderTestEvent$Discard value)? discard,
    TResult? Function(_TinderTestEvent$Restarted value)? restarted,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TinderTestEvent$Started value)? started,
    TResult Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult Function(_TinderTestEvent$Completed value)? completed,
    TResult Function(_TinderTestEvent$Discard value)? discard,
    TResult Function(_TinderTestEvent$Restarted value)? restarted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _TinderTestEvent$Started implements TinderTestEvent {
  const factory _TinderTestEvent$Started(
      {required final int testId,
      final bool swapSides}) = _$TinderTestEvent$StartedImpl;

  int get testId;
  bool get swapSides;
  @JsonKey(ignore: true)
  _$$TinderTestEvent$StartedImplCopyWith<_$TinderTestEvent$StartedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TinderTestEvent$SwipedLeftImplCopyWith<$Res> {
  factory _$$TinderTestEvent$SwipedLeftImplCopyWith(
          _$TinderTestEvent$SwipedLeftImpl value,
          $Res Function(_$TinderTestEvent$SwipedLeftImpl) then) =
      __$$TinderTestEvent$SwipedLeftImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String cardId});
}

/// @nodoc
class __$$TinderTestEvent$SwipedLeftImplCopyWithImpl<$Res>
    extends _$TinderTestEventCopyWithImpl<$Res,
        _$TinderTestEvent$SwipedLeftImpl>
    implements _$$TinderTestEvent$SwipedLeftImplCopyWith<$Res> {
  __$$TinderTestEvent$SwipedLeftImplCopyWithImpl(
      _$TinderTestEvent$SwipedLeftImpl _value,
      $Res Function(_$TinderTestEvent$SwipedLeftImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
  }) {
    return _then(_$TinderTestEvent$SwipedLeftImpl(
      cardId: null == cardId
          ? _value.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TinderTestEvent$SwipedLeftImpl implements _TinderTestEvent$SwipedLeft {
  const _$TinderTestEvent$SwipedLeftImpl({required this.cardId});

  @override
  final String cardId;

  @override
  String toString() {
    return 'TinderTestEvent.swipedLeft(cardId: $cardId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinderTestEvent$SwipedLeftImpl &&
            (identical(other.cardId, cardId) || other.cardId == cardId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cardId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TinderTestEvent$SwipedLeftImplCopyWith<_$TinderTestEvent$SwipedLeftImpl>
      get copyWith => __$$TinderTestEvent$SwipedLeftImplCopyWithImpl<
          _$TinderTestEvent$SwipedLeftImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int testId, bool swapSides) started,
    required TResult Function(String cardId) swipedLeft,
    required TResult Function(String cardId) swipedRight,
    required TResult Function() completed,
    required TResult Function() discard,
    required TResult Function() restarted,
  }) {
    return swipedLeft(cardId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int testId, bool swapSides)? started,
    TResult? Function(String cardId)? swipedLeft,
    TResult? Function(String cardId)? swipedRight,
    TResult? Function()? completed,
    TResult? Function()? discard,
    TResult? Function()? restarted,
  }) {
    return swipedLeft?.call(cardId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int testId, bool swapSides)? started,
    TResult Function(String cardId)? swipedLeft,
    TResult Function(String cardId)? swipedRight,
    TResult Function()? completed,
    TResult Function()? discard,
    TResult Function()? restarted,
    required TResult orElse(),
  }) {
    if (swipedLeft != null) {
      return swipedLeft(cardId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TinderTestEvent$Started value) started,
    required TResult Function(_TinderTestEvent$SwipedLeft value) swipedLeft,
    required TResult Function(_TinderTestEvent$SwipedRight value) swipedRight,
    required TResult Function(_TinderTestEvent$Completed value) completed,
    required TResult Function(_TinderTestEvent$Discard value) discard,
    required TResult Function(_TinderTestEvent$Restarted value) restarted,
  }) {
    return swipedLeft(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TinderTestEvent$Started value)? started,
    TResult? Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult? Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult? Function(_TinderTestEvent$Completed value)? completed,
    TResult? Function(_TinderTestEvent$Discard value)? discard,
    TResult? Function(_TinderTestEvent$Restarted value)? restarted,
  }) {
    return swipedLeft?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TinderTestEvent$Started value)? started,
    TResult Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult Function(_TinderTestEvent$Completed value)? completed,
    TResult Function(_TinderTestEvent$Discard value)? discard,
    TResult Function(_TinderTestEvent$Restarted value)? restarted,
    required TResult orElse(),
  }) {
    if (swipedLeft != null) {
      return swipedLeft(this);
    }
    return orElse();
  }
}

abstract class _TinderTestEvent$SwipedLeft implements TinderTestEvent {
  const factory _TinderTestEvent$SwipedLeft({required final String cardId}) =
      _$TinderTestEvent$SwipedLeftImpl;

  String get cardId;
  @JsonKey(ignore: true)
  _$$TinderTestEvent$SwipedLeftImplCopyWith<_$TinderTestEvent$SwipedLeftImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TinderTestEvent$SwipedRightImplCopyWith<$Res> {
  factory _$$TinderTestEvent$SwipedRightImplCopyWith(
          _$TinderTestEvent$SwipedRightImpl value,
          $Res Function(_$TinderTestEvent$SwipedRightImpl) then) =
      __$$TinderTestEvent$SwipedRightImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String cardId});
}

/// @nodoc
class __$$TinderTestEvent$SwipedRightImplCopyWithImpl<$Res>
    extends _$TinderTestEventCopyWithImpl<$Res,
        _$TinderTestEvent$SwipedRightImpl>
    implements _$$TinderTestEvent$SwipedRightImplCopyWith<$Res> {
  __$$TinderTestEvent$SwipedRightImplCopyWithImpl(
      _$TinderTestEvent$SwipedRightImpl _value,
      $Res Function(_$TinderTestEvent$SwipedRightImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
  }) {
    return _then(_$TinderTestEvent$SwipedRightImpl(
      cardId: null == cardId
          ? _value.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TinderTestEvent$SwipedRightImpl
    implements _TinderTestEvent$SwipedRight {
  const _$TinderTestEvent$SwipedRightImpl({required this.cardId});

  @override
  final String cardId;

  @override
  String toString() {
    return 'TinderTestEvent.swipedRight(cardId: $cardId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinderTestEvent$SwipedRightImpl &&
            (identical(other.cardId, cardId) || other.cardId == cardId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cardId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TinderTestEvent$SwipedRightImplCopyWith<_$TinderTestEvent$SwipedRightImpl>
      get copyWith => __$$TinderTestEvent$SwipedRightImplCopyWithImpl<
          _$TinderTestEvent$SwipedRightImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int testId, bool swapSides) started,
    required TResult Function(String cardId) swipedLeft,
    required TResult Function(String cardId) swipedRight,
    required TResult Function() completed,
    required TResult Function() discard,
    required TResult Function() restarted,
  }) {
    return swipedRight(cardId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int testId, bool swapSides)? started,
    TResult? Function(String cardId)? swipedLeft,
    TResult? Function(String cardId)? swipedRight,
    TResult? Function()? completed,
    TResult? Function()? discard,
    TResult? Function()? restarted,
  }) {
    return swipedRight?.call(cardId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int testId, bool swapSides)? started,
    TResult Function(String cardId)? swipedLeft,
    TResult Function(String cardId)? swipedRight,
    TResult Function()? completed,
    TResult Function()? discard,
    TResult Function()? restarted,
    required TResult orElse(),
  }) {
    if (swipedRight != null) {
      return swipedRight(cardId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TinderTestEvent$Started value) started,
    required TResult Function(_TinderTestEvent$SwipedLeft value) swipedLeft,
    required TResult Function(_TinderTestEvent$SwipedRight value) swipedRight,
    required TResult Function(_TinderTestEvent$Completed value) completed,
    required TResult Function(_TinderTestEvent$Discard value) discard,
    required TResult Function(_TinderTestEvent$Restarted value) restarted,
  }) {
    return swipedRight(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TinderTestEvent$Started value)? started,
    TResult? Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult? Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult? Function(_TinderTestEvent$Completed value)? completed,
    TResult? Function(_TinderTestEvent$Discard value)? discard,
    TResult? Function(_TinderTestEvent$Restarted value)? restarted,
  }) {
    return swipedRight?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TinderTestEvent$Started value)? started,
    TResult Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult Function(_TinderTestEvent$Completed value)? completed,
    TResult Function(_TinderTestEvent$Discard value)? discard,
    TResult Function(_TinderTestEvent$Restarted value)? restarted,
    required TResult orElse(),
  }) {
    if (swipedRight != null) {
      return swipedRight(this);
    }
    return orElse();
  }
}

abstract class _TinderTestEvent$SwipedRight implements TinderTestEvent {
  const factory _TinderTestEvent$SwipedRight({required final String cardId}) =
      _$TinderTestEvent$SwipedRightImpl;

  String get cardId;
  @JsonKey(ignore: true)
  _$$TinderTestEvent$SwipedRightImplCopyWith<_$TinderTestEvent$SwipedRightImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TinderTestEvent$CompletedImplCopyWith<$Res> {
  factory _$$TinderTestEvent$CompletedImplCopyWith(
          _$TinderTestEvent$CompletedImpl value,
          $Res Function(_$TinderTestEvent$CompletedImpl) then) =
      __$$TinderTestEvent$CompletedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TinderTestEvent$CompletedImplCopyWithImpl<$Res>
    extends _$TinderTestEventCopyWithImpl<$Res, _$TinderTestEvent$CompletedImpl>
    implements _$$TinderTestEvent$CompletedImplCopyWith<$Res> {
  __$$TinderTestEvent$CompletedImplCopyWithImpl(
      _$TinderTestEvent$CompletedImpl _value,
      $Res Function(_$TinderTestEvent$CompletedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TinderTestEvent$CompletedImpl implements _TinderTestEvent$Completed {
  const _$TinderTestEvent$CompletedImpl();

  @override
  String toString() {
    return 'TinderTestEvent.completed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinderTestEvent$CompletedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int testId, bool swapSides) started,
    required TResult Function(String cardId) swipedLeft,
    required TResult Function(String cardId) swipedRight,
    required TResult Function() completed,
    required TResult Function() discard,
    required TResult Function() restarted,
  }) {
    return completed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int testId, bool swapSides)? started,
    TResult? Function(String cardId)? swipedLeft,
    TResult? Function(String cardId)? swipedRight,
    TResult? Function()? completed,
    TResult? Function()? discard,
    TResult? Function()? restarted,
  }) {
    return completed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int testId, bool swapSides)? started,
    TResult Function(String cardId)? swipedLeft,
    TResult Function(String cardId)? swipedRight,
    TResult Function()? completed,
    TResult Function()? discard,
    TResult Function()? restarted,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TinderTestEvent$Started value) started,
    required TResult Function(_TinderTestEvent$SwipedLeft value) swipedLeft,
    required TResult Function(_TinderTestEvent$SwipedRight value) swipedRight,
    required TResult Function(_TinderTestEvent$Completed value) completed,
    required TResult Function(_TinderTestEvent$Discard value) discard,
    required TResult Function(_TinderTestEvent$Restarted value) restarted,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TinderTestEvent$Started value)? started,
    TResult? Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult? Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult? Function(_TinderTestEvent$Completed value)? completed,
    TResult? Function(_TinderTestEvent$Discard value)? discard,
    TResult? Function(_TinderTestEvent$Restarted value)? restarted,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TinderTestEvent$Started value)? started,
    TResult Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult Function(_TinderTestEvent$Completed value)? completed,
    TResult Function(_TinderTestEvent$Discard value)? discard,
    TResult Function(_TinderTestEvent$Restarted value)? restarted,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class _TinderTestEvent$Completed implements TinderTestEvent {
  const factory _TinderTestEvent$Completed() = _$TinderTestEvent$CompletedImpl;
}

/// @nodoc
abstract class _$$TinderTestEvent$DiscardImplCopyWith<$Res> {
  factory _$$TinderTestEvent$DiscardImplCopyWith(
          _$TinderTestEvent$DiscardImpl value,
          $Res Function(_$TinderTestEvent$DiscardImpl) then) =
      __$$TinderTestEvent$DiscardImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TinderTestEvent$DiscardImplCopyWithImpl<$Res>
    extends _$TinderTestEventCopyWithImpl<$Res, _$TinderTestEvent$DiscardImpl>
    implements _$$TinderTestEvent$DiscardImplCopyWith<$Res> {
  __$$TinderTestEvent$DiscardImplCopyWithImpl(
      _$TinderTestEvent$DiscardImpl _value,
      $Res Function(_$TinderTestEvent$DiscardImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TinderTestEvent$DiscardImpl implements _TinderTestEvent$Discard {
  const _$TinderTestEvent$DiscardImpl();

  @override
  String toString() {
    return 'TinderTestEvent.discard()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinderTestEvent$DiscardImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int testId, bool swapSides) started,
    required TResult Function(String cardId) swipedLeft,
    required TResult Function(String cardId) swipedRight,
    required TResult Function() completed,
    required TResult Function() discard,
    required TResult Function() restarted,
  }) {
    return discard();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int testId, bool swapSides)? started,
    TResult? Function(String cardId)? swipedLeft,
    TResult? Function(String cardId)? swipedRight,
    TResult? Function()? completed,
    TResult? Function()? discard,
    TResult? Function()? restarted,
  }) {
    return discard?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int testId, bool swapSides)? started,
    TResult Function(String cardId)? swipedLeft,
    TResult Function(String cardId)? swipedRight,
    TResult Function()? completed,
    TResult Function()? discard,
    TResult Function()? restarted,
    required TResult orElse(),
  }) {
    if (discard != null) {
      return discard();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TinderTestEvent$Started value) started,
    required TResult Function(_TinderTestEvent$SwipedLeft value) swipedLeft,
    required TResult Function(_TinderTestEvent$SwipedRight value) swipedRight,
    required TResult Function(_TinderTestEvent$Completed value) completed,
    required TResult Function(_TinderTestEvent$Discard value) discard,
    required TResult Function(_TinderTestEvent$Restarted value) restarted,
  }) {
    return discard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TinderTestEvent$Started value)? started,
    TResult? Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult? Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult? Function(_TinderTestEvent$Completed value)? completed,
    TResult? Function(_TinderTestEvent$Discard value)? discard,
    TResult? Function(_TinderTestEvent$Restarted value)? restarted,
  }) {
    return discard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TinderTestEvent$Started value)? started,
    TResult Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult Function(_TinderTestEvent$Completed value)? completed,
    TResult Function(_TinderTestEvent$Discard value)? discard,
    TResult Function(_TinderTestEvent$Restarted value)? restarted,
    required TResult orElse(),
  }) {
    if (discard != null) {
      return discard(this);
    }
    return orElse();
  }
}

abstract class _TinderTestEvent$Discard implements TinderTestEvent {
  const factory _TinderTestEvent$Discard() = _$TinderTestEvent$DiscardImpl;
}

/// @nodoc
abstract class _$$TinderTestEvent$RestartedImplCopyWith<$Res> {
  factory _$$TinderTestEvent$RestartedImplCopyWith(
          _$TinderTestEvent$RestartedImpl value,
          $Res Function(_$TinderTestEvent$RestartedImpl) then) =
      __$$TinderTestEvent$RestartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TinderTestEvent$RestartedImplCopyWithImpl<$Res>
    extends _$TinderTestEventCopyWithImpl<$Res, _$TinderTestEvent$RestartedImpl>
    implements _$$TinderTestEvent$RestartedImplCopyWith<$Res> {
  __$$TinderTestEvent$RestartedImplCopyWithImpl(
      _$TinderTestEvent$RestartedImpl _value,
      $Res Function(_$TinderTestEvent$RestartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TinderTestEvent$RestartedImpl implements _TinderTestEvent$Restarted {
  const _$TinderTestEvent$RestartedImpl();

  @override
  String toString() {
    return 'TinderTestEvent.restarted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinderTestEvent$RestartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int testId, bool swapSides) started,
    required TResult Function(String cardId) swipedLeft,
    required TResult Function(String cardId) swipedRight,
    required TResult Function() completed,
    required TResult Function() discard,
    required TResult Function() restarted,
  }) {
    return restarted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int testId, bool swapSides)? started,
    TResult? Function(String cardId)? swipedLeft,
    TResult? Function(String cardId)? swipedRight,
    TResult? Function()? completed,
    TResult? Function()? discard,
    TResult? Function()? restarted,
  }) {
    return restarted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int testId, bool swapSides)? started,
    TResult Function(String cardId)? swipedLeft,
    TResult Function(String cardId)? swipedRight,
    TResult Function()? completed,
    TResult Function()? discard,
    TResult Function()? restarted,
    required TResult orElse(),
  }) {
    if (restarted != null) {
      return restarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TinderTestEvent$Started value) started,
    required TResult Function(_TinderTestEvent$SwipedLeft value) swipedLeft,
    required TResult Function(_TinderTestEvent$SwipedRight value) swipedRight,
    required TResult Function(_TinderTestEvent$Completed value) completed,
    required TResult Function(_TinderTestEvent$Discard value) discard,
    required TResult Function(_TinderTestEvent$Restarted value) restarted,
  }) {
    return restarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TinderTestEvent$Started value)? started,
    TResult? Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult? Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult? Function(_TinderTestEvent$Completed value)? completed,
    TResult? Function(_TinderTestEvent$Discard value)? discard,
    TResult? Function(_TinderTestEvent$Restarted value)? restarted,
  }) {
    return restarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TinderTestEvent$Started value)? started,
    TResult Function(_TinderTestEvent$SwipedLeft value)? swipedLeft,
    TResult Function(_TinderTestEvent$SwipedRight value)? swipedRight,
    TResult Function(_TinderTestEvent$Completed value)? completed,
    TResult Function(_TinderTestEvent$Discard value)? discard,
    TResult Function(_TinderTestEvent$Restarted value)? restarted,
    required TResult orElse(),
  }) {
    if (restarted != null) {
      return restarted(this);
    }
    return orElse();
  }
}

abstract class _TinderTestEvent$Restarted implements TinderTestEvent {
  const factory _TinderTestEvent$Restarted() = _$TinderTestEvent$RestartedImpl;
}

/// @nodoc
mixin _$TinderTestState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(TestSession session, CardEntity currentCard)
        inProgress,
    required TResult Function(TestSession session) completed,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult? Function(TestSession session)? completed,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult Function(TestSession session)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TinderTestState$Initial value) initial,
    required TResult Function(TinderTestState$Loading value) loading,
    required TResult Function(TinderTestState$Empty value) empty,
    required TResult Function(TinderTestState$InProgress value) inProgress,
    required TResult Function(TinderTestState$Completed value) completed,
    required TResult Function(TinderTestState$Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TinderTestState$Initial value)? initial,
    TResult? Function(TinderTestState$Loading value)? loading,
    TResult? Function(TinderTestState$Empty value)? empty,
    TResult? Function(TinderTestState$InProgress value)? inProgress,
    TResult? Function(TinderTestState$Completed value)? completed,
    TResult? Function(TinderTestState$Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TinderTestState$Initial value)? initial,
    TResult Function(TinderTestState$Loading value)? loading,
    TResult Function(TinderTestState$Empty value)? empty,
    TResult Function(TinderTestState$InProgress value)? inProgress,
    TResult Function(TinderTestState$Completed value)? completed,
    TResult Function(TinderTestState$Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TinderTestStateCopyWith<$Res> {
  factory $TinderTestStateCopyWith(
          TinderTestState value, $Res Function(TinderTestState) then) =
      _$TinderTestStateCopyWithImpl<$Res, TinderTestState>;
}

/// @nodoc
class _$TinderTestStateCopyWithImpl<$Res, $Val extends TinderTestState>
    implements $TinderTestStateCopyWith<$Res> {
  _$TinderTestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TinderTestState$InitialImplCopyWith<$Res> {
  factory _$$TinderTestState$InitialImplCopyWith(
          _$TinderTestState$InitialImpl value,
          $Res Function(_$TinderTestState$InitialImpl) then) =
      __$$TinderTestState$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TinderTestState$InitialImplCopyWithImpl<$Res>
    extends _$TinderTestStateCopyWithImpl<$Res, _$TinderTestState$InitialImpl>
    implements _$$TinderTestState$InitialImplCopyWith<$Res> {
  __$$TinderTestState$InitialImplCopyWithImpl(
      _$TinderTestState$InitialImpl _value,
      $Res Function(_$TinderTestState$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TinderTestState$InitialImpl extends TinderTestState$Initial {
  const _$TinderTestState$InitialImpl() : super._();

  @override
  String toString() {
    return 'TinderTestState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinderTestState$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(TestSession session, CardEntity currentCard)
        inProgress,
    required TResult Function(TestSession session) completed,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult? Function(TestSession session)? completed,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult Function(TestSession session)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TinderTestState$Initial value) initial,
    required TResult Function(TinderTestState$Loading value) loading,
    required TResult Function(TinderTestState$Empty value) empty,
    required TResult Function(TinderTestState$InProgress value) inProgress,
    required TResult Function(TinderTestState$Completed value) completed,
    required TResult Function(TinderTestState$Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TinderTestState$Initial value)? initial,
    TResult? Function(TinderTestState$Loading value)? loading,
    TResult? Function(TinderTestState$Empty value)? empty,
    TResult? Function(TinderTestState$InProgress value)? inProgress,
    TResult? Function(TinderTestState$Completed value)? completed,
    TResult? Function(TinderTestState$Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TinderTestState$Initial value)? initial,
    TResult Function(TinderTestState$Loading value)? loading,
    TResult Function(TinderTestState$Empty value)? empty,
    TResult Function(TinderTestState$InProgress value)? inProgress,
    TResult Function(TinderTestState$Completed value)? completed,
    TResult Function(TinderTestState$Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TinderTestState$Initial extends TinderTestState {
  const factory TinderTestState$Initial() = _$TinderTestState$InitialImpl;
  const TinderTestState$Initial._() : super._();
}

/// @nodoc
abstract class _$$TinderTestState$LoadingImplCopyWith<$Res> {
  factory _$$TinderTestState$LoadingImplCopyWith(
          _$TinderTestState$LoadingImpl value,
          $Res Function(_$TinderTestState$LoadingImpl) then) =
      __$$TinderTestState$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TinderTestState$LoadingImplCopyWithImpl<$Res>
    extends _$TinderTestStateCopyWithImpl<$Res, _$TinderTestState$LoadingImpl>
    implements _$$TinderTestState$LoadingImplCopyWith<$Res> {
  __$$TinderTestState$LoadingImplCopyWithImpl(
      _$TinderTestState$LoadingImpl _value,
      $Res Function(_$TinderTestState$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TinderTestState$LoadingImpl extends TinderTestState$Loading {
  const _$TinderTestState$LoadingImpl() : super._();

  @override
  String toString() {
    return 'TinderTestState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinderTestState$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(TestSession session, CardEntity currentCard)
        inProgress,
    required TResult Function(TestSession session) completed,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult? Function(TestSession session)? completed,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult Function(TestSession session)? completed,
    TResult Function(String message)? error,
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
    required TResult Function(TinderTestState$Initial value) initial,
    required TResult Function(TinderTestState$Loading value) loading,
    required TResult Function(TinderTestState$Empty value) empty,
    required TResult Function(TinderTestState$InProgress value) inProgress,
    required TResult Function(TinderTestState$Completed value) completed,
    required TResult Function(TinderTestState$Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TinderTestState$Initial value)? initial,
    TResult? Function(TinderTestState$Loading value)? loading,
    TResult? Function(TinderTestState$Empty value)? empty,
    TResult? Function(TinderTestState$InProgress value)? inProgress,
    TResult? Function(TinderTestState$Completed value)? completed,
    TResult? Function(TinderTestState$Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TinderTestState$Initial value)? initial,
    TResult Function(TinderTestState$Loading value)? loading,
    TResult Function(TinderTestState$Empty value)? empty,
    TResult Function(TinderTestState$InProgress value)? inProgress,
    TResult Function(TinderTestState$Completed value)? completed,
    TResult Function(TinderTestState$Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TinderTestState$Loading extends TinderTestState {
  const factory TinderTestState$Loading() = _$TinderTestState$LoadingImpl;
  const TinderTestState$Loading._() : super._();
}

/// @nodoc
abstract class _$$TinderTestState$EmptyImplCopyWith<$Res> {
  factory _$$TinderTestState$EmptyImplCopyWith(
          _$TinderTestState$EmptyImpl value,
          $Res Function(_$TinderTestState$EmptyImpl) then) =
      __$$TinderTestState$EmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TinderTestState$EmptyImplCopyWithImpl<$Res>
    extends _$TinderTestStateCopyWithImpl<$Res, _$TinderTestState$EmptyImpl>
    implements _$$TinderTestState$EmptyImplCopyWith<$Res> {
  __$$TinderTestState$EmptyImplCopyWithImpl(_$TinderTestState$EmptyImpl _value,
      $Res Function(_$TinderTestState$EmptyImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TinderTestState$EmptyImpl extends TinderTestState$Empty {
  const _$TinderTestState$EmptyImpl() : super._();

  @override
  String toString() {
    return 'TinderTestState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinderTestState$EmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(TestSession session, CardEntity currentCard)
        inProgress,
    required TResult Function(TestSession session) completed,
    required TResult Function(String message) error,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult? Function(TestSession session)? completed,
    TResult? Function(String message)? error,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult Function(TestSession session)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TinderTestState$Initial value) initial,
    required TResult Function(TinderTestState$Loading value) loading,
    required TResult Function(TinderTestState$Empty value) empty,
    required TResult Function(TinderTestState$InProgress value) inProgress,
    required TResult Function(TinderTestState$Completed value) completed,
    required TResult Function(TinderTestState$Error value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TinderTestState$Initial value)? initial,
    TResult? Function(TinderTestState$Loading value)? loading,
    TResult? Function(TinderTestState$Empty value)? empty,
    TResult? Function(TinderTestState$InProgress value)? inProgress,
    TResult? Function(TinderTestState$Completed value)? completed,
    TResult? Function(TinderTestState$Error value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TinderTestState$Initial value)? initial,
    TResult Function(TinderTestState$Loading value)? loading,
    TResult Function(TinderTestState$Empty value)? empty,
    TResult Function(TinderTestState$InProgress value)? inProgress,
    TResult Function(TinderTestState$Completed value)? completed,
    TResult Function(TinderTestState$Error value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class TinderTestState$Empty extends TinderTestState {
  const factory TinderTestState$Empty() = _$TinderTestState$EmptyImpl;
  const TinderTestState$Empty._() : super._();
}

/// @nodoc
abstract class _$$TinderTestState$InProgressImplCopyWith<$Res> {
  factory _$$TinderTestState$InProgressImplCopyWith(
          _$TinderTestState$InProgressImpl value,
          $Res Function(_$TinderTestState$InProgressImpl) then) =
      __$$TinderTestState$InProgressImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TestSession session, CardEntity currentCard});

  $TestSessionCopyWith<$Res> get session;
  $CardEntityCopyWith<$Res> get currentCard;
}

/// @nodoc
class __$$TinderTestState$InProgressImplCopyWithImpl<$Res>
    extends _$TinderTestStateCopyWithImpl<$Res,
        _$TinderTestState$InProgressImpl>
    implements _$$TinderTestState$InProgressImplCopyWith<$Res> {
  __$$TinderTestState$InProgressImplCopyWithImpl(
      _$TinderTestState$InProgressImpl _value,
      $Res Function(_$TinderTestState$InProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? currentCard = null,
  }) {
    return _then(_$TinderTestState$InProgressImpl(
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as TestSession,
      currentCard: null == currentCard
          ? _value.currentCard
          : currentCard // ignore: cast_nullable_to_non_nullable
              as CardEntity,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TestSessionCopyWith<$Res> get session {
    return $TestSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CardEntityCopyWith<$Res> get currentCard {
    return $CardEntityCopyWith<$Res>(_value.currentCard, (value) {
      return _then(_value.copyWith(currentCard: value));
    });
  }
}

/// @nodoc

class _$TinderTestState$InProgressImpl extends TinderTestState$InProgress {
  const _$TinderTestState$InProgressImpl(
      {required this.session, required this.currentCard})
      : super._();

  @override
  final TestSession session;
  @override
  final CardEntity currentCard;

  @override
  String toString() {
    return 'TinderTestState.inProgress(session: $session, currentCard: $currentCard)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinderTestState$InProgressImpl &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.currentCard, currentCard) ||
                other.currentCard == currentCard));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session, currentCard);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TinderTestState$InProgressImplCopyWith<_$TinderTestState$InProgressImpl>
      get copyWith => __$$TinderTestState$InProgressImplCopyWithImpl<
          _$TinderTestState$InProgressImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(TestSession session, CardEntity currentCard)
        inProgress,
    required TResult Function(TestSession session) completed,
    required TResult Function(String message) error,
  }) {
    return inProgress(session, currentCard);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult? Function(TestSession session)? completed,
    TResult? Function(String message)? error,
  }) {
    return inProgress?.call(session, currentCard);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult Function(TestSession session)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(session, currentCard);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TinderTestState$Initial value) initial,
    required TResult Function(TinderTestState$Loading value) loading,
    required TResult Function(TinderTestState$Empty value) empty,
    required TResult Function(TinderTestState$InProgress value) inProgress,
    required TResult Function(TinderTestState$Completed value) completed,
    required TResult Function(TinderTestState$Error value) error,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TinderTestState$Initial value)? initial,
    TResult? Function(TinderTestState$Loading value)? loading,
    TResult? Function(TinderTestState$Empty value)? empty,
    TResult? Function(TinderTestState$InProgress value)? inProgress,
    TResult? Function(TinderTestState$Completed value)? completed,
    TResult? Function(TinderTestState$Error value)? error,
  }) {
    return inProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TinderTestState$Initial value)? initial,
    TResult Function(TinderTestState$Loading value)? loading,
    TResult Function(TinderTestState$Empty value)? empty,
    TResult Function(TinderTestState$InProgress value)? inProgress,
    TResult Function(TinderTestState$Completed value)? completed,
    TResult Function(TinderTestState$Error value)? error,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class TinderTestState$InProgress extends TinderTestState {
  const factory TinderTestState$InProgress(
          {required final TestSession session,
          required final CardEntity currentCard}) =
      _$TinderTestState$InProgressImpl;
  const TinderTestState$InProgress._() : super._();

  TestSession get session;
  CardEntity get currentCard;
  @JsonKey(ignore: true)
  _$$TinderTestState$InProgressImplCopyWith<_$TinderTestState$InProgressImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TinderTestState$CompletedImplCopyWith<$Res> {
  factory _$$TinderTestState$CompletedImplCopyWith(
          _$TinderTestState$CompletedImpl value,
          $Res Function(_$TinderTestState$CompletedImpl) then) =
      __$$TinderTestState$CompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TestSession session});

  $TestSessionCopyWith<$Res> get session;
}

/// @nodoc
class __$$TinderTestState$CompletedImplCopyWithImpl<$Res>
    extends _$TinderTestStateCopyWithImpl<$Res, _$TinderTestState$CompletedImpl>
    implements _$$TinderTestState$CompletedImplCopyWith<$Res> {
  __$$TinderTestState$CompletedImplCopyWithImpl(
      _$TinderTestState$CompletedImpl _value,
      $Res Function(_$TinderTestState$CompletedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
  }) {
    return _then(_$TinderTestState$CompletedImpl(
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as TestSession,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TestSessionCopyWith<$Res> get session {
    return $TestSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }
}

/// @nodoc

class _$TinderTestState$CompletedImpl extends TinderTestState$Completed {
  const _$TinderTestState$CompletedImpl({required this.session}) : super._();

  @override
  final TestSession session;

  @override
  String toString() {
    return 'TinderTestState.completed(session: $session)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinderTestState$CompletedImpl &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TinderTestState$CompletedImplCopyWith<_$TinderTestState$CompletedImpl>
      get copyWith => __$$TinderTestState$CompletedImplCopyWithImpl<
          _$TinderTestState$CompletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(TestSession session, CardEntity currentCard)
        inProgress,
    required TResult Function(TestSession session) completed,
    required TResult Function(String message) error,
  }) {
    return completed(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult? Function(TestSession session)? completed,
    TResult? Function(String message)? error,
  }) {
    return completed?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult Function(TestSession session)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(session);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TinderTestState$Initial value) initial,
    required TResult Function(TinderTestState$Loading value) loading,
    required TResult Function(TinderTestState$Empty value) empty,
    required TResult Function(TinderTestState$InProgress value) inProgress,
    required TResult Function(TinderTestState$Completed value) completed,
    required TResult Function(TinderTestState$Error value) error,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TinderTestState$Initial value)? initial,
    TResult? Function(TinderTestState$Loading value)? loading,
    TResult? Function(TinderTestState$Empty value)? empty,
    TResult? Function(TinderTestState$InProgress value)? inProgress,
    TResult? Function(TinderTestState$Completed value)? completed,
    TResult? Function(TinderTestState$Error value)? error,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TinderTestState$Initial value)? initial,
    TResult Function(TinderTestState$Loading value)? loading,
    TResult Function(TinderTestState$Empty value)? empty,
    TResult Function(TinderTestState$InProgress value)? inProgress,
    TResult Function(TinderTestState$Completed value)? completed,
    TResult Function(TinderTestState$Error value)? error,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class TinderTestState$Completed extends TinderTestState {
  const factory TinderTestState$Completed(
      {required final TestSession session}) = _$TinderTestState$CompletedImpl;
  const TinderTestState$Completed._() : super._();

  TestSession get session;
  @JsonKey(ignore: true)
  _$$TinderTestState$CompletedImplCopyWith<_$TinderTestState$CompletedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TinderTestState$ErrorImplCopyWith<$Res> {
  factory _$$TinderTestState$ErrorImplCopyWith(
          _$TinderTestState$ErrorImpl value,
          $Res Function(_$TinderTestState$ErrorImpl) then) =
      __$$TinderTestState$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TinderTestState$ErrorImplCopyWithImpl<$Res>
    extends _$TinderTestStateCopyWithImpl<$Res, _$TinderTestState$ErrorImpl>
    implements _$$TinderTestState$ErrorImplCopyWith<$Res> {
  __$$TinderTestState$ErrorImplCopyWithImpl(_$TinderTestState$ErrorImpl _value,
      $Res Function(_$TinderTestState$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$TinderTestState$ErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TinderTestState$ErrorImpl extends TinderTestState$Error {
  const _$TinderTestState$ErrorImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'TinderTestState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TinderTestState$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TinderTestState$ErrorImplCopyWith<_$TinderTestState$ErrorImpl>
      get copyWith => __$$TinderTestState$ErrorImplCopyWithImpl<
          _$TinderTestState$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(TestSession session, CardEntity currentCard)
        inProgress,
    required TResult Function(TestSession session) completed,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult? Function(TestSession session)? completed,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(TestSession session, CardEntity currentCard)? inProgress,
    TResult Function(TestSession session)? completed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TinderTestState$Initial value) initial,
    required TResult Function(TinderTestState$Loading value) loading,
    required TResult Function(TinderTestState$Empty value) empty,
    required TResult Function(TinderTestState$InProgress value) inProgress,
    required TResult Function(TinderTestState$Completed value) completed,
    required TResult Function(TinderTestState$Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TinderTestState$Initial value)? initial,
    TResult? Function(TinderTestState$Loading value)? loading,
    TResult? Function(TinderTestState$Empty value)? empty,
    TResult? Function(TinderTestState$InProgress value)? inProgress,
    TResult? Function(TinderTestState$Completed value)? completed,
    TResult? Function(TinderTestState$Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TinderTestState$Initial value)? initial,
    TResult Function(TinderTestState$Loading value)? loading,
    TResult Function(TinderTestState$Empty value)? empty,
    TResult Function(TinderTestState$InProgress value)? inProgress,
    TResult Function(TinderTestState$Completed value)? completed,
    TResult Function(TinderTestState$Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TinderTestState$Error extends TinderTestState {
  const factory TinderTestState$Error({required final String message}) =
      _$TinderTestState$ErrorImpl;
  const TinderTestState$Error._() : super._();

  String get message;
  @JsonKey(ignore: true)
  _$$TinderTestState$ErrorImplCopyWith<_$TinderTestState$ErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
