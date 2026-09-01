// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SyncEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() requested,
    required TResult Function() localMutation,
    required TResult Function(List<ConnectivityResult> results)
        connectivityChanged,
    required TResult Function() conflictsShown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? requested,
    TResult? Function()? localMutation,
    TResult? Function(List<ConnectivityResult> results)? connectivityChanged,
    TResult? Function()? conflictsShown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? requested,
    TResult Function()? localMutation,
    TResult Function(List<ConnectivityResult> results)? connectivityChanged,
    TResult Function()? conflictsShown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SyncEvent$Started value) started,
    required TResult Function(_SyncEvent$Requested value) requested,
    required TResult Function(_SyncEvent$LocalMutation value) localMutation,
    required TResult Function(_SyncEvent$ConnectivityChanged value)
        connectivityChanged,
    required TResult Function(_SyncEvent$ConflictsShown value) conflictsShown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SyncEvent$Started value)? started,
    TResult? Function(_SyncEvent$Requested value)? requested,
    TResult? Function(_SyncEvent$LocalMutation value)? localMutation,
    TResult? Function(_SyncEvent$ConnectivityChanged value)?
        connectivityChanged,
    TResult? Function(_SyncEvent$ConflictsShown value)? conflictsShown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SyncEvent$Started value)? started,
    TResult Function(_SyncEvent$Requested value)? requested,
    TResult Function(_SyncEvent$LocalMutation value)? localMutation,
    TResult Function(_SyncEvent$ConnectivityChanged value)? connectivityChanged,
    TResult Function(_SyncEvent$ConflictsShown value)? conflictsShown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncEventCopyWith<$Res> {
  factory $SyncEventCopyWith(SyncEvent value, $Res Function(SyncEvent) then) =
      _$SyncEventCopyWithImpl<$Res, SyncEvent>;
}

