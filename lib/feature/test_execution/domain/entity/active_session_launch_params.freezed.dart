// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_session_launch_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActiveSessionLaunchParams {

 bool get swapSides; int get answerIndex; bool get mixup; int get mixupMin; int get mixupMax; MixupAlgorithm get algorithm;
/// Create a copy of ActiveSessionLaunchParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveSessionLaunchParamsCopyWith<ActiveSessionLaunchParams> get copyWith => _$ActiveSessionLaunchParamsCopyWithImpl<ActiveSessionLaunchParams>(this as ActiveSessionLaunchParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveSessionLaunchParams&&(identical(other.swapSides, swapSides) || other.swapSides == swapSides)&&(identical(other.answerIndex, answerIndex) || other.answerIndex == answerIndex)&&(identical(other.mixup, mixup) || other.mixup == mixup)&&(identical(other.mixupMin, mixupMin) || other.mixupMin == mixupMin)&&(identical(other.mixupMax, mixupMax) || other.mixupMax == mixupMax)&&(identical(other.algorithm, algorithm) || other.algorithm == algorithm));
}


@override
int get hashCode => Object.hash(runtimeType,swapSides,answerIndex,mixup,mixupMin,mixupMax,algorithm);

@override
String toString() {
  return 'ActiveSessionLaunchParams(swapSides: $swapSides, answerIndex: $answerIndex, mixup: $mixup, mixupMin: $mixupMin, mixupMax: $mixupMax, algorithm: $algorithm)';
}


}

/// @nodoc
abstract mixin class $ActiveSessionLaunchParamsCopyWith<$Res>  {
  factory $ActiveSessionLaunchParamsCopyWith(ActiveSessionLaunchParams value, $Res Function(ActiveSessionLaunchParams) _then) = _$ActiveSessionLaunchParamsCopyWithImpl;
@useResult
$Res call({
 bool swapSides, int answerIndex, bool mixup, int mixupMin, int mixupMax, MixupAlgorithm algorithm
});




}
/// @nodoc
class _$ActiveSessionLaunchParamsCopyWithImpl<$Res>
    implements $ActiveSessionLaunchParamsCopyWith<$Res> {
  _$ActiveSessionLaunchParamsCopyWithImpl(this._self, this._then);

  final ActiveSessionLaunchParams _self;
  final $Res Function(ActiveSessionLaunchParams) _then;

/// Create a copy of ActiveSessionLaunchParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? swapSides = null,Object? answerIndex = null,Object? mixup = null,Object? mixupMin = null,Object? mixupMax = null,Object? algorithm = null,}) {
  return _then(_self.copyWith(
swapSides: null == swapSides ? _self.swapSides : swapSides // ignore: cast_nullable_to_non_nullable
as bool,answerIndex: null == answerIndex ? _self.answerIndex : answerIndex // ignore: cast_nullable_to_non_nullable
as int,mixup: null == mixup ? _self.mixup : mixup // ignore: cast_nullable_to_non_nullable
as bool,mixupMin: null == mixupMin ? _self.mixupMin : mixupMin // ignore: cast_nullable_to_non_nullable
as int,mixupMax: null == mixupMax ? _self.mixupMax : mixupMax // ignore: cast_nullable_to_non_nullable
as int,algorithm: null == algorithm ? _self.algorithm : algorithm // ignore: cast_nullable_to_non_nullable
as MixupAlgorithm,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveSessionLaunchParams].
extension ActiveSessionLaunchParamsPatterns on ActiveSessionLaunchParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveSessionLaunchParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveSessionLaunchParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveSessionLaunchParams value)  $default,){
final _that = this;
switch (_that) {
case _ActiveSessionLaunchParams():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveSessionLaunchParams value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveSessionLaunchParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool swapSides,  int answerIndex,  bool mixup,  int mixupMin,  int mixupMax,  MixupAlgorithm algorithm)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveSessionLaunchParams() when $default != null:
return $default(_that.swapSides,_that.answerIndex,_that.mixup,_that.mixupMin,_that.mixupMax,_that.algorithm);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool swapSides,  int answerIndex,  bool mixup,  int mixupMin,  int mixupMax,  MixupAlgorithm algorithm)  $default,) {final _that = this;
switch (_that) {
case _ActiveSessionLaunchParams():
return $default(_that.swapSides,_that.answerIndex,_that.mixup,_that.mixupMin,_that.mixupMax,_that.algorithm);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool swapSides,  int answerIndex,  bool mixup,  int mixupMin,  int mixupMax,  MixupAlgorithm algorithm)?  $default,) {final _that = this;
switch (_that) {
case _ActiveSessionLaunchParams() when $default != null:
return $default(_that.swapSides,_that.answerIndex,_that.mixup,_that.mixupMin,_that.mixupMax,_that.algorithm);case _:
  return null;

}
}

}

