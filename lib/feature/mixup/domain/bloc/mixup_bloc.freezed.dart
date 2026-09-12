// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mixup_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MixupEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MixupEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MixupEvent()';
}


}

/// @nodoc
class $MixupEventCopyWith<$Res>  {
$MixupEventCopyWith(MixupEvent _, $Res Function(MixupEvent) __);
}


/// Adds pattern-matching-related methods to [MixupEvent].
extension MixupEventPatterns on MixupEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _MixupEvent$Toggled value)?  toggled,TResult Function( _MixupEvent$RangeChanged value)?  rangeChanged,TResult Function( _MixupEvent$AlgorithmChanged value)?  algorithmChanged,TResult Function( _MixupEvent$StreakCoefficientsChanged value)?  streakCoefficientsChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MixupEvent$Toggled() when toggled != null:
return toggled(_that);case _MixupEvent$RangeChanged() when rangeChanged != null:
return rangeChanged(_that);case _MixupEvent$AlgorithmChanged() when algorithmChanged != null:
return algorithmChanged(_that);case _MixupEvent$StreakCoefficientsChanged() when streakCoefficientsChanged != null:
return streakCoefficientsChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _MixupEvent$Toggled value)  toggled,required TResult Function( _MixupEvent$RangeChanged value)  rangeChanged,required TResult Function( _MixupEvent$AlgorithmChanged value)  algorithmChanged,required TResult Function( _MixupEvent$StreakCoefficientsChanged value)  streakCoefficientsChanged,}){
final _that = this;
switch (_that) {
case _MixupEvent$Toggled():
return toggled(_that);case _MixupEvent$RangeChanged():
return rangeChanged(_that);case _MixupEvent$AlgorithmChanged():
return algorithmChanged(_that);case _MixupEvent$StreakCoefficientsChanged():
return streakCoefficientsChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _MixupEvent$Toggled value)?  toggled,TResult? Function( _MixupEvent$RangeChanged value)?  rangeChanged,TResult? Function( _MixupEvent$AlgorithmChanged value)?  algorithmChanged,TResult? Function( _MixupEvent$StreakCoefficientsChanged value)?  streakCoefficientsChanged,}){
final _that = this;
switch (_that) {
case _MixupEvent$Toggled() when toggled != null:
return toggled(_that);case _MixupEvent$RangeChanged() when rangeChanged != null:
return rangeChanged(_that);case _MixupEvent$AlgorithmChanged() when algorithmChanged != null:
return algorithmChanged(_that);case _MixupEvent$StreakCoefficientsChanged() when streakCoefficientsChanged != null:
return streakCoefficientsChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool enabled)?  toggled,TResult Function( int min,  int max)?  rangeChanged,TResult Function( MixupAlgorithm algorithm)?  algorithmChanged,TResult Function( double negativeBonus,  double positivePenalty)?  streakCoefficientsChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MixupEvent$Toggled() when toggled != null:
return toggled(_that.enabled);case _MixupEvent$RangeChanged() when rangeChanged != null:
return rangeChanged(_that.min,_that.max);case _MixupEvent$AlgorithmChanged() when algorithmChanged != null:
return algorithmChanged(_that.algorithm);case _MixupEvent$StreakCoefficientsChanged() when streakCoefficientsChanged != null:
return streakCoefficientsChanged(_that.negativeBonus,_that.positivePenalty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool enabled)  toggled,required TResult Function( int min,  int max)  rangeChanged,required TResult Function( MixupAlgorithm algorithm)  algorithmChanged,required TResult Function( double negativeBonus,  double positivePenalty)  streakCoefficientsChanged,}) {final _that = this;
switch (_that) {
case _MixupEvent$Toggled():
return toggled(_that.enabled);case _MixupEvent$RangeChanged():
return rangeChanged(_that.min,_that.max);case _MixupEvent$AlgorithmChanged():
return algorithmChanged(_that.algorithm);case _MixupEvent$StreakCoefficientsChanged():
return streakCoefficientsChanged(_that.negativeBonus,_that.positivePenalty);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool enabled)?  toggled,TResult? Function( int min,  int max)?  rangeChanged,TResult? Function( MixupAlgorithm algorithm)?  algorithmChanged,TResult? Function( double negativeBonus,  double positivePenalty)?  streakCoefficientsChanged,}) {final _that = this;
switch (_that) {
case _MixupEvent$Toggled() when toggled != null:
return toggled(_that.enabled);case _MixupEvent$RangeChanged() when rangeChanged != null:
return rangeChanged(_that.min,_that.max);case _MixupEvent$AlgorithmChanged() when algorithmChanged != null:
return algorithmChanged(_that.algorithm);case _MixupEvent$StreakCoefficientsChanged() when streakCoefficientsChanged != null:
return streakCoefficientsChanged(_that.negativeBonus,_that.positivePenalty);case _:
  return null;

}
}

}

