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
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool enabled) toggled,
    required TResult Function(int min, int max) rangeChanged,
    required TResult Function(MixupAlgorithm algorithm) algorithmChanged,
    required TResult Function(double negativeBonus, double positivePenalty)
        streakCoefficientsChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool enabled)? toggled,
    TResult? Function(int min, int max)? rangeChanged,
    TResult? Function(MixupAlgorithm algorithm)? algorithmChanged,
    TResult? Function(double negativeBonus, double positivePenalty)?
        streakCoefficientsChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool enabled)? toggled,
    TResult Function(int min, int max)? rangeChanged,
    TResult Function(MixupAlgorithm algorithm)? algorithmChanged,
    TResult Function(double negativeBonus, double positivePenalty)?
        streakCoefficientsChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MixupEvent$Toggled value) toggled,
    required TResult Function(_MixupEvent$RangeChanged value) rangeChanged,
    required TResult Function(_MixupEvent$AlgorithmChanged value)
        algorithmChanged,
    required TResult Function(_MixupEvent$StreakCoefficientsChanged value)
        streakCoefficientsChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MixupEvent$Toggled value)? toggled,
    TResult? Function(_MixupEvent$RangeChanged value)? rangeChanged,
    TResult? Function(_MixupEvent$AlgorithmChanged value)? algorithmChanged,
    TResult? Function(_MixupEvent$StreakCoefficientsChanged value)?
        streakCoefficientsChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MixupEvent$Toggled value)? toggled,
    TResult Function(_MixupEvent$RangeChanged value)? rangeChanged,
    TResult Function(_MixupEvent$AlgorithmChanged value)? algorithmChanged,
    TResult Function(_MixupEvent$StreakCoefficientsChanged value)?
        streakCoefficientsChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MixupEventCopyWith<$Res> {
  factory $MixupEventCopyWith(
          MixupEvent value, $Res Function(MixupEvent) then) =
      _$MixupEventCopyWithImpl<$Res, MixupEvent>;
}

/// @nodoc
class _$MixupEventCopyWithImpl<$Res, $Val extends MixupEvent>
    implements $MixupEventCopyWith<$Res> {
  _$MixupEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MixupEvent$ToggledImplCopyWith<$Res> {
  factory _$$MixupEvent$ToggledImplCopyWith(_$MixupEvent$ToggledImpl value,
          $Res Function(_$MixupEvent$ToggledImpl) then) =
      __$$MixupEvent$ToggledImplCopyWithImpl<$Res>;
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
    required TResult Function(int min, int max) rangeChanged,
    required TResult Function(MixupAlgorithm algorithm) algorithmChanged,
    required TResult Function(double negativeBonus, double positivePenalty)
        streakCoefficientsChanged,
  }) {
    return toggled(enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool enabled)? toggled,
    TResult? Function(int min, int max)? rangeChanged,
    TResult? Function(MixupAlgorithm algorithm)? algorithmChanged,
    TResult? Function(double negativeBonus, double positivePenalty)?
        streakCoefficientsChanged,
  }) {
    return toggled?.call(enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool enabled)? toggled,
    TResult Function(int min, int max)? rangeChanged,
    TResult Function(MixupAlgorithm algorithm)? algorithmChanged,
    TResult Function(double negativeBonus, double positivePenalty)?
        streakCoefficientsChanged,
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
    required TResult Function(_MixupEvent$RangeChanged value) rangeChanged,
    required TResult Function(_MixupEvent$AlgorithmChanged value)
        algorithmChanged,
    required TResult Function(_MixupEvent$StreakCoefficientsChanged value)
        streakCoefficientsChanged,
  }) {
    return toggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MixupEvent$Toggled value)? toggled,
    TResult? Function(_MixupEvent$RangeChanged value)? rangeChanged,
    TResult? Function(_MixupEvent$AlgorithmChanged value)? algorithmChanged,
    TResult? Function(_MixupEvent$StreakCoefficientsChanged value)?
        streakCoefficientsChanged,
  }) {
    return toggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MixupEvent$Toggled value)? toggled,
    TResult Function(_MixupEvent$RangeChanged value)? rangeChanged,
    TResult Function(_MixupEvent$AlgorithmChanged value)? algorithmChanged,
    TResult Function(_MixupEvent$StreakCoefficientsChanged value)?
        streakCoefficientsChanged,
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

  bool get enabled;
  @JsonKey(ignore: true)
  _$$MixupEvent$ToggledImplCopyWith<_$MixupEvent$ToggledImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MixupEvent$RangeChangedImplCopyWith<$Res> {
  factory _$$MixupEvent$RangeChangedImplCopyWith(
          _$MixupEvent$RangeChangedImpl value,
          $Res Function(_$MixupEvent$RangeChangedImpl) then) =
      __$$MixupEvent$RangeChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int min, int max});
}