/// @nodoc
class _$SyncEventCopyWithImpl<$Res, $Val extends SyncEvent>
    implements $SyncEventCopyWith<$Res> {
  _$SyncEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SyncEvent$StartedImplCopyWith<$Res> {
  factory _$$SyncEvent$StartedImplCopyWith(_$SyncEvent$StartedImpl value,
          $Res Function(_$SyncEvent$StartedImpl) then) =
      __$$SyncEvent$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SyncEvent$StartedImplCopyWithImpl<$Res>
    extends _$SyncEventCopyWithImpl<$Res, _$SyncEvent$StartedImpl>
    implements _$$SyncEvent$StartedImplCopyWith<$Res> {
  __$$SyncEvent$StartedImplCopyWithImpl(_$SyncEvent$StartedImpl _value,
      $Res Function(_$SyncEvent$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SyncEvent$StartedImpl implements _SyncEvent$Started {
  const _$SyncEvent$StartedImpl();

  @override
  String toString() {
    return 'SyncEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SyncEvent$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() requested,
    required TResult Function() localMutation,
    required TResult Function(List<ConnectivityResult> results)
        connectivityChanged,
    required TResult Function() conflictsShown,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? requested,
    TResult? Function()? localMutation,
    TResult? Function(List<ConnectivityResult> results)? connectivityChanged,
    TResult? Function()? conflictsShown,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? requested,
    TResult Function()? localMutation,
    TResult Function(List<ConnectivityResult> results)? connectivityChanged,
    TResult Function()? conflictsShown,
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
    required TResult Function(_SyncEvent$Started value) started,
    required TResult Function(_SyncEvent$Requested value) requested,
    required TResult Function(_SyncEvent$LocalMutation value) localMutation,
    required TResult Function(_SyncEvent$ConnectivityChanged value)
        connectivityChanged,
    required TResult Function(_SyncEvent$ConflictsShown value) conflictsShown,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SyncEvent$Started value)? started,
    TResult? Function(_SyncEvent$Requested value)? requested,
    TResult? Function(_SyncEvent$LocalMutation value)? localMutation,
    TResult? Function(_SyncEvent$ConnectivityChanged value)?
        connectivityChanged,
    TResult? Function(_SyncEvent$ConflictsShown value)? conflictsShown,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SyncEvent$Started value)? started,
    TResult Function(_SyncEvent$Requested value)? requested,
    TResult Function(_SyncEvent$LocalMutation value)? localMutation,
    TResult Function(_SyncEvent$ConnectivityChanged value)? connectivityChanged,
    TResult Function(_SyncEvent$ConflictsShown value)? conflictsShown,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _SyncEvent$Started implements SyncEvent {
  const factory _SyncEvent$Started() = _$SyncEvent$StartedImpl;
}

/// @nodoc
abstract class _$$SyncEvent$RequestedImplCopyWith<$Res> {
  factory _$$SyncEvent$RequestedImplCopyWith(_$SyncEvent$RequestedImpl value,
          $Res Function(_$SyncEvent$RequestedImpl) then) =
      __$$SyncEvent$RequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SyncEvent$RequestedImplCopyWithImpl<$Res>
    extends _$SyncEventCopyWithImpl<$Res, _$SyncEvent$RequestedImpl>
    implements _$$SyncEvent$RequestedImplCopyWith<$Res> {
  __$$SyncEvent$RequestedImplCopyWithImpl(_$SyncEvent$RequestedImpl _value,
      $Res Function(_$SyncEvent$RequestedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SyncEvent$RequestedImpl implements _SyncEvent$Requested {
  const _$SyncEvent$RequestedImpl();

  @override
  String toString() {
    return 'SyncEvent.requested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncEvent$RequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() requested,
    required TResult Function() localMutation,
    required TResult Function(List<ConnectivityResult> results)
        connectivityChanged,
    required TResult Function() conflictsShown,
  }) {
    return requested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? requested,
    TResult? Function()? localMutation,
    TResult? Function(List<ConnectivityResult> results)? connectivityChanged,
    TResult? Function()? conflictsShown,
  }) {
    return requested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? requested,
    TResult Function()? localMutation,
    TResult Function(List<ConnectivityResult> results)? connectivityChanged,
    TResult Function()? conflictsShown,
    required TResult orElse(),
  }) {
    if (requested != null) {
      return requested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SyncEvent$Started value) started,
    required TResult Function(_SyncEvent$Requested value) requested,
    required TResult Function(_SyncEvent$LocalMutation value) localMutation,
    required TResult Function(_SyncEvent$ConnectivityChanged value)
        connectivityChanged,
    required TResult Function(_SyncEvent$ConflictsShown value) conflictsShown,
  }) {
    return requested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SyncEvent$Started value)? started,
    TResult? Function(_SyncEvent$Requested value)? requested,
    TResult? Function(_SyncEvent$LocalMutation value)? localMutation,
    TResult? Function(_SyncEvent$ConnectivityChanged value)?
        connectivityChanged,
    TResult? Function(_SyncEvent$ConflictsShown value)? conflictsShown,
  }) {
    return requested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SyncEvent$Started value)? started,
    TResult Function(_SyncEvent$Requested value)? requested,
    TResult Function(_SyncEvent$LocalMutation value)? localMutation,
    TResult Function(_SyncEvent$ConnectivityChanged value)? connectivityChanged,
    TResult Function(_SyncEvent$ConflictsShown value)? conflictsShown,
    required TResult orElse(),
  }) {
    if (requested != null) {
      return requested(this);
    }
    return orElse();
  }
}

abstract class _SyncEvent$Requested implements SyncEvent {
  const factory _SyncEvent$Requested() = _$SyncEvent$RequestedImpl;
}

/// @nodoc
abstract class _$$SyncEvent$LocalMutationImplCopyWith<$Res> {
  factory _$$SyncEvent$LocalMutationImplCopyWith(
          _$SyncEvent$LocalMutationImpl value,
          $Res Function(_$SyncEvent$LocalMutationImpl) then) =
      __$$SyncEvent$LocalMutationImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SyncEvent$LocalMutationImplCopyWithImpl<$Res>
    extends _$SyncEventCopyWithImpl<$Res, _$SyncEvent$LocalMutationImpl>
    implements _$$SyncEvent$LocalMutationImplCopyWith<$Res> {
  __$$SyncEvent$LocalMutationImplCopyWithImpl(
      _$SyncEvent$LocalMutationImpl _value,
      $Res Function(_$SyncEvent$LocalMutationImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SyncEvent$LocalMutationImpl implements _SyncEvent$LocalMutation {
  const _$SyncEvent$LocalMutationImpl();

  @override
  String toString() {
    return 'SyncEvent.localMutation()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncEvent$LocalMutationImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() requested,
    required TResult Function() localMutation,
    required TResult Function(List<ConnectivityResult> results)
        connectivityChanged,
    required TResult Function() conflictsShown,
  }) {
    return localMutation();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? requested,
    TResult? Function()? localMutation,
    TResult? Function(List<ConnectivityResult> results)? connectivityChanged,
    TResult? Function()? conflictsShown,
  }) {
    return localMutation?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? requested,
    TResult Function()? localMutation,
    TResult Function(List<ConnectivityResult> results)? connectivityChanged,
    TResult Function()? conflictsShown,
    required TResult orElse(),
  }) {
    if (localMutation != null) {
      return localMutation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SyncEvent$Started value) started,
    required TResult Function(_SyncEvent$Requested value) requested,
    required TResult Function(_SyncEvent$LocalMutation value) localMutation,
    required TResult Function(_SyncEvent$ConnectivityChanged value)
        connectivityChanged,
    required TResult Function(_SyncEvent$ConflictsShown value) conflictsShown,
  }) {
    return localMutation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SyncEvent$Started value)? started,
    TResult? Function(_SyncEvent$Requested value)? requested,
    TResult? Function(_SyncEvent$LocalMutation value)? localMutation,
    TResult? Function(_SyncEvent$ConnectivityChanged value)?
        connectivityChanged,
    TResult? Function(_SyncEvent$ConflictsShown value)? conflictsShown,
  }) {
    return localMutation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SyncEvent$Started value)? started,
    TResult Function(_SyncEvent$Requested value)? requested,
    TResult Function(_SyncEvent$LocalMutation value)? localMutation,
    TResult Function(_SyncEvent$ConnectivityChanged value)? connectivityChanged,
    TResult Function(_SyncEvent$ConflictsShown value)? conflictsShown,
    required TResult orElse(),
  }) {
    if (localMutation != null) {
      return localMutation(this);
    }
    return orElse();
  }
}

