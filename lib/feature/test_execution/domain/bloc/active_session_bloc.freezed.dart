// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_session_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ActiveSessionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ActiveTestSession? session) updated,
    required TResult Function() cleared,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ActiveTestSession? session)? updated,
    TResult? Function()? cleared,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ActiveTestSession? session)? updated,
    TResult Function()? cleared,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ActiveSessionEvent$Started value) started,
    required TResult Function(_ActiveSessionEvent$Updated value) updated,
    required TResult Function(_ActiveSessionEvent$Cleared value) cleared,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ActiveSessionEvent$Started value)? started,
    TResult? Function(_ActiveSessionEvent$Updated value)? updated,
    TResult? Function(_ActiveSessionEvent$Cleared value)? cleared,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ActiveSessionEvent$Started value)? started,
    TResult Function(_ActiveSessionEvent$Updated value)? updated,
    TResult Function(_ActiveSessionEvent$Cleared value)? cleared,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveSessionEventCopyWith<$Res> {
  factory $ActiveSessionEventCopyWith(
          ActiveSessionEvent value, $Res Function(ActiveSessionEvent) then) =
      _$ActiveSessionEventCopyWithImpl<$Res, ActiveSessionEvent>;
}

/// @nodoc
class _$ActiveSessionEventCopyWithImpl<$Res, $Val extends ActiveSessionEvent>
    implements $ActiveSessionEventCopyWith<$Res> {
  _$ActiveSessionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ActiveSessionEvent$StartedImplCopyWith<$Res> {
  factory _$$ActiveSessionEvent$StartedImplCopyWith(
          _$ActiveSessionEvent$StartedImpl value,
          $Res Function(_$ActiveSessionEvent$StartedImpl) then) =
      __$$ActiveSessionEvent$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActiveSessionEvent$StartedImplCopyWithImpl<$Res>
    extends _$ActiveSessionEventCopyWithImpl<$Res,
        _$ActiveSessionEvent$StartedImpl>
    implements _$$ActiveSessionEvent$StartedImplCopyWith<$Res> {
  __$$ActiveSessionEvent$StartedImplCopyWithImpl(
      _$ActiveSessionEvent$StartedImpl _value,
      $Res Function(_$ActiveSessionEvent$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ActiveSessionEvent$StartedImpl implements _ActiveSessionEvent$Started {
  const _$ActiveSessionEvent$StartedImpl();

  @override
  String toString() {
    return 'ActiveSessionEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveSessionEvent$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ActiveTestSession? session) updated,
    required TResult Function() cleared,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ActiveTestSession? session)? updated,
    TResult? Function()? cleared,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ActiveTestSession? session)? updated,
    TResult Function()? cleared,
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
    required TResult Function(_ActiveSessionEvent$Started value) started,
    required TResult Function(_ActiveSessionEvent$Updated value) updated,
    required TResult Function(_ActiveSessionEvent$Cleared value) cleared,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ActiveSessionEvent$Started value)? started,
    TResult? Function(_ActiveSessionEvent$Updated value)? updated,
    TResult? Function(_ActiveSessionEvent$Cleared value)? cleared,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ActiveSessionEvent$Started value)? started,
    TResult Function(_ActiveSessionEvent$Updated value)? updated,
    TResult Function(_ActiveSessionEvent$Cleared value)? cleared,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _ActiveSessionEvent$Started implements ActiveSessionEvent {
  const factory _ActiveSessionEvent$Started() =
      _$ActiveSessionEvent$StartedImpl;
}

/// @nodoc
abstract class _$$ActiveSessionEvent$UpdatedImplCopyWith<$Res> {
  factory _$$ActiveSessionEvent$UpdatedImplCopyWith(
          _$ActiveSessionEvent$UpdatedImpl value,
          $Res Function(_$ActiveSessionEvent$UpdatedImpl) then) =
      __$$ActiveSessionEvent$UpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ActiveTestSession? session});

  $ActiveTestSessionCopyWith<$Res>? get session;
}

/// @nodoc
class __$$ActiveSessionEvent$UpdatedImplCopyWithImpl<$Res>
    extends _$ActiveSessionEventCopyWithImpl<$Res,
        _$ActiveSessionEvent$UpdatedImpl>
    implements _$$ActiveSessionEvent$UpdatedImplCopyWith<$Res> {
  __$$ActiveSessionEvent$UpdatedImplCopyWithImpl(
      _$ActiveSessionEvent$UpdatedImpl _value,
      $Res Function(_$ActiveSessionEvent$UpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = freezed,
  }) {
    return _then(_$ActiveSessionEvent$UpdatedImpl(
      session: freezed == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as ActiveTestSession?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ActiveTestSessionCopyWith<$Res>? get session {
    if (_value.session == null) {
      return null;
    }

    return $ActiveTestSessionCopyWith<$Res>(_value.session!, (value) {
      return _then(_value.copyWith(session: value));
    });
  }
}

/// @nodoc

class _$ActiveSessionEvent$UpdatedImpl implements _ActiveSessionEvent$Updated {
  const _$ActiveSessionEvent$UpdatedImpl({this.session});

  @override
  final ActiveTestSession? session;

  @override
  String toString() {
    return 'ActiveSessionEvent.updated(session: $session)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveSessionEvent$UpdatedImpl &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveSessionEvent$UpdatedImplCopyWith<_$ActiveSessionEvent$UpdatedImpl>
      get copyWith => __$$ActiveSessionEvent$UpdatedImplCopyWithImpl<
          _$ActiveSessionEvent$UpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ActiveTestSession? session) updated,
    required TResult Function() cleared,
  }) {
    return updated(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ActiveTestSession? session)? updated,
    TResult? Function()? cleared,
  }) {
    return updated?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ActiveTestSession? session)? updated,
    TResult Function()? cleared,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(session);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ActiveSessionEvent$Started value) started,
    required TResult Function(_ActiveSessionEvent$Updated value) updated,
    required TResult Function(_ActiveSessionEvent$Cleared value) cleared,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ActiveSessionEvent$Started value)? started,
    TResult? Function(_ActiveSessionEvent$Updated value)? updated,
    TResult? Function(_ActiveSessionEvent$Cleared value)? cleared,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ActiveSessionEvent$Started value)? started,
    TResult Function(_ActiveSessionEvent$Updated value)? updated,
    TResult Function(_ActiveSessionEvent$Cleared value)? cleared,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class _ActiveSessionEvent$Updated implements ActiveSessionEvent {
  const factory _ActiveSessionEvent$Updated(
      {final ActiveTestSession? session}) = _$ActiveSessionEvent$UpdatedImpl;

  ActiveTestSession? get session;
  @JsonKey(ignore: true)
  _$$ActiveSessionEvent$UpdatedImplCopyWith<_$ActiveSessionEvent$UpdatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActiveSessionEvent$ClearedImplCopyWith<$Res> {
  factory _$$ActiveSessionEvent$ClearedImplCopyWith(
          _$ActiveSessionEvent$ClearedImpl value,
          $Res Function(_$ActiveSessionEvent$ClearedImpl) then) =
      __$$ActiveSessionEvent$ClearedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActiveSessionEvent$ClearedImplCopyWithImpl<$Res>
    extends _$ActiveSessionEventCopyWithImpl<$Res,
        _$ActiveSessionEvent$ClearedImpl>
    implements _$$ActiveSessionEvent$ClearedImplCopyWith<$Res> {
  __$$ActiveSessionEvent$ClearedImplCopyWithImpl(
      _$ActiveSessionEvent$ClearedImpl _value,
      $Res Function(_$ActiveSessionEvent$ClearedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ActiveSessionEvent$ClearedImpl implements _ActiveSessionEvent$Cleared {
  const _$ActiveSessionEvent$ClearedImpl();

  @override
  String toString() {
    return 'ActiveSessionEvent.cleared()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveSessionEvent$ClearedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(ActiveTestSession? session) updated,
    required TResult Function() cleared,
  }) {
    return cleared();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(ActiveTestSession? session)? updated,
    TResult? Function()? cleared,
  }) {
    return cleared?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(ActiveTestSession? session)? updated,
    TResult Function()? cleared,
    required TResult orElse(),
  }) {
    if (cleared != null) {
      return cleared();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ActiveSessionEvent$Started value) started,
    required TResult Function(_ActiveSessionEvent$Updated value) updated,
    required TResult Function(_ActiveSessionEvent$Cleared value) cleared,
  }) {
    return cleared(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ActiveSessionEvent$Started value)? started,
    TResult? Function(_ActiveSessionEvent$Updated value)? updated,
    TResult? Function(_ActiveSessionEvent$Cleared value)? cleared,
  }) {
    return cleared?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ActiveSessionEvent$Started value)? started,
    TResult Function(_ActiveSessionEvent$Updated value)? updated,
    TResult Function(_ActiveSessionEvent$Cleared value)? cleared,
    required TResult orElse(),
  }) {
    if (cleared != null) {
      return cleared(this);
    }
    return orElse();
  }
}