/// @nodoc
class __$$MixupEvent$RangeChangedImplCopyWithImpl<$Res>
    extends _$MixupEventCopyWithImpl<$Res, _$MixupEvent$RangeChangedImpl>
    implements _$$MixupEvent$RangeChangedImplCopyWith<$Res> {
  __$$MixupEvent$RangeChangedImplCopyWithImpl(
      _$MixupEvent$RangeChangedImpl _value,
      $Res Function(_$MixupEvent$RangeChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
  }) {
    return _then(_$MixupEvent$RangeChangedImpl(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as int,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MixupEvent$RangeChangedImpl implements _MixupEvent$RangeChanged {
  const _$MixupEvent$RangeChangedImpl({required this.min, required this.max});

  @override
  final int min;
  @override
  final int max;

  @override
  String toString() {
    return 'MixupEvent.rangeChanged(min: $min, max: $max)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MixupEvent$RangeChangedImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max));
  }

  @override
  int get hashCode => Object.hash(runtimeType, min, max);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MixupEvent$RangeChangedImplCopyWith<_$MixupEvent$RangeChangedImpl>
      get copyWith => __$$MixupEvent$RangeChangedImplCopyWithImpl<
          _$MixupEvent$RangeChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool enabled) toggled,
    required TResult Function(int min, int max) rangeChanged,
    required TResult Function(MixupAlgorithm algorithm) algorithmChanged,
    required TResult Function(double negativeBonus, double positivePenalty)
        streakCoefficientsChanged,
  }) {
    return rangeChanged(min, max);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool enabled)? toggled,
    TResult? Function(int min, int max)? rangeChanged,
    TResult? Function(MixupAlgorithm algorithm)? algorithmChanged,
    TResult? Function(double negativeBonus, double positivePenalty)?
        streakCoefficientsChanged,
  }) {
    return rangeChanged?.call(min, max);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool enabled)? toggled,
    TResult Function(int min, int max)? rangeChanged,
    TResult Function(MixupAlgorithm algorithm)? algorithmChanged,
    TResult Function(double negativeBonus, double positivePenalty)?
        streakCoefficientsChanged,
    required TResult orElse(),
  }) {
    if (rangeChanged != null) {
      return rangeChanged(min, max);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MixupEvent$Toggled value) toggled,
    required TResult Function(_MixupEvent$RangeChanged value) rangeChanged,
    required TResult Function(_MixupEvent$AlgorithmChanged value)
        algorithmChanged,
    required TResult Function(_MixupEvent$StreakCoefficientsChanged value)
        streakCoefficientsChanged,
  }) {
    return rangeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MixupEvent$Toggled value)? toggled,
    TResult? Function(_MixupEvent$RangeChanged value)? rangeChanged,
    TResult? Function(_MixupEvent$AlgorithmChanged value)? algorithmChanged,
    TResult? Function(_MixupEvent$StreakCoefficientsChanged value)?
        streakCoefficientsChanged,
  }) {
    return rangeChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MixupEvent$Toggled value)? toggled,
    TResult Function(_MixupEvent$RangeChanged value)? rangeChanged,
    TResult Function(_MixupEvent$AlgorithmChanged value)? algorithmChanged,
    TResult Function(_MixupEvent$StreakCoefficientsChanged value)?
        streakCoefficientsChanged,
    required TResult orElse(),
  }) {
    if (rangeChanged != null) {
      return rangeChanged(this);
    }
    return orElse();
  }
}