/// @nodoc


class _MixupEvent$Toggled implements MixupEvent {
  const _MixupEvent$Toggled({required this.enabled});
  

 final  bool enabled;

/// Create a copy of MixupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MixupEvent$ToggledCopyWith<_MixupEvent$Toggled> get copyWith => __$MixupEvent$ToggledCopyWithImpl<_MixupEvent$Toggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MixupEvent$Toggled&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'MixupEvent.toggled(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$MixupEvent$ToggledCopyWith<$Res> implements $MixupEventCopyWith<$Res> {
  factory _$MixupEvent$ToggledCopyWith(_MixupEvent$Toggled value, $Res Function(_MixupEvent$Toggled) _then) = __$MixupEvent$ToggledCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$MixupEvent$ToggledCopyWithImpl<$Res>
    implements _$MixupEvent$ToggledCopyWith<$Res> {
  __$MixupEvent$ToggledCopyWithImpl(this._self, this._then);

  final _MixupEvent$Toggled _self;
  final $Res Function(_MixupEvent$Toggled) _then;

/// Create a copy of MixupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_MixupEvent$Toggled(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _MixupEvent$RangeChanged implements MixupEvent {
  const _MixupEvent$RangeChanged({required this.min, required this.max});
  

 final  int min;
 final  int max;

/// Create a copy of MixupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MixupEvent$RangeChangedCopyWith<_MixupEvent$RangeChanged> get copyWith => __$MixupEvent$RangeChangedCopyWithImpl<_MixupEvent$RangeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MixupEvent$RangeChanged&&(identical(other.min, min) || other.min == min)&&(identical(other.max, max) || other.max == max));
}


@override
int get hashCode => Object.hash(runtimeType,min,max);

@override
String toString() {
  return 'MixupEvent.rangeChanged(min: $min, max: $max)';
}


}

