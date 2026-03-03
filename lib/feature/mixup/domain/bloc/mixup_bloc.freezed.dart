// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mixup_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MixupEvent {
  bool get enabled => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool enabled) toggled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool enabled)? toggled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool enabled)? toggled,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MixupEvent$Toggled value) toggled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MixupEvent$Toggled value)? toggled,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MixupEvent$Toggled value)? toggled,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MixupEventCopyWith<MixupEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MixupEventCopyWith<$Res> {
  factory $MixupEventCopyWith(
          MixupEvent value, $Res Function(MixupEvent) then) =
      _$MixupEventCopyWithImpl<$Res, MixupEvent>;
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class _$MixupEventCopyWithImpl<$Res, $Val extends MixupEvent>
    implements $MixupEventCopyWith<$Res> {
  _$MixupEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MixupEvent$ToggledImplCopyWith<$Res>
    implements $MixupEventCopyWith<$Res> {
  factory _$$MixupEvent$ToggledImplCopyWith(_$MixupEvent$ToggledImpl value,
          $Res Function(_$MixupEvent$ToggledImpl) then) =
      __$$MixupEvent$ToggledImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class __$$MixupEvent$ToggledImplCopyWithImpl<$Res>
    extends _$MixupEventCopyWithImpl<$Res, _$MixupEvent$ToggledImpl>
    implements _$$MixupEvent$ToggledImplCopyWith<$Res> {
  __$$MixupEvent$ToggledImplCopyWithImpl(_$MixupEvent$ToggledImpl _value,
      $Res Function(_$MixupEvent$ToggledImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
  }) {
    return _then(_$MixupEvent$ToggledImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MixupEvent$ToggledImpl implements _MixupEvent$Toggled {
  const _$MixupEvent$ToggledImpl({required this.enabled});

  @override
  final bool enabled;

  @override
  String toString() {
    return 'MixupEvent.toggled(enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MixupEvent$ToggledImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MixupEvent$ToggledImplCopyWith<_$MixupEvent$ToggledImpl> get copyWith =>
      __$$MixupEvent$ToggledImplCopyWithImpl<_$MixupEvent$ToggledImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool enabled) toggled,
  }) {
    return toggled(enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool enabled)? toggled,
  }) {
    return toggled?.call(enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool enabled)? toggled,
    required TResult orElse(),
  }) {
    if (toggled != null) {
      return toggled(enabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MixupEvent$Toggled value) toggled,
  }) {
    return toggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MixupEvent$Toggled value)? toggled,
  }) {
    return toggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MixupEvent$Toggled value)? toggled,
    required TResult orElse(),
  }) {
    if (toggled != null) {
      return toggled(this);
    }
    return orElse();
  }
}

abstract class _MixupEvent$Toggled implements MixupEvent {
  const factory _MixupEvent$Toggled({required final bool enabled}) =
      _$MixupEvent$ToggledImpl;

  @override
  bool get enabled;
  @override
  @JsonKey(ignore: true)
  _$$MixupEvent$ToggledImplCopyWith<_$MixupEvent$ToggledImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MixupState {
  bool get enabled => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MixupStateCopyWith<MixupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MixupStateCopyWith<$Res> {
  factory $MixupStateCopyWith(
          MixupState value, $Res Function(MixupState) then) =
      _$MixupStateCopyWithImpl<$Res, MixupState>;
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class _$MixupStateCopyWithImpl<$Res, $Val extends MixupState>
    implements $MixupStateCopyWith<$Res> {
  _$MixupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MixupStateImplCopyWith<$Res>
    implements $MixupStateCopyWith<$Res> {
  factory _$$MixupStateImplCopyWith(
          _$MixupStateImpl value, $Res Function(_$MixupStateImpl) then) =
      __$$MixupStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool enabled});
}

/// @nodoc
class __$$MixupStateImplCopyWithImpl<$Res>
    extends _$MixupStateCopyWithImpl<$Res, _$MixupStateImpl>
    implements _$$MixupStateImplCopyWith<$Res> {
  __$$MixupStateImplCopyWithImpl(
      _$MixupStateImpl _value, $Res Function(_$MixupStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
  }) {
    return _then(_$MixupStateImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MixupStateImpl implements _MixupState {
  const _$MixupStateImpl({this.enabled = false});

  @override
  @JsonKey()
  final bool enabled;

  @override
  String toString() {
    return 'MixupState(enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MixupStateImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, enabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MixupStateImplCopyWith<_$MixupStateImpl> get copyWith =>
      __$$MixupStateImplCopyWithImpl<_$MixupStateImpl>(this, _$identity);
}

abstract class _MixupState implements MixupState {
  const factory _MixupState({final bool enabled}) = _$MixupStateImpl;

  @override
  bool get enabled;
  @override
  @JsonKey(ignore: true)
  _$$MixupStateImplCopyWith<_$MixupStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