abstract class _SyncEvent$LocalMutation implements SyncEvent {
  const factory _SyncEvent$LocalMutation() = _$SyncEvent$LocalMutationImpl;
}

/// @nodoc
abstract class _$$SyncEvent$ConnectivityChangedImplCopyWith<$Res> {
  factory _$$SyncEvent$ConnectivityChangedImplCopyWith(
          _$SyncEvent$ConnectivityChangedImpl value,
          $Res Function(_$SyncEvent$ConnectivityChangedImpl) then) =
      __$$SyncEvent$ConnectivityChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ConnectivityResult> results});
}

/// @nodoc
class __$$SyncEvent$ConnectivityChangedImplCopyWithImpl<$Res>
    extends _$SyncEventCopyWithImpl<$Res, _$SyncEvent$ConnectivityChangedImpl>
    implements _$$SyncEvent$ConnectivityChangedImplCopyWith<$Res> {
  __$$SyncEvent$ConnectivityChangedImplCopyWithImpl(
      _$SyncEvent$ConnectivityChangedImpl _value,
      $Res Function(_$SyncEvent$ConnectivityChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
  }) {
    return _then(_$SyncEvent$ConnectivityChangedImpl(
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<ConnectivityResult>,
    ));
  }
}

/// @nodoc

class _$SyncEvent$ConnectivityChangedImpl
    implements _SyncEvent$ConnectivityChanged {
  const _$SyncEvent$ConnectivityChangedImpl(
      {required final List<ConnectivityResult> results})
      : _results = results;

  final List<ConnectivityResult> _results;
  @override
  List<ConnectivityResult> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'SyncEvent.connectivityChanged(results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncEvent$ConnectivityChangedImpl &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_results));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncEvent$ConnectivityChangedImplCopyWith<
          _$SyncEvent$ConnectivityChangedImpl>
      get copyWith => __$$SyncEvent$ConnectivityChangedImplCopyWithImpl<
          _$SyncEvent$ConnectivityChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() requested,
    required TResult Function() localMutation,
    required TResult Function(List<ConnectivityResult> results)
        connectivityChanged,
    required TResult Function() conflictsShown,
  }) {
    return connectivityChanged(results);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? requested,
    TResult? Function()? localMutation,
    TResult? Function(List<ConnectivityResult> results)? connectivityChanged,
    TResult? Function()? conflictsShown,
  }) {
    return connectivityChanged?.call(results);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? requested,
    TResult Function()? localMutation,
    TResult Function(List<ConnectivityResult> results)? connectivityChanged,
    TResult Function()? conflictsShown,
    required TResult orElse(),
  }) {
    if (connectivityChanged != null) {
      return connectivityChanged(results);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SyncEvent$Started value) started,
    required TResult Function(_SyncEvent$Requested value) requested,
    required TResult Function(_SyncEvent$LocalMutation value) localMutation,
    required TResult Function(_SyncEvent$ConnectivityChanged value)
        connectivityChanged,
    required TResult Function(_SyncEvent$ConflictsShown value) conflictsShown,
  }) {
    return connectivityChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SyncEvent$Started value)? started,
    TResult? Function(_SyncEvent$Requested value)? requested,
    TResult? Function(_SyncEvent$LocalMutation value)? localMutation,
    TResult? Function(_SyncEvent$ConnectivityChanged value)?
        connectivityChanged,
    TResult? Function(_SyncEvent$ConflictsShown value)? conflictsShown,
  }) {
    return connectivityChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SyncEvent$Started value)? started,
    TResult Function(_SyncEvent$Requested value)? requested,
    TResult Function(_SyncEvent$LocalMutation value)? localMutation,
    TResult Function(_SyncEvent$ConnectivityChanged value)? connectivityChanged,
    TResult Function(_SyncEvent$ConflictsShown value)? conflictsShown,
    required TResult orElse(),
  }) {
    if (connectivityChanged != null) {
      return connectivityChanged(this);
    }
    return orElse();
  }
}