abstract class _MixupEvent$RangeChanged implements MixupEvent {
  const factory _MixupEvent$RangeChanged(
      {required final int min,
      required final int max}) = _$MixupEvent$RangeChangedImpl;

  int get min;
  int get max;
  @JsonKey(ignore: true)
  _$$MixupEvent$RangeChangedImplCopyWith<_$MixupEvent$RangeChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MixupEvent$AlgorithmChangedImplCopyWith<$Res> {
  factory _$$MixupEvent$AlgorithmChangedImplCopyWith(
          _$MixupEvent$AlgorithmChangedImpl value,
          $Res Function(_$MixupEvent$AlgorithmChangedImpl) then) =
      __$$MixupEvent$AlgorithmChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MixupAlgorithm algorithm});
}

/// @nodoc
class __$$MixupEvent$AlgorithmChangedImplCopyWithImpl<$Res>
    extends _$MixupEventCopyWithImpl<$Res, _$MixupEvent$AlgorithmChangedImpl>
    implements _$$MixupEvent$AlgorithmChangedImplCopyWith<$Res> {
  __$$MixupEvent$AlgorithmChangedImplCopyWithImpl(
      _$MixupEvent$AlgorithmChangedImpl _value,
      $Res Function(_$MixupEvent$AlgorithmChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? algorithm = null,
  }) {
    return _then(_$MixupEvent$AlgorithmChangedImpl(
      algorithm: null == algorithm
          ? _value.algorithm
          : algorithm // ignore: cast_nullable_to_non_nullable
              as MixupAlgorithm,
    ));
  }
}

/// @nodoc

class _$MixupEvent$AlgorithmChangedImpl
    implements _MixupEvent$AlgorithmChanged {
  const _$MixupEvent$AlgorithmChangedImpl({required this.algorithm});

  @override
  final MixupAlgorithm algorithm;

  @override
  String toString() {
    return 'MixupEvent.algorithmChanged(algorithm: $algorithm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MixupEvent$AlgorithmChangedImpl &&
            (identical(other.algorithm, algorithm) ||
                other.algorithm == algorithm));
  }

  @override
  int get hashCode => Object.hash(runtimeType, algorithm);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MixupEvent$AlgorithmChangedImplCopyWith<_$MixupEvent$AlgorithmChangedImpl>
      get copyWith => __$$MixupEvent$AlgorithmChangedImplCopyWithImpl<
          _$MixupEvent$AlgorithmChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool enabled) toggled,
    required TResult Function(int min, int max) rangeChanged,
    required TResult Function(MixupAlgorithm algorithm) algorithmChanged,
    required TResult Function(double negativeBonus, double positivePenalty)
        streakCoefficientsChanged,
  }) {
    return algorithmChanged(algorithm);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool enabled)? toggled,
    TResult? Function(int min, int max)? rangeChanged,
    TResult? Function(MixupAlgorithm algorithm)? algorithmChanged,
    TResult? Function(double negativeBonus, double positivePenalty)?
        streakCoefficientsChanged,
  }) {
    return algorithmChanged?.call(algorithm);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool enabled)? toggled,
    TResult Function(int min, int max)? rangeChanged,
    TResult Function(MixupAlgorithm algorithm)? algorithmChanged,
    TResult Function(double negativeBonus, double positivePenalty)?
        streakCoefficientsChanged,
    required TResult orElse(),
  }) {
    if (algorithmChanged != null) {
      return algorithmChanged(algorithm);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MixupEvent$Toggled value) toggled,
    required TResult Function(_MixupEvent$RangeChanged value) rangeChanged,
    required TResult Function(_MixupEvent$AlgorithmChanged value)
        algorithmChanged,
    required TResult Function(_MixupEvent$StreakCoefficientsChanged value)
        streakCoefficientsChanged,
  }) {
    return algorithmChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MixupEvent$Toggled value)? toggled,
    TResult? Function(_MixupEvent$RangeChanged value)? rangeChanged,
    TResult? Function(_MixupEvent$AlgorithmChanged value)? algorithmChanged,
    TResult? Function(_MixupEvent$StreakCoefficientsChanged value)?
        streakCoefficientsChanged,
  }) {
    return algorithmChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MixupEvent$Toggled value)? toggled,
    TResult Function(_MixupEvent$RangeChanged value)? rangeChanged,
    TResult Function(_MixupEvent$AlgorithmChanged value)? algorithmChanged,
    TResult Function(_MixupEvent$StreakCoefficientsChanged value)?
        streakCoefficientsChanged,
    required TResult orElse(),
  }) {
    if (algorithmChanged != null) {
      return algorithmChanged(this);
    }
    return orElse();
  }
}