/// @nodoc


class _ActiveSessionLaunchParams implements ActiveSessionLaunchParams {
  const _ActiveSessionLaunchParams({required this.swapSides, required this.answerIndex, required this.mixup, required this.mixupMin, required this.mixupMax, required this.algorithm});
  

@override final  bool swapSides;
@override final  int answerIndex;
@override final  bool mixup;
@override final  int mixupMin;
@override final  int mixupMax;
@override final  MixupAlgorithm algorithm;

/// Create a copy of ActiveSessionLaunchParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveSessionLaunchParamsCopyWith<_ActiveSessionLaunchParams> get copyWith => __$ActiveSessionLaunchParamsCopyWithImpl<_ActiveSessionLaunchParams>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveSessionLaunchParams&&(identical(other.swapSides, swapSides) || other.swapSides == swapSides)&&(identical(other.answerIndex, answerIndex) || other.answerIndex == answerIndex)&&(identical(other.mixup, mixup) || other.mixup == mixup)&&(identical(other.mixupMin, mixupMin) || other.mixupMin == mixupMin)&&(identical(other.mixupMax, mixupMax) || other.mixupMax == mixupMax)&&(identical(other.algorithm, algorithm) || other.algorithm == algorithm));
}


@override
int get hashCode => Object.hash(runtimeType,swapSides,answerIndex,mixup,mixupMin,mixupMax,algorithm);

@override
String toString() {
  return 'ActiveSessionLaunchParams(swapSides: $swapSides, answerIndex: $answerIndex, mixup: $mixup, mixupMin: $mixupMin, mixupMax: $mixupMax, algorithm: $algorithm)';
}


}

/// @nodoc
abstract mixin class _$ActiveSessionLaunchParamsCopyWith<$Res> implements $ActiveSessionLaunchParamsCopyWith<$Res> {
  factory _$ActiveSessionLaunchParamsCopyWith(_ActiveSessionLaunchParams value, $Res Function(_ActiveSessionLaunchParams) _then) = __$ActiveSessionLaunchParamsCopyWithImpl;
@override @useResult
$Res call({
 bool swapSides, int answerIndex, bool mixup, int mixupMin, int mixupMax, MixupAlgorithm algorithm
});




}
/// @nodoc
class __$ActiveSessionLaunchParamsCopyWithImpl<$Res>
    implements _$ActiveSessionLaunchParamsCopyWith<$Res> {
  __$ActiveSessionLaunchParamsCopyWithImpl(this._self, this._then);

  final _ActiveSessionLaunchParams _self;
  final $Res Function(_ActiveSessionLaunchParams) _then;

/// Create a copy of ActiveSessionLaunchParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? swapSides = null,Object? answerIndex = null,Object? mixup = null,Object? mixupMin = null,Object? mixupMax = null,Object? algorithm = null,}) {
  return _then(_ActiveSessionLaunchParams(
swapSides: null == swapSides ? _self.swapSides : swapSides // ignore: cast_nullable_to_non_nullable
as bool,answerIndex: null == answerIndex ? _self.answerIndex : answerIndex // ignore: cast_nullable_to_non_nullable
as int,mixup: null == mixup ? _self.mixup : mixup // ignore: cast_nullable_to_non_nullable
as bool,mixupMin: null == mixupMin ? _self.mixupMin : mixupMin // ignore: cast_nullable_to_non_nullable
as int,mixupMax: null == mixupMax ? _self.mixupMax : mixupMax // ignore: cast_nullable_to_non_nullable
as int,algorithm: null == algorithm ? _self.algorithm : algorithm // ignore: cast_nullable_to_non_nullable
as MixupAlgorithm,
  ));
}


}

// dart format on