abstract class _SyncEvent$ConnectivityChanged implements SyncEvent {
  const factory _SyncEvent$ConnectivityChanged(
          {required final List<ConnectivityResult> results}) =
      _$SyncEvent$ConnectivityChangedImpl;

  List<ConnectivityResult> get results;
  @JsonKey(ignore: true)
  _$$SyncEvent$ConnectivityChangedImplCopyWith<
          _$SyncEvent$ConnectivityChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SyncEvent$ConflictsShownImplCopyWith<$Res> {
  factory _$$SyncEvent$ConflictsShownImplCopyWith(
          _$SyncEvent$ConflictsShownImpl value,
          $Res Function(_$SyncEvent$ConflictsShownImpl) then) =
      __$$SyncEvent$ConflictsShownImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SyncEvent$ConflictsShownImplCopyWithImpl<$Res>
    extends _$SyncEventCopyWithImpl<$Res, _$SyncEvent$ConflictsShownImpl>
    implements _$$SyncEvent$ConflictsShownImplCopyWith<$Res> {
  __$$SyncEvent$ConflictsShownImplCopyWithImpl(
      _$SyncEvent$ConflictsShownImpl _value,
      $Res Function(_$SyncEvent$ConflictsShownImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SyncEvent$ConflictsShownImpl implements _SyncEvent$ConflictsShown {
  const _$SyncEvent$ConflictsShownImpl();

  @override
  String toString() {
    return 'SyncEvent.conflictsShown()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncEvent$ConflictsShownImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() requested,
    required TResult Function() localMutation,
    required TResult Function(List<ConnectivityResult> results)
        connectivityChanged,
    required TResult Function() conflictsShown,
  }) {
    return conflictsShown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? requested,
    TResult? Function()? localMutation,
    TResult? Function(List<ConnectivityResult> results)? connectivityChanged,
    TResult? Function()? conflictsShown,
  }) {
    return conflictsShown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? requested,
    TResult Function()? localMutation,
    TResult Function(List<ConnectivityResult> results)? connectivityChanged,
    TResult Function()? conflictsShown,
    required TResult orElse(),
  }) {
    if (conflictsShown != null) {
      return conflictsShown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SyncEvent$Started value) started,
    required TResult Function(_SyncEvent$Requested value) requested,
    required TResult Function(_SyncEvent$LocalMutation value) localMutation,
    required TResult Function(_SyncEvent$ConnectivityChanged value)
        connectivityChanged,
    required TResult Function(_SyncEvent$ConflictsShown value) conflictsShown,
  }) {
    return conflictsShown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SyncEvent$Started value)? started,
    TResult? Function(_SyncEvent$Requested value)? requested,
    TResult? Function(_SyncEvent$LocalMutation value)? localMutation,
    TResult? Function(_SyncEvent$ConnectivityChanged value)?
        connectivityChanged,
    TResult? Function(_SyncEvent$ConflictsShown value)? conflictsShown,
  }) {
    return conflictsShown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SyncEvent$Started value)? started,
    TResult Function(_SyncEvent$Requested value)? requested,
    TResult Function(_SyncEvent$LocalMutation value)? localMutation,
    TResult Function(_SyncEvent$ConnectivityChanged value)? connectivityChanged,
    TResult Function(_SyncEvent$ConflictsShown value)? conflictsShown,
    required TResult orElse(),
  }) {
    if (conflictsShown != null) {
      return conflictsShown(this);
    }
    return orElse();
  }
}

abstract class _SyncEvent$ConflictsShown implements SyncEvent {
  const factory _SyncEvent$ConflictsShown() = _$SyncEvent$ConflictsShownImpl;
}