/// @nodoc
abstract mixin class _$MixupEvent$RangeChangedCopyWith<$Res> implements $MixupEventCopyWith<$Res> {
  factory _$MixupEvent$RangeChangedCopyWith(_MixupEvent$RangeChanged value, $Res Function(_MixupEvent$RangeChanged) _then) = __$MixupEvent$RangeChangedCopyWithImpl;
@useResult
$Res call({
 int min, int max
});




}
/// @nodoc
class __$MixupEvent$RangeChangedCopyWithImpl<$Res>
    implements _$MixupEvent$RangeChangedCopyWith<$Res> {
  __$MixupEvent$RangeChangedCopyWithImpl(this._self, this._then);

  final _MixupEvent$RangeChanged _self;
  final $Res Function(_MixupEvent$RangeChanged) _then;

/// Create a copy of MixupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? min = null,Object? max = null,}) {
  return _then(_MixupEvent$RangeChanged(
min: null == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as int,max: null == max ? _self.max : max // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _MixupEvent$AlgorithmChanged implements MixupEvent {
  const _MixupEvent$AlgorithmChanged({required this.algorithm});
  

 final  MixupAlgorithm algorithm;

/// Create a copy of MixupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MixupEvent$AlgorithmChangedCopyWith<_MixupEvent$AlgorithmChanged> get copyWith => __$MixupEvent$AlgorithmChangedCopyWithImpl<_MixupEvent$AlgorithmChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MixupEvent$AlgorithmChanged&&(identical(other.algorithm, algorithm) || other.algorithm == algorithm));
}


@override
int get hashCode => Object.hash(runtimeType,algorithm);

@override
String toString() {
  return 'MixupEvent.algorithmChanged(algorithm: $algorithm)';
}


}

/// @nodoc
abstract mixin class _$MixupEvent$AlgorithmChangedCopyWith<$Res> implements $MixupEventCopyWith<$Res> {
  factory _$MixupEvent$AlgorithmChangedCopyWith(_MixupEvent$AlgorithmChanged value, $Res Function(_MixupEvent$AlgorithmChanged) _then) = __$MixupEvent$AlgorithmChangedCopyWithImpl;
@useResult
$Res call({
 MixupAlgorithm algorithm
});




}
/// @nodoc
class __$MixupEvent$AlgorithmChangedCopyWithImpl<$Res>
    implements _$MixupEvent$AlgorithmChangedCopyWith<$Res> {
  __$MixupEvent$AlgorithmChangedCopyWithImpl(this._self, this._then);

  final _MixupEvent$AlgorithmChanged _self;
  final $Res Function(_MixupEvent$AlgorithmChanged) _then;

/// Create a copy of MixupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? algorithm = null,}) {
  return _then(_MixupEvent$AlgorithmChanged(
algorithm: null == algorithm ? _self.algorithm : algorithm // ignore: cast_nullable_to_non_nullable
as MixupAlgorithm,
  ));
}


}

/// @nodoc


class _MixupEvent$StreakCoefficientsChanged implements MixupEvent {
  const _MixupEvent$StreakCoefficientsChanged({required this.negativeBonus, required this.positivePenalty});
  

 final  double negativeBonus;
 final  double positivePenalty;

/// Create a copy of MixupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MixupEvent$StreakCoefficientsChangedCopyWith<_MixupEvent$StreakCoefficientsChanged> get copyWith => __$MixupEvent$StreakCoefficientsChangedCopyWithImpl<_MixupEvent$StreakCoefficientsChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MixupEvent$StreakCoefficientsChanged&&(identical(other.negativeBonus, negativeBonus) || other.negativeBonus == negativeBonus)&&(identical(other.positivePenalty, positivePenalty) || other.positivePenalty == positivePenalty));
}


@override
int get hashCode => Object.hash(runtimeType,negativeBonus,positivePenalty);

@override
String toString() {
  return 'MixupEvent.streakCoefficientsChanged(negativeBonus: $negativeBonus, positivePenalty: $positivePenalty)';
}


}