abstract class _MixupEvent$AlgorithmChanged implements MixupEvent {
  const factory _MixupEvent$AlgorithmChanged(
          {required final MixupAlgorithm algorithm}) =
      _$MixupEvent$AlgorithmChangedImpl;

  MixupAlgorithm get algorithm;
  @JsonKey(ignore: true)
  _$$MixupEvent$AlgorithmChangedImplCopyWith<_$MixupEvent$AlgorithmChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MixupEvent$StreakCoefficientsChangedImplCopyWith<$Res> {
  factory _$$MixupEvent$StreakCoefficientsChangedImplCopyWith(
          _$MixupEvent$StreakCoefficientsChangedImpl value,
          $Res Function(_$MixupEvent$StreakCoefficientsChangedImpl) then) =
      __$$MixupEvent$StreakCoefficientsChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double negativeBonus, double positivePenalty});
}

/// @nodoc
class __$$MixupEvent$StreakCoefficientsChangedImplCopyWithImpl<$Res>
    extends _$MixupEventCopyWithImpl<$Res,
        _$MixupEvent$StreakCoefficientsChangedImpl>
    implements _$$MixupEvent$StreakCoefficientsChangedImplCopyWith<$Res> {
  __$$MixupEvent$StreakCoefficientsChangedImplCopyWithImpl(
      _$MixupEvent$StreakCoefficientsChangedImpl _value,
      $Res Function(_$MixupEvent$StreakCoefficientsChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? negativeBonus = null,
    Object? positivePenalty = null,
  }) {
    return _then(_$MixupEvent$StreakCoefficientsChangedImpl(
      negativeBonus: null == negativeBonus
          ? _value.negativeBonus
          : negativeBonus // ignore: cast_nullable_to_non_nullable
              as double,
      positivePenalty: null == positivePenalty
          ? _value.positivePenalty
          : positivePenalty // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$MixupEvent$StreakCoefficientsChangedImpl
    implements _MixupEvent$StreakCoefficientsChanged {
  const _$MixupEvent$StreakCoefficientsChangedImpl(
      {required this.negativeBonus, required this.positivePenalty});

  @override
  final double negativeBonus;
  @override
  final double positivePenalty;

  @override
  String toString() {
    return 'MixupEvent.streakCoefficientsChanged(negativeBonus: $negativeBonus, positivePenalty: $positivePenalty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MixupEvent$StreakCoefficientsChangedImpl &&
            (identical(other.negativeBonus, negativeBonus) ||
                other.negativeBonus == negativeBonus) &&
            (identical(other.positivePenalty, positivePenalty) ||
                other.positivePenalty == positivePenalty));
  }

  @override
  int get hashCode => Object.hash(runtimeType, negativeBonus, positivePenalty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MixupEvent$StreakCoefficientsChangedImplCopyWith<
          _$MixupEvent$StreakCoefficientsChangedImpl>
      get copyWith => __$$MixupEvent$StreakCoefficientsChangedImplCopyWithImpl<
          _$MixupEvent$StreakCoefficientsChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool enabled) toggled,
    required TResult Function(int min, int max) rangeChanged,
    required TResult Function(MixupAlgorithm algorithm) algorithmChanged,
    required TResult Function(double negativeBonus, double positivePenalty)
        streakCoefficientsChanged,
  }) {
    return streakCoefficientsChanged(negativeBonus, positivePenalty);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool enabled)? toggled,
    TResult? Function(int min, int max)? rangeChanged,
    TResult? Function(MixupAlgorithm algorithm)? algorithmChanged,
    TResult? Function(double negativeBonus, double positivePenalty)?
        streakCoefficientsChanged,
  }) {
    return streakCoefficientsChanged?.call(negativeBonus, positivePenalty);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool enabled)? toggled,
    TResult Function(int min, int max)? rangeChanged,
    TResult Function(MixupAlgorithm algorithm)? algorithmChanged,
    TResult Function(double negativeBonus, double positivePenalty)?
        streakCoefficientsChanged,
    required TResult orElse(),
  }) {
    if (streakCoefficientsChanged != null) {
      return streakCoefficientsChanged(negativeBonus, positivePenalty);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MixupEvent$Toggled value) toggled,
    required TResult Function(_MixupEvent$RangeChanged value) rangeChanged,
    required TResult Function(_MixupEvent$AlgorithmChanged value)
        algorithmChanged,
    required TResult Function(_MixupEvent$StreakCoefficientsChanged value)
        streakCoefficientsChanged,
  }) {
    return streakCoefficientsChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MixupEvent$Toggled value)? toggled,
    TResult? Function(_MixupEvent$RangeChanged value)? rangeChanged,
    TResult? Function(_MixupEvent$AlgorithmChanged value)? algorithmChanged,
    TResult? Function(_MixupEvent$StreakCoefficientsChanged value)?
        streakCoefficientsChanged,
  }) {
    return streakCoefficientsChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MixupEvent$Toggled value)? toggled,
    TResult Function(_MixupEvent$RangeChanged value)? rangeChanged,
    TResult Function(_MixupEvent$AlgorithmChanged value)? algorithmChanged,
    TResult Function(_MixupEvent$StreakCoefficientsChanged value)?
        streakCoefficientsChanged,
    required TResult orElse(),
  }) {
    if (streakCoefficientsChanged != null) {
      return streakCoefficientsChanged(this);
    }
    return orElse();
  }
}