/// @nodoc
mixin _$SyncStatus {
  DateTime? get lastSyncedAt => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? lastSyncedAt) idle,
    required TResult Function(DateTime? lastSyncedAt) syncing,
    required TResult Function(DateTime? lastSyncedAt) offline,
    required TResult Function(ApiException error, DateTime? lastSyncedAt)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? lastSyncedAt)? idle,
    TResult? Function(DateTime? lastSyncedAt)? syncing,
    TResult? Function(DateTime? lastSyncedAt)? offline,
    TResult? Function(ApiException error, DateTime? lastSyncedAt)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? lastSyncedAt)? idle,
    TResult Function(DateTime? lastSyncedAt)? syncing,
    TResult Function(DateTime? lastSyncedAt)? offline,
    TResult Function(ApiException error, DateTime? lastSyncedAt)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SyncStatus$Idle value) idle,
    required TResult Function(SyncStatus$Syncing value) syncing,
    required TResult Function(SyncStatus$Offline value) offline,
    required TResult Function(SyncStatus$Failed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SyncStatus$Idle value)? idle,
    TResult? Function(SyncStatus$Syncing value)? syncing,
    TResult? Function(SyncStatus$Offline value)? offline,
    TResult? Function(SyncStatus$Failed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SyncStatus$Idle value)? idle,
    TResult Function(SyncStatus$Syncing value)? syncing,
    TResult Function(SyncStatus$Offline value)? offline,
    TResult Function(SyncStatus$Failed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SyncStatusCopyWith<SyncStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncStatusCopyWith<$Res> {
  factory $SyncStatusCopyWith(
          SyncStatus value, $Res Function(SyncStatus) then) =
      _$SyncStatusCopyWithImpl<$Res, SyncStatus>;
  @useResult
  $Res call({DateTime? lastSyncedAt});
}

/// @nodoc
class _$SyncStatusCopyWithImpl<$Res, $Val extends SyncStatus>
    implements $SyncStatusCopyWith<$Res> {
  _$SyncStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSyncedAt = freezed,
  }) {
    return _then(_value.copyWith(
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncStatus$IdleImplCopyWith<$Res>
    implements $SyncStatusCopyWith<$Res> {
  factory _$$SyncStatus$IdleImplCopyWith(_$SyncStatus$IdleImpl value,
          $Res Function(_$SyncStatus$IdleImpl) then) =
      __$$SyncStatus$IdleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? lastSyncedAt});
}

/// @nodoc
class __$$SyncStatus$IdleImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$SyncStatus$IdleImpl>
    implements _$$SyncStatus$IdleImplCopyWith<$Res> {
  __$$SyncStatus$IdleImplCopyWithImpl(
      _$SyncStatus$IdleImpl _value, $Res Function(_$SyncStatus$IdleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSyncedAt = freezed,
  }) {
    return _then(_$SyncStatus$IdleImpl(
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$SyncStatus$IdleImpl implements SyncStatus$Idle {
  const _$SyncStatus$IdleImpl({this.lastSyncedAt});

  @override
  final DateTime? lastSyncedAt;

  @override
  String toString() {
    return 'SyncStatus.idle(lastSyncedAt: $lastSyncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncStatus$IdleImpl &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastSyncedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncStatus$IdleImplCopyWith<_$SyncStatus$IdleImpl> get copyWith =>
      __$$SyncStatus$IdleImplCopyWithImpl<_$SyncStatus$IdleImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? lastSyncedAt) idle,
    required TResult Function(DateTime? lastSyncedAt) syncing,
    required TResult Function(DateTime? lastSyncedAt) offline,
    required TResult Function(ApiException error, DateTime? lastSyncedAt)
        failed,
  }) {
    return idle(lastSyncedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? lastSyncedAt)? idle,
    TResult? Function(DateTime? lastSyncedAt)? syncing,
    TResult? Function(DateTime? lastSyncedAt)? offline,
    TResult? Function(ApiException error, DateTime? lastSyncedAt)? failed,
  }) {
    return idle?.call(lastSyncedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? lastSyncedAt)? idle,
    TResult Function(DateTime? lastSyncedAt)? syncing,
    TResult Function(DateTime? lastSyncedAt)? offline,
    TResult Function(ApiException error, DateTime? lastSyncedAt)? failed,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(lastSyncedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SyncStatus$Idle value) idle,
    required TResult Function(SyncStatus$Syncing value) syncing,
    required TResult Function(SyncStatus$Offline value) offline,
    required TResult Function(SyncStatus$Failed value) failed,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SyncStatus$Idle value)? idle,
    TResult? Function(SyncStatus$Syncing value)? syncing,
    TResult? Function(SyncStatus$Offline value)? offline,
    TResult? Function(SyncStatus$Failed value)? failed,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SyncStatus$Idle value)? idle,
    TResult Function(SyncStatus$Syncing value)? syncing,
    TResult Function(SyncStatus$Offline value)? offline,
    TResult Function(SyncStatus$Failed value)? failed,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class SyncStatus$Idle implements SyncStatus {
  const factory SyncStatus$Idle({final DateTime? lastSyncedAt}) =
      _$SyncStatus$IdleImpl;

  @override
  DateTime? get lastSyncedAt;
  @override
  @JsonKey(ignore: true)
  _$$SyncStatus$IdleImplCopyWith<_$SyncStatus$IdleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SyncStatus$SyncingImplCopyWith<$Res>
    implements $SyncStatusCopyWith<$Res> {
  factory _$$SyncStatus$SyncingImplCopyWith(_$SyncStatus$SyncingImpl value,
          $Res Function(_$SyncStatus$SyncingImpl) then) =
      __$$SyncStatus$SyncingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? lastSyncedAt});
}

/// @nodoc
class __$$SyncStatus$SyncingImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$SyncStatus$SyncingImpl>
    implements _$$SyncStatus$SyncingImplCopyWith<$Res> {
  __$$SyncStatus$SyncingImplCopyWithImpl(_$SyncStatus$SyncingImpl _value,
      $Res Function(_$SyncStatus$SyncingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSyncedAt = freezed,
  }) {
    return _then(_$SyncStatus$SyncingImpl(
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$SyncStatus$SyncingImpl implements SyncStatus$Syncing {
  const _$SyncStatus$SyncingImpl({this.lastSyncedAt});

  @override
  final DateTime? lastSyncedAt;

  @override
  String toString() {
    return 'SyncStatus.syncing(lastSyncedAt: $lastSyncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncStatus$SyncingImpl &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastSyncedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncStatus$SyncingImplCopyWith<_$SyncStatus$SyncingImpl> get copyWith =>
      __$$SyncStatus$SyncingImplCopyWithImpl<_$SyncStatus$SyncingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? lastSyncedAt) idle,
    required TResult Function(DateTime? lastSyncedAt) syncing,
    required TResult Function(DateTime? lastSyncedAt) offline,
    required TResult Function(ApiException error, DateTime? lastSyncedAt)
        failed,
  }) {
    return syncing(lastSyncedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? lastSyncedAt)? idle,
    TResult? Function(DateTime? lastSyncedAt)? syncing,
    TResult? Function(DateTime? lastSyncedAt)? offline,
    TResult? Function(ApiException error, DateTime? lastSyncedAt)? failed,
  }) {
    return syncing?.call(lastSyncedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? lastSyncedAt)? idle,
    TResult Function(DateTime? lastSyncedAt)? syncing,
    TResult Function(DateTime? lastSyncedAt)? offline,
    TResult Function(ApiException error, DateTime? lastSyncedAt)? failed,
    required TResult orElse(),
  }) {
    if (syncing != null) {
      return syncing(lastSyncedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SyncStatus$Idle value) idle,
    required TResult Function(SyncStatus$Syncing value) syncing,
    required TResult Function(SyncStatus$Offline value) offline,
    required TResult Function(SyncStatus$Failed value) failed,
  }) {
    return syncing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SyncStatus$Idle value)? idle,
    TResult? Function(SyncStatus$Syncing value)? syncing,
    TResult? Function(SyncStatus$Offline value)? offline,
    TResult? Function(SyncStatus$Failed value)? failed,
  }) {
    return syncing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SyncStatus$Idle value)? idle,
    TResult Function(SyncStatus$Syncing value)? syncing,
    TResult Function(SyncStatus$Offline value)? offline,
    TResult Function(SyncStatus$Failed value)? failed,
    required TResult orElse(),
  }) {
    if (syncing != null) {
      return syncing(this);
    }
    return orElse();
  }
}