abstract class _ActiveSessionEvent$Cleared implements ActiveSessionEvent {
  const factory _ActiveSessionEvent$Cleared() =
      _$ActiveSessionEvent$ClearedImpl;
}

/// @nodoc
mixin _$ActiveSessionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(ActiveTestSession session) available,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(ActiveTestSession session)? available,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(ActiveTestSession session)? available,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveSessionState$None value) none,
    required TResult Function(ActiveSessionState$Available value) available,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveSessionState$None value)? none,
    TResult? Function(ActiveSessionState$Available value)? available,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveSessionState$None value)? none,
    TResult Function(ActiveSessionState$Available value)? available,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveSessionStateCopyWith<$Res> {
  factory $ActiveSessionStateCopyWith(
          ActiveSessionState value, $Res Function(ActiveSessionState) then) =
      _$ActiveSessionStateCopyWithImpl<$Res, ActiveSessionState>;
}

/// @nodoc
class _$ActiveSessionStateCopyWithImpl<$Res, $Val extends ActiveSessionState>
    implements $ActiveSessionStateCopyWith<$Res> {
  _$ActiveSessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ActiveSessionState$NoneImplCopyWith<$Res> {
  factory _$$ActiveSessionState$NoneImplCopyWith(
          _$ActiveSessionState$NoneImpl value,
          $Res Function(_$ActiveSessionState$NoneImpl) then) =
      __$$ActiveSessionState$NoneImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ActiveSessionState$NoneImplCopyWithImpl<$Res>
    extends _$ActiveSessionStateCopyWithImpl<$Res,
        _$ActiveSessionState$NoneImpl>
    implements _$$ActiveSessionState$NoneImplCopyWith<$Res> {
  __$$ActiveSessionState$NoneImplCopyWithImpl(
      _$ActiveSessionState$NoneImpl _value,
      $Res Function(_$ActiveSessionState$NoneImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ActiveSessionState$NoneImpl implements ActiveSessionState$None {
  const _$ActiveSessionState$NoneImpl();

  @override
  String toString() {
    return 'ActiveSessionState.none()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveSessionState$NoneImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(ActiveTestSession session) available,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(ActiveTestSession session)? available,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(ActiveTestSession session)? available,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveSessionState$None value) none,
    required TResult Function(ActiveSessionState$Available value) available,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveSessionState$None value)? none,
    TResult? Function(ActiveSessionState$Available value)? available,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveSessionState$None value)? none,
    TResult Function(ActiveSessionState$Available value)? available,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }
}

abstract class ActiveSessionState$None implements ActiveSessionState {
  const factory ActiveSessionState$None() = _$ActiveSessionState$NoneImpl;
}

/// @nodoc
abstract class _$$ActiveSessionState$AvailableImplCopyWith<$Res> {
  factory _$$ActiveSessionState$AvailableImplCopyWith(
          _$ActiveSessionState$AvailableImpl value,
          $Res Function(_$ActiveSessionState$AvailableImpl) then) =
      __$$ActiveSessionState$AvailableImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ActiveTestSession session});

  $ActiveTestSessionCopyWith<$Res> get session;
}

/// @nodoc
class __$$ActiveSessionState$AvailableImplCopyWithImpl<$Res>
    extends _$ActiveSessionStateCopyWithImpl<$Res,
        _$ActiveSessionState$AvailableImpl>
    implements _$$ActiveSessionState$AvailableImplCopyWith<$Res> {
  __$$ActiveSessionState$AvailableImplCopyWithImpl(
      _$ActiveSessionState$AvailableImpl _value,
      $Res Function(_$ActiveSessionState$AvailableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
  }) {
    return _then(_$ActiveSessionState$AvailableImpl(
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as ActiveTestSession,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ActiveTestSessionCopyWith<$Res> get session {
    return $ActiveTestSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value));
    });
  }
}