abstract class _MixupEvent$StreakCoefficientsChanged implements MixupEvent {
  const factory _MixupEvent$StreakCoefficientsChanged(
          {required final double negativeBonus,
          required final double positivePenalty}) =
      _$MixupEvent$StreakCoefficientsChangedImpl;

  double get negativeBonus;
  double get positivePenalty;
  @JsonKey(ignore: true)
  _$$MixupEvent$StreakCoefficientsChangedImplCopyWith<
          _$MixupEvent$StreakCoefficientsChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MixupState {
  bool get enabled => throw _privateConstructorUsedError;
  int get mixupMin => throw _privateConstructorUsedError;
  int get mixupMax => throw _privateConstructorUsedError;
  MixupAlgorithm get algorithm => throw _privateConstructorUsedError;
  double get streakNegativeBonus => throw _privateConstructorUsedError;
  double get streakPositivePenalty => throw _privateConstructorUsedError;

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
  $Res call(
      {bool enabled,
      int mixupMin,
      int mixupMax,
      MixupAlgorithm algorithm,
      double streakNegativeBonus,
      double streakPositivePenalty});
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
    Object? mixupMin = null,
    Object? mixupMax = null,
    Object? algorithm = null,
    Object? streakNegativeBonus = null,
    Object? streakPositivePenalty = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      mixupMin: null == mixupMin
          ? _value.mixupMin
          : mixupMin // ignore: cast_nullable_to_non_nullable
              as int,
      mixupMax: null == mixupMax
          ? _value.mixupMax
          : mixupMax // ignore: cast_nullable_to_non_nullable
              as int,
      algorithm: null == algorithm
          ? _value.algorithm
          : algorithm // ignore: cast_nullable_to_non_nullable
              as MixupAlgorithm,
      streakNegativeBonus: null == streakNegativeBonus
          ? _value.streakNegativeBonus
          : streakNegativeBonus // ignore: cast_nullable_to_non_nullable
              as double,
      streakPositivePenalty: null == streakPositivePenalty
          ? _value.streakPositivePenalty
          : streakPositivePenalty // ignore: cast_nullable_to_non_nullable
              as double,
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
  $Res call(
      {bool enabled,
      int mixupMin,
      int mixupMax,
      MixupAlgorithm algorithm,
      double streakNegativeBonus,
      double streakPositivePenalty});
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
    Object? mixupMin = null,
    Object? mixupMax = null,
    Object? algorithm = null,
    Object? streakNegativeBonus = null,
    Object? streakPositivePenalty = null,
  }) {
    return _then(_$MixupStateImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      mixupMin: null == mixupMin
          ? _value.mixupMin
          : mixupMin // ignore: cast_nullable_to_non_nullable
              as int,
      mixupMax: null == mixupMax
          ? _value.mixupMax
          : mixupMax // ignore: cast_nullable_to_non_nullable
              as int,
      algorithm: null == algorithm
          ? _value.algorithm
          : algorithm // ignore: cast_nullable_to_non_nullable
              as MixupAlgorithm,
      streakNegativeBonus: null == streakNegativeBonus
          ? _value.streakNegativeBonus
          : streakNegativeBonus // ignore: cast_nullable_to_non_nullable
              as double,
      streakPositivePenalty: null == streakPositivePenalty
          ? _value.streakPositivePenalty
          : streakPositivePenalty // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$MixupStateImpl implements _MixupState {
  const _$MixupStateImpl(
      {this.enabled = false,
      this.mixupMin = 1,
      this.mixupMax = 5,
      this.algorithm = MixupAlgorithm.classic,
      this.streakNegativeBonus = 0.35,
      this.streakPositivePenalty = 0.35});

  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final int mixupMin;
  @override
  @JsonKey()
  final int mixupMax;
  @override
  @JsonKey()
  final MixupAlgorithm algorithm;
  @override
  @JsonKey()
  final double streakNegativeBonus;
  @override
  @JsonKey()
  final double streakPositivePenalty;

  @override
  String toString() {
    return 'MixupState(enabled: $enabled, mixupMin: $mixupMin, mixupMax: $mixupMax, algorithm: $algorithm, streakNegativeBonus: $streakNegativeBonus, streakPositivePenalty: $streakPositivePenalty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MixupStateImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.mixupMin, mixupMin) ||
                other.mixupMin == mixupMin) &&
            (identical(other.mixupMax, mixupMax) ||
                other.mixupMax == mixupMax) &&
            (identical(other.algorithm, algorithm) ||
                other.algorithm == algorithm) &&
            (identical(other.streakNegativeBonus, streakNegativeBonus) ||
                other.streakNegativeBonus == streakNegativeBonus) &&
            (identical(other.streakPositivePenalty, streakPositivePenalty) ||
                other.streakPositivePenalty == streakPositivePenalty));
  }

  @override
  int get hashCode => Object.hash(runtimeType, enabled, mixupMin, mixupMax,
      algorithm, streakNegativeBonus, streakPositivePenalty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MixupStateImplCopyWith<_$MixupStateImpl> get copyWith =>
      __$$MixupStateImplCopyWithImpl<_$MixupStateImpl>(this, _$identity);
}

abstract class _MixupState implements MixupState {
  const factory _MixupState(
      {final bool enabled,
      final int mixupMin,
      final int mixupMax,
      final MixupAlgorithm algorithm,
      final double streakNegativeBonus,
      final double streakPositivePenalty}) = _$MixupStateImpl;

  @override
  bool get enabled;
  @override
  int get mixupMin;
  @override
  int get mixupMax;
  @override
  MixupAlgorithm get algorithm;
  @override
  double get streakNegativeBonus;
  @override
  double get streakPositivePenalty;
  @override
  @JsonKey(ignore: true)
  _$$MixupStateImplCopyWith<_$MixupStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