abstract class SyncStatus$Syncing implements SyncStatus {
  const factory SyncStatus$Syncing({final DateTime? lastSyncedAt}) =
      _$SyncStatus$SyncingImpl;

  @override
  DateTime? get lastSyncedAt;
  @override
  @JsonKey(ignore: true)
  _$$SyncStatus$SyncingImplCopyWith<_$SyncStatus$SyncingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SyncStatus$OfflineImplCopyWith<$Res>
    implements $SyncStatusCopyWith<$Res> {
  factory _$$SyncStatus$OfflineImplCopyWith(_$SyncStatus$OfflineImpl value,
          $Res Function(_$SyncStatus$OfflineImpl) then) =
      __$$SyncStatus$OfflineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? lastSyncedAt});
}

/// @nodoc
class __$$SyncStatus$OfflineImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$SyncStatus$OfflineImpl>
    implements _$$SyncStatus$OfflineImplCopyWith<$Res> {
  __$$SyncStatus$OfflineImplCopyWithImpl(_$SyncStatus$OfflineImpl _value,
      $Res Function(_$SyncStatus$OfflineImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastSyncedAt = freezed,
  }) {
    return _then(_$SyncStatus$OfflineImpl(
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$SyncStatus$OfflineImpl implements SyncStatus$Offline {
  const _$SyncStatus$OfflineImpl({this.lastSyncedAt});

  @override
  final DateTime? lastSyncedAt;

  @override
  String toString() {
    return 'SyncStatus.offline(lastSyncedAt: $lastSyncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncStatus$OfflineImpl &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastSyncedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncStatus$OfflineImplCopyWith<_$SyncStatus$OfflineImpl> get copyWith =>
      __$$SyncStatus$OfflineImplCopyWithImpl<_$SyncStatus$OfflineImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? lastSyncedAt) idle,
    required TResult Function(DateTime? lastSyncedAt) syncing,
    required TResult Function(DateTime? lastSyncedAt) offline,
    required TResult Function(ApiException error, DateTime? lastSyncedAt)
        failed,
  }) {
    return offline(lastSyncedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? lastSyncedAt)? idle,
    TResult? Function(DateTime? lastSyncedAt)? syncing,
    TResult? Function(DateTime? lastSyncedAt)? offline,
    TResult? Function(ApiException error, DateTime? lastSyncedAt)? failed,
  }) {
    return offline?.call(lastSyncedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? lastSyncedAt)? idle,
    TResult Function(DateTime? lastSyncedAt)? syncing,
    TResult Function(DateTime? lastSyncedAt)? offline,
    TResult Function(ApiException error, DateTime? lastSyncedAt)? failed,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline(lastSyncedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SyncStatus$Idle value) idle,
    required TResult Function(SyncStatus$Syncing value) syncing,
    required TResult Function(SyncStatus$Offline value) offline,
    required TResult Function(SyncStatus$Failed value) failed,
  }) {
    return offline(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SyncStatus$Idle value)? idle,
    TResult? Function(SyncStatus$Syncing value)? syncing,
    TResult? Function(SyncStatus$Offline value)? offline,
    TResult? Function(SyncStatus$Failed value)? failed,
  }) {
    return offline?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SyncStatus$Idle value)? idle,
    TResult Function(SyncStatus$Syncing value)? syncing,
    TResult Function(SyncStatus$Offline value)? offline,
    TResult Function(SyncStatus$Failed value)? failed,
    required TResult orElse(),
  }) {
    if (offline != null) {
      return offline(this);
    }
    return orElse();
  }
}