/// @nodoc
abstract mixin class _$MixupEvent$StreakCoefficientsChangedCopyWith<$Res> implements $MixupEventCopyWith<$Res> {
  factory _$MixupEvent$StreakCoefficientsChangedCopyWith(_MixupEvent$StreakCoefficientsChanged value, $Res Function(_MixupEvent$StreakCoefficientsChanged) _then) = __$MixupEvent$StreakCoefficientsChangedCopyWithImpl;
@useResult
$Res call({
 double negativeBonus, double positivePenalty
});




}
/// @nodoc
class __$MixupEvent$StreakCoefficientsChangedCopyWithImpl<$Res>
    implements _$MixupEvent$StreakCoefficientsChangedCopyWith<$Res> {
  __$MixupEvent$StreakCoefficientsChangedCopyWithImpl(this._self, this._then);

  final _MixupEvent$StreakCoefficientsChanged _self;
  final $Res Function(_MixupEvent$StreakCoefficientsChanged) _then;

/// Create a copy of MixupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? negativeBonus = null,Object? positivePenalty = null,}) {
  return _then(_MixupEvent$StreakCoefficientsChanged(
negativeBonus: null == negativeBonus ? _self.negativeBonus : negativeBonus // ignore: cast_nullable_to_non_nullable
as double,positivePenalty: null == positivePenalty ? _self.positivePenalty : positivePenalty // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$MixupState {

 bool get enabled; int get mixupMin; int get mixupMax; MixupAlgorithm get algorithm; double get streakNegativeBonus; double get streakPositivePenalty;
/// Create a copy of MixupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MixupStateCopyWith<MixupState> get copyWith => _$MixupStateCopyWithImpl<MixupState>(this as MixupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MixupState&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.mixupMin, mixupMin) || other.mixupMin == mixupMin)&&(identical(other.mixupMax, mixupMax) || other.mixupMax == mixupMax)&&(identical(other.algorithm, algorithm) || other.algorithm == algorithm)&&(identical(other.streakNegativeBonus, streakNegativeBonus) || other.streakNegativeBonus == streakNegativeBonus)&&(identical(other.streakPositivePenalty, streakPositivePenalty) || other.streakPositivePenalty == streakPositivePenalty));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,mixupMin,mixupMax,algorithm,streakNegativeBonus,streakPositivePenalty);

@override
String toString() {
  return 'MixupState(enabled: $enabled, mixupMin: $mixupMin, mixupMax: $mixupMax, algorithm: $algorithm, streakNegativeBonus: $streakNegativeBonus, streakPositivePenalty: $streakPositivePenalty)';
}


}

/// @nodoc
abstract mixin class $MixupStateCopyWith<$Res>  {
  factory $MixupStateCopyWith(MixupState value, $Res Function(MixupState) _then) = _$MixupStateCopyWithImpl;
@useResult
$Res call({
 bool enabled, int mixupMin, int mixupMax, MixupAlgorithm algorithm, double streakNegativeBonus, double streakPositivePenalty
});




}
/// @nodoc
class _$MixupStateCopyWithImpl<$Res>
    implements $MixupStateCopyWith<$Res> {
  _$MixupStateCopyWithImpl(this._self, this._then);

  final MixupState _self;
  final $Res Function(MixupState) _then;

/// Create a copy of MixupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? mixupMin = null,Object? mixupMax = null,Object? algorithm = null,Object? streakNegativeBonus = null,Object? streakPositivePenalty = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,mixupMin: null == mixupMin ? _self.mixupMin : mixupMin // ignore: cast_nullable_to_non_nullable
as int,mixupMax: null == mixupMax ? _self.mixupMax : mixupMax // ignore: cast_nullable_to_non_nullable
as int,algorithm: null == algorithm ? _self.algorithm : algorithm // ignore: cast_nullable_to_non_nullable
as MixupAlgorithm,streakNegativeBonus: null == streakNegativeBonus ? _self.streakNegativeBonus : streakNegativeBonus // ignore: cast_nullable_to_non_nullable
as double,streakPositivePenalty: null == streakPositivePenalty ? _self.streakPositivePenalty : streakPositivePenalty // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MixupState].
extension MixupStatePatterns on MixupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MixupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MixupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MixupState value)  $default,){
final _that = this;
switch (_that) {
case _MixupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MixupState value)?  $default,){
final _that = this;
switch (_that) {
case _MixupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  int mixupMin,  int mixupMax,  MixupAlgorithm algorithm,  double streakNegativeBonus,  double streakPositivePenalty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MixupState() when $default != null:
return $default(_that.enabled,_that.mixupMin,_that.mixupMax,_that.algorithm,_that.streakNegativeBonus,_that.streakPositivePenalty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  int mixupMin,  int mixupMax,  MixupAlgorithm algorithm,  double streakNegativeBonus,  double streakPositivePenalty)  $default,) {final _that = this;
switch (_that) {
case _MixupState():
return $default(_that.enabled,_that.mixupMin,_that.mixupMax,_that.algorithm,_that.streakNegativeBonus,_that.streakPositivePenalty);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  int mixupMin,  int mixupMax,  MixupAlgorithm algorithm,  double streakNegativeBonus,  double streakPositivePenalty)?  $default,) {final _that = this;
switch (_that) {
case _MixupState() when $default != null:
return $default(_that.enabled,_that.mixupMin,_that.mixupMax,_that.algorithm,_that.streakNegativeBonus,_that.streakPositivePenalty);case _:
  return null;

}
}

}

/// @nodoc


class _MixupState implements MixupState {
  const _MixupState({this.enabled = false, this.mixupMin = 1, this.mixupMax = 5, this.algorithm = MixupAlgorithm.classic, this.streakNegativeBonus = 0.35, this.streakPositivePenalty = 0.35});
  

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  int mixupMin;
@override@JsonKey() final  int mixupMax;
@override@JsonKey() final  MixupAlgorithm algorithm;
@override@JsonKey() final  double streakNegativeBonus;
@override@JsonKey() final  double streakPositivePenalty;

/// Create a copy of MixupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MixupStateCopyWith<_MixupState> get copyWith => __$MixupStateCopyWithImpl<_MixupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MixupState&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.mixupMin, mixupMin) || other.mixupMin == mixupMin)&&(identical(other.mixupMax, mixupMax) || other.mixupMax == mixupMax)&&(identical(other.algorithm, algorithm) || other.algorithm == algorithm)&&(identical(other.streakNegativeBonus, streakNegativeBonus) || other.streakNegativeBonus == streakNegativeBonus)&&(identical(other.streakPositivePenalty, streakPositivePenalty) || other.streakPositivePenalty == streakPositivePenalty));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,mixupMin,mixupMax,algorithm,streakNegativeBonus,streakPositivePenalty);

@override
String toString() {
  return 'MixupState(enabled: $enabled, mixupMin: $mixupMin, mixupMax: $mixupMax, algorithm: $algorithm, streakNegativeBonus: $streakNegativeBonus, streakPositivePenalty: $streakPositivePenalty)';
}


}

/// @nodoc
abstract mixin class _$MixupStateCopyWith<$Res> implements $MixupStateCopyWith<$Res> {
  factory _$MixupStateCopyWith(_MixupState value, $Res Function(_MixupState) _then) = __$MixupStateCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, int mixupMin, int mixupMax, MixupAlgorithm algorithm, double streakNegativeBonus, double streakPositivePenalty
});




}
/// @nodoc
class __$MixupStateCopyWithImpl<$Res>
    implements _$MixupStateCopyWith<$Res> {
  __$MixupStateCopyWithImpl(this._self, this._then);

  final _MixupState _self;
  final $Res Function(_MixupState) _then;

/// Create a copy of MixupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? mixupMin = null,Object? mixupMax = null,Object? algorithm = null,Object? streakNegativeBonus = null,Object? streakPositivePenalty = null,}) {
  return _then(_MixupState(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,mixupMin: null == mixupMin ? _self.mixupMin : mixupMin // ignore: cast_nullable_to_non_nullable
as int,mixupMax: null == mixupMax ? _self.mixupMax : mixupMax // ignore: cast_nullable_to_non_nullable
as int,algorithm: null == algorithm ? _self.algorithm : algorithm // ignore: cast_nullable_to_non_nullable
as MixupAlgorithm,streakNegativeBonus: null == streakNegativeBonus ? _self.streakNegativeBonus : streakNegativeBonus // ignore: cast_nullable_to_non_nullable
as double,streakPositivePenalty: null == streakPositivePenalty ? _self.streakPositivePenalty : streakPositivePenalty // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
