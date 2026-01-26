// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MainEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MainEvent$Started value) started,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MainEvent$Started value)? started,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MainEvent$Started value)? started,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainEventCopyWith<$Res> {
  factory $MainEventCopyWith(MainEvent value, $Res Function(MainEvent) then) =
      _$MainEventCopyWithImpl<$Res, MainEvent>;
}

/// @nodoc
class _$MainEventCopyWithImpl<$Res, $Val extends MainEvent>
    implements $MainEventCopyWith<$Res> {
  _$MainEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MainEvent$StartedImplCopyWith<$Res> {
  factory _$$MainEvent$StartedImplCopyWith(
    _$MainEvent$StartedImpl value,
    $Res Function(_$MainEvent$StartedImpl) then,
  ) = __$$MainEvent$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainEvent$StartedImplCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEvent$StartedImpl>
    implements _$$MainEvent$StartedImplCopyWith<$Res> {
  __$$MainEvent$StartedImplCopyWithImpl(
    _$MainEvent$StartedImpl _value,
    $Res Function(_$MainEvent$StartedImpl) _then,
  ) : super(_value, _then);
}

/// @nodoc

class _$MainEvent$StartedImpl implements _MainEvent$Started {
  const _$MainEvent$StartedImpl();

  @override
  String toString() {
    return 'MainEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MainEvent$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({required TResult Function() started}) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({TResult? Function()? started}) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
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
    required TResult Function(_MainEvent$Started value) started,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MainEvent$Started value)? started,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MainEvent$Started value)? started,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _MainEvent$Started implements MainEvent {
  const factory _MainEvent$Started() = _$MainEvent$StartedImpl;
}

/// @nodoc
mixin _$MainState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() data,
    required TResult Function(Object? error) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? data,
    TResult? Function(Object? error)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? data,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainState$Initial value) initial,
    required TResult Function(MainState$Loading value) loading,
    required TResult Function(MainState$Data value) data,
    required TResult Function(MainState$Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainState$Initial value)? initial,
    TResult? Function(MainState$Loading value)? loading,
    TResult? Function(MainState$Data value)? data,
    TResult? Function(MainState$Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainState$Initial value)? initial,
    TResult Function(MainState$Loading value)? loading,
    TResult Function(MainState$Data value)? data,
    TResult Function(MainState$Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainStateCopyWith<$Res> {
  factory $MainStateCopyWith(MainState value, $Res Function(MainState) then) =
      _$MainStateCopyWithImpl<$Res, MainState>;
}

/// @nodoc
class _$MainStateCopyWithImpl<$Res, $Val extends MainState>
    implements $MainStateCopyWith<$Res> {
  _$MainStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MainState$InitialImplCopyWith<$Res> {
  factory _$$MainState$InitialImplCopyWith(
    _$MainState$InitialImpl value,
    $Res Function(_$MainState$InitialImpl) then,
  ) = __$$MainState$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainState$InitialImplCopyWithImpl<$Res>
    extends _$MainStateCopyWithImpl<$Res, _$MainState$InitialImpl>
    implements _$$MainState$InitialImplCopyWith<$Res> {
  __$$MainState$InitialImplCopyWithImpl(
    _$MainState$InitialImpl _value,
    $Res Function(_$MainState$InitialImpl) _then,
  ) : super(_value, _then);
}

/// @nodoc

class _$MainState$InitialImpl extends MainState$Initial {
  const _$MainState$InitialImpl() : super._();

  @override
  String toString() {
    return 'MainState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MainState$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() data,
    required TResult Function(Object? error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? data,
    TResult? Function(Object? error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? data,
    TResult Function(Object? error)? error,
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
    required TResult Function(MainState$Initial value) initial,
    required TResult Function(MainState$Loading value) loading,
    required TResult Function(MainState$Data value) data,
    required TResult Function(MainState$Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainState$Initial value)? initial,
    TResult? Function(MainState$Loading value)? loading,
    TResult? Function(MainState$Data value)? data,
    TResult? Function(MainState$Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainState$Initial value)? initial,
    TResult Function(MainState$Loading value)? loading,
    TResult Function(MainState$Data value)? data,
    TResult Function(MainState$Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class MainState$Initial extends MainState {
  const factory MainState$Initial() = _$MainState$InitialImpl;
  const MainState$Initial._() : super._();
}

/// @nodoc
abstract class _$$MainState$LoadingImplCopyWith<$Res> {
  factory _$$MainState$LoadingImplCopyWith(
    _$MainState$LoadingImpl value,
    $Res Function(_$MainState$LoadingImpl) then,
  ) = __$$MainState$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainState$LoadingImplCopyWithImpl<$Res>
    extends _$MainStateCopyWithImpl<$Res, _$MainState$LoadingImpl>
    implements _$$MainState$LoadingImplCopyWith<$Res> {
  __$$MainState$LoadingImplCopyWithImpl(
    _$MainState$LoadingImpl _value,
    $Res Function(_$MainState$LoadingImpl) _then,
  ) : super(_value, _then);
}

/// @nodoc

class _$MainState$LoadingImpl extends MainState$Loading {
  const _$MainState$LoadingImpl() : super._();

  @override
  String toString() {
    return 'MainState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MainState$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() data,
    required TResult Function(Object? error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? data,
    TResult? Function(Object? error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? data,
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
    required TResult Function(MainState$Initial value) initial,
    required TResult Function(MainState$Loading value) loading,
    required TResult Function(MainState$Data value) data,
    required TResult Function(MainState$Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainState$Initial value)? initial,
    TResult? Function(MainState$Loading value)? loading,
    TResult? Function(MainState$Data value)? data,
    TResult? Function(MainState$Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainState$Initial value)? initial,
    TResult Function(MainState$Loading value)? loading,
    TResult Function(MainState$Data value)? data,
    TResult Function(MainState$Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MainState$Loading extends MainState {
  const factory MainState$Loading() = _$MainState$LoadingImpl;
  const MainState$Loading._() : super._();
}

/// @nodoc
abstract class _$$MainState$DataImplCopyWith<$Res> {
  factory _$$MainState$DataImplCopyWith(
    _$MainState$DataImpl value,
    $Res Function(_$MainState$DataImpl) then,
  ) = __$$MainState$DataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainState$DataImplCopyWithImpl<$Res>
    extends _$MainStateCopyWithImpl<$Res, _$MainState$DataImpl>
    implements _$$MainState$DataImplCopyWith<$Res> {
  __$$MainState$DataImplCopyWithImpl(
    _$MainState$DataImpl _value,
    $Res Function(_$MainState$DataImpl) _then,
  ) : super(_value, _then);
}

/// @nodoc

class _$MainState$DataImpl extends MainState$Data {
  const _$MainState$DataImpl() : super._();

  @override
  String toString() {
    return 'MainState.data()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MainState$DataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() data,
    required TResult Function(Object? error) error,
  }) {
    return data();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? data,
    TResult? Function(Object? error)? error,
  }) {
    return data?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? data,
    TResult Function(Object? error)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainState$Initial value) initial,
    required TResult Function(MainState$Loading value) loading,
    required TResult Function(MainState$Data value) data,
    required TResult Function(MainState$Error value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainState$Initial value)? initial,
    TResult? Function(MainState$Loading value)? loading,
    TResult? Function(MainState$Data value)? data,
    TResult? Function(MainState$Error value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainState$Initial value)? initial,
    TResult Function(MainState$Loading value)? loading,
    TResult Function(MainState$Data value)? data,
    TResult Function(MainState$Error value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class MainState$Data extends MainState {
  const factory MainState$Data() = _$MainState$DataImpl;
  const MainState$Data._() : super._();
}

/// @nodoc
abstract class _$$MainState$ErrorImplCopyWith<$Res> {
  factory _$$MainState$ErrorImplCopyWith(
    _$MainState$ErrorImpl value,
    $Res Function(_$MainState$ErrorImpl) then,
  ) = __$$MainState$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object? error});
}

/// @nodoc
class __$$MainState$ErrorImplCopyWithImpl<$Res>
    extends _$MainStateCopyWithImpl<$Res, _$MainState$ErrorImpl>
    implements _$$MainState$ErrorImplCopyWith<$Res> {
  __$$MainState$ErrorImplCopyWithImpl(
    _$MainState$ErrorImpl _value,
    $Res Function(_$MainState$ErrorImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = freezed}) {
    return _then(
      _$MainState$ErrorImpl(error: freezed == error ? _value.error : error),
    );
  }
}

/// @nodoc

class _$MainState$ErrorImpl extends MainState$Error {
  const _$MainState$ErrorImpl({required this.error}) : super._();

  @override
  final Object? error;

  @override
  String toString() {
    return 'MainState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainState$ErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainState$ErrorImplCopyWith<_$MainState$ErrorImpl> get copyWith =>
      __$$MainState$ErrorImplCopyWithImpl<_$MainState$ErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() data,
    required TResult Function(Object? error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? data,
    TResult? Function(Object? error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? data,
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
    required TResult Function(MainState$Initial value) initial,
    required TResult Function(MainState$Loading value) loading,
    required TResult Function(MainState$Data value) data,
    required TResult Function(MainState$Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainState$Initial value)? initial,
    TResult? Function(MainState$Loading value)? loading,
    TResult? Function(MainState$Data value)? data,
    TResult? Function(MainState$Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainState$Initial value)? initial,
    TResult Function(MainState$Loading value)? loading,
    TResult Function(MainState$Data value)? data,
    TResult Function(MainState$Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class MainState$Error extends MainState {
  const factory MainState$Error({required final Object? error}) =
      _$MainState$ErrorImpl;
  const MainState$Error._() : super._();

  Object? get error;
  @JsonKey(ignore: true)
  _$$MainState$ErrorImplCopyWith<_$MainState$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