abstract class SyncStatus$Offline implements SyncStatus {
  const factory SyncStatus$Offline({final DateTime? lastSyncedAt}) =
      _$SyncStatus$OfflineImpl;

  @override
  DateTime? get lastSyncedAt;
  @override
  @JsonKey(ignore: true)
  _$$SyncStatus$OfflineImplCopyWith<_$SyncStatus$OfflineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SyncStatus$FailedImplCopyWith<$Res>
    implements $SyncStatusCopyWith<$Res> {
  factory _$$SyncStatus$FailedImplCopyWith(_$SyncStatus$FailedImpl value,
          $Res Function(_$SyncStatus$FailedImpl) then) =
      __$$SyncStatus$FailedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ApiException error, DateTime? lastSyncedAt});
}

/// @nodoc
class __$$SyncStatus$FailedImplCopyWithImpl<$Res>
    extends _$SyncStatusCopyWithImpl<$Res, _$SyncStatus$FailedImpl>
    implements _$$SyncStatus$FailedImplCopyWith<$Res> {
  __$$SyncStatus$FailedImplCopyWithImpl(_$SyncStatus$FailedImpl _value,
      $Res Function(_$SyncStatus$FailedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? lastSyncedAt = freezed,
  }) {
    return _then(_$SyncStatus$FailedImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiException,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$SyncStatus$FailedImpl implements SyncStatus$Failed {
  const _$SyncStatus$FailedImpl({required this.error, this.lastSyncedAt});

  @override
  final ApiException error;
  @override
  final DateTime? lastSyncedAt;

  @override
  String toString() {
    return 'SyncStatus.failed(error: $error, lastSyncedAt: $lastSyncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncStatus$FailedImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, lastSyncedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncStatus$FailedImplCopyWith<_$SyncStatus$FailedImpl> get copyWith =>
      __$$SyncStatus$FailedImplCopyWithImpl<_$SyncStatus$FailedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime? lastSyncedAt) idle,
    required TResult Function(DateTime? lastSyncedAt) syncing,
    required TResult Function(DateTime? lastSyncedAt) offline,
    required TResult Function(ApiException error, DateTime? lastSyncedAt)
        failed,
  }) {
    return failed(error, lastSyncedAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime? lastSyncedAt)? idle,
    TResult? Function(DateTime? lastSyncedAt)? syncing,
    TResult? Function(DateTime? lastSyncedAt)? offline,
    TResult? Function(ApiException error, DateTime? lastSyncedAt)? failed,
  }) {
    return failed?.call(error, lastSyncedAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime? lastSyncedAt)? idle,
    TResult Function(DateTime? lastSyncedAt)? syncing,
    TResult Function(DateTime? lastSyncedAt)? offline,
    TResult Function(ApiException error, DateTime? lastSyncedAt)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(error, lastSyncedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SyncStatus$Idle value) idle,
    required TResult Function(SyncStatus$Syncing value) syncing,
    required TResult Function(SyncStatus$Offline value) offline,
    required TResult Function(SyncStatus$Failed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SyncStatus$Idle value)? idle,
    TResult? Function(SyncStatus$Syncing value)? syncing,
    TResult? Function(SyncStatus$Offline value)? offline,
    TResult? Function(SyncStatus$Failed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SyncStatus$Idle value)? idle,
    TResult Function(SyncStatus$Syncing value)? syncing,
    TResult Function(SyncStatus$Offline value)? offline,
    TResult Function(SyncStatus$Failed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class SyncStatus$Failed implements SyncStatus {
  const factory SyncStatus$Failed(
      {required final ApiException error,
      final DateTime? lastSyncedAt}) = _$SyncStatus$FailedImpl;

  ApiException get error;
  @override
  DateTime? get lastSyncedAt;
  @override
  @JsonKey(ignore: true)
  _$$SyncStatus$FailedImplCopyWith<_$SyncStatus$FailedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SyncState {
  SyncStatus get status => throw _privateConstructorUsedError;

  /// Конфликты, о которых ещё не сказали пользователю.
  List<SyncConflictReport> get conflicts => throw _privateConstructorUsedError;

  /// Итог последнего прогона.
  SyncRunResult? get lastRun => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SyncStateCopyWith<SyncState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncStateCopyWith<$Res> {
  factory $SyncStateCopyWith(SyncState value, $Res Function(SyncState) then) =
      _$SyncStateCopyWithImpl<$Res, SyncState>;
  @useResult
  $Res call(
      {SyncStatus status,
      List<SyncConflictReport> conflicts,
      SyncRunResult? lastRun});

  $SyncStatusCopyWith<$Res> get status;
}

/// @nodoc
class _$SyncStateCopyWithImpl<$Res, $Val extends SyncState>
    implements $SyncStateCopyWith<$Res> {
  _$SyncStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? conflicts = null,
    Object? lastRun = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatus,
      conflicts: null == conflicts
          ? _value.conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as List<SyncConflictReport>,
      lastRun: freezed == lastRun
          ? _value.lastRun
          : lastRun // ignore: cast_nullable_to_non_nullable
              as SyncRunResult?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SyncStatusCopyWith<$Res> get status {
    return $SyncStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SyncStateImplCopyWith<$Res>
    implements $SyncStateCopyWith<$Res> {
  factory _$$SyncStateImplCopyWith(
          _$SyncStateImpl value, $Res Function(_$SyncStateImpl) then) =
      __$$SyncStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SyncStatus status,
      List<SyncConflictReport> conflicts,
      SyncRunResult? lastRun});

  @override
  $SyncStatusCopyWith<$Res> get status;
}

/// @nodoc
class __$$SyncStateImplCopyWithImpl<$Res>
    extends _$SyncStateCopyWithImpl<$Res, _$SyncStateImpl>
    implements _$$SyncStateImplCopyWith<$Res> {
  __$$SyncStateImplCopyWithImpl(
      _$SyncStateImpl _value, $Res Function(_$SyncStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? conflicts = null,
    Object? lastRun = freezed,
  }) {
    return _then(_$SyncStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SyncStatus,
      conflicts: null == conflicts
          ? _value._conflicts
          : conflicts // ignore: cast_nullable_to_non_nullable
              as List<SyncConflictReport>,
      lastRun: freezed == lastRun
          ? _value.lastRun
          : lastRun // ignore: cast_nullable_to_non_nullable
              as SyncRunResult?,
    ));
  }
}

/// @nodoc

class _$SyncStateImpl implements _SyncState {
  const _$SyncStateImpl(
      {required this.status,
      final List<SyncConflictReport> conflicts = const <SyncConflictReport>[],
      this.lastRun})
      : _conflicts = conflicts;

  @override
  final SyncStatus status;

  /// Конфликты, о которых ещё не сказали пользователю.
  final List<SyncConflictReport> _conflicts;

  /// Конфликты, о которых ещё не сказали пользователю.
  @override
  @JsonKey()
  List<SyncConflictReport> get conflicts {
    if (_conflicts is EqualUnmodifiableListView) return _conflicts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conflicts);
  }

  /// Итог последнего прогона.
  @override
  final SyncRunResult? lastRun;

  @override
  String toString() {
    return 'SyncState(status: $status, conflicts: $conflicts, lastRun: $lastRun)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._conflicts, _conflicts) &&
            (identical(other.lastRun, lastRun) || other.lastRun == lastRun));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_conflicts), lastRun);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncStateImplCopyWith<_$SyncStateImpl> get copyWith =>
      __$$SyncStateImplCopyWithImpl<_$SyncStateImpl>(this, _$identity);
}

abstract class _SyncState implements SyncState {
  const factory _SyncState(
      {required final SyncStatus status,
      final List<SyncConflictReport> conflicts,
      final SyncRunResult? lastRun}) = _$SyncStateImpl;

  @override
  SyncStatus get status;
  @override

  /// Конфликты, о которых ещё не сказали пользователю.
  List<SyncConflictReport> get conflicts;
  @override

  /// Итог последнего прогона.
  SyncRunResult? get lastRun;
  @override
  @JsonKey(ignore: true)
  _$$SyncStateImplCopyWith<_$SyncStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
