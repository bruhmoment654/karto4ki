// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_session_launch_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ActiveSessionLaunchParams {
  bool get swapSides => throw _privateConstructorUsedError;
  int get answerIndex => throw _privateConstructorUsedError;
  bool get mixup => throw _privateConstructorUsedError;
  int get mixupMin => throw _privateConstructorUsedError;
  int get mixupMax => throw _privateConstructorUsedError;
  MixupAlgorithm get algorithm => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActiveSessionLaunchParamsCopyWith<ActiveSessionLaunchParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveSessionLaunchParamsCopyWith<$Res> {
  factory $ActiveSessionLaunchParamsCopyWith(ActiveSessionLaunchParams value,
          $Res Function(ActiveSessionLaunchParams) then) =
      _$ActiveSessionLaunchParamsCopyWithImpl<$Res, ActiveSessionLaunchParams>;
  @useResult
  $Res call(
      {bool swapSides,
      int answerIndex,
      bool mixup,
      int mixupMin,
      int mixupMax,
      MixupAlgorithm algorithm});
}

/// @nodoc
class _$ActiveSessionLaunchParamsCopyWithImpl<$Res,
        $Val extends ActiveSessionLaunchParams>
    implements $ActiveSessionLaunchParamsCopyWith<$Res> {
  _$ActiveSessionLaunchParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swapSides = null,
    Object? answerIndex = null,
    Object? mixup = null,
    Object? mixupMin = null,
    Object? mixupMax = null,
    Object? algorithm = null,
  }) {
    return _then(_value.copyWith(
      swapSides: null == swapSides
          ? _value.swapSides
          : swapSides // ignore: cast_nullable_to_non_nullable
              as bool,
      answerIndex: null == answerIndex
          ? _value.answerIndex
          : answerIndex // ignore: cast_nullable_to_non_nullable
              as int,
      mixup: null == mixup
          ? _value.mixup
          : mixup // ignore: cast_nullable_to_non_nullable
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActiveSessionLaunchParamsImplCopyWith<$Res>
    implements $ActiveSessionLaunchParamsCopyWith<$Res> {
  factory _$$ActiveSessionLaunchParamsImplCopyWith(
          _$ActiveSessionLaunchParamsImpl value,
          $Res Function(_$ActiveSessionLaunchParamsImpl) then) =
      __$$ActiveSessionLaunchParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool swapSides,
      int answerIndex,
      bool mixup,
      int mixupMin,
      int mixupMax,
      MixupAlgorithm algorithm});
}

/// @nodoc
class __$$ActiveSessionLaunchParamsImplCopyWithImpl<$Res>
    extends _$ActiveSessionLaunchParamsCopyWithImpl<$Res,
        _$ActiveSessionLaunchParamsImpl>
    implements _$$ActiveSessionLaunchParamsImplCopyWith<$Res> {
  __$$ActiveSessionLaunchParamsImplCopyWithImpl(
      _$ActiveSessionLaunchParamsImpl _value,
      $Res Function(_$ActiveSessionLaunchParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? swapSides = null,
    Object? answerIndex = null,
    Object? mixup = null,
    Object? mixupMin = null,
    Object? mixupMax = null,
    Object? algorithm = null,
  }) {
    return _then(_$ActiveSessionLaunchParamsImpl(
      swapSides: null == swapSides
          ? _value.swapSides
          : swapSides // ignore: cast_nullable_to_non_nullable
              as bool,
      answerIndex: null == answerIndex
          ? _value.answerIndex
          : answerIndex // ignore: cast_nullable_to_non_nullable
              as int,
      mixup: null == mixup
          ? _value.mixup
          : mixup // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc

class _$ActiveSessionLaunchParamsImpl implements _ActiveSessionLaunchParams {
  const _$ActiveSessionLaunchParamsImpl(
      {required this.swapSides,
      required this.answerIndex,
      required this.mixup,
      required this.mixupMin,
      required this.mixupMax,
      required this.algorithm});

  @override
  final bool swapSides;
  @override
  final int answerIndex;
  @override
  final bool mixup;
  @override
  final int mixupMin;
  @override
  final int mixupMax;
  @override
  final MixupAlgorithm algorithm;

  @override
  String toString() {
    return 'ActiveSessionLaunchParams(swapSides: $swapSides, answerIndex: $answerIndex, mixup: $mixup, mixupMin: $mixupMin, mixupMax: $mixupMax, algorithm: $algorithm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveSessionLaunchParamsImpl &&
            (identical(other.swapSides, swapSides) ||
                other.swapSides == swapSides) &&
            (identical(other.answerIndex, answerIndex) ||
                other.answerIndex == answerIndex) &&
            (identical(other.mixup, mixup) || other.mixup == mixup) &&
            (identical(other.mixupMin, mixupMin) ||
                other.mixupMin == mixupMin) &&
            (identical(other.mixupMax, mixupMax) ||
                other.mixupMax == mixupMax) &&
            (identical(other.algorithm, algorithm) ||
                other.algorithm == algorithm));
  }

  @override
  int get hashCode => Object.hash(runtimeType, swapSides, answerIndex, mixup,
      mixupMin, mixupMax, algorithm);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveSessionLaunchParamsImplCopyWith<_$ActiveSessionLaunchParamsImpl>
      get copyWith => __$$ActiveSessionLaunchParamsImplCopyWithImpl<
          _$ActiveSessionLaunchParamsImpl>(this, _$identity);
}

abstract class _ActiveSessionLaunchParams implements ActiveSessionLaunchParams {
  const factory _ActiveSessionLaunchParams(
          {required final bool swapSides,
          required final int answerIndex,
          required final bool mixup,
          required final int mixupMin,
          required final int mixupMax,
          required final MixupAlgorithm algorithm}) =
      _$ActiveSessionLaunchParamsImpl;

  @override
  bool get swapSides;
  @override
  int get answerIndex;
  @override
  bool get mixup;
  @override
  int get mixupMin;
  @override
  int get mixupMax;
  @override
  MixupAlgorithm get algorithm;
  @override
  @JsonKey(ignore: true)
  _$$ActiveSessionLaunchParamsImplCopyWith<_$ActiveSessionLaunchParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