/// @nodoc

class _$ActiveSessionState$AvailableImpl
    implements ActiveSessionState$Available {
  const _$ActiveSessionState$AvailableImpl({required this.session});

  @override
  final ActiveTestSession session;

  @override
  String toString() {
    return 'ActiveSessionState.available(session: $session)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveSessionState$AvailableImpl &&
            (identical(other.session, session) || other.session == session));
  }

  @override
  int get hashCode => Object.hash(runtimeType, session);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveSessionState$AvailableImplCopyWith<
          _$ActiveSessionState$AvailableImpl>
      get copyWith => __$$ActiveSessionState$AvailableImplCopyWithImpl<
          _$ActiveSessionState$AvailableImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() none,
    required TResult Function(ActiveTestSession session) available,
  }) {
    return available(session);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? none,
    TResult? Function(ActiveTestSession session)? available,
  }) {
    return available?.call(session);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? none,
    TResult Function(ActiveTestSession session)? available,
    required TResult orElse(),
  }) {
    if (available != null) {
      return available(session);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ActiveSessionState$None value) none,
    required TResult Function(ActiveSessionState$Available value) available,
  }) {
    return available(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ActiveSessionState$None value)? none,
    TResult? Function(ActiveSessionState$Available value)? available,
  }) {
    return available?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ActiveSessionState$None value)? none,
    TResult Function(ActiveSessionState$Available value)? available,
    required TResult orElse(),
  }) {
    if (available != null) {
      return available(this);
    }
    return orElse();
  }
}

abstract class ActiveSessionState$Available implements ActiveSessionState {
  const factory ActiveSessionState$Available(
          {required final ActiveTestSession session}) =
      _$ActiveSessionState$AvailableImpl;

  ActiveTestSession get session;
  @JsonKey(ignore: true)
  _$$ActiveSessionState$AvailableImplCopyWith<
          _$ActiveSessionState$AvailableImpl>
      get copyWith => throw _privateConstructorUsedError;
}
