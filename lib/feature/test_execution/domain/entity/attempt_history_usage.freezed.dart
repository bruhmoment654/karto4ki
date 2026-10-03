// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attempt_history_usage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttemptHistoryUsage {

 int get bytes;/// Размер оценён по числу строк, а не посчитан по страницам базы.
 bool get isEstimate;
/// Create a copy of AttemptHistoryUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttemptHistoryUsageCopyWith<AttemptHistoryUsage> get copyWith => _$AttemptHistoryUsageCopyWithImpl<AttemptHistoryUsage>(this as AttemptHistoryUsage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttemptHistoryUsage&&(identical(other.bytes, bytes) || other.bytes == bytes)&&(identical(other.isEstimate, isEstimate) || other.isEstimate == isEstimate));
}


@override
int get hashCode => Object.hash(runtimeType,bytes,isEstimate);

@override
String toString() {
  return 'AttemptHistoryUsage(bytes: $bytes, isEstimate: $isEstimate)';
}


}

/// @nodoc
abstract mixin class $AttemptHistoryUsageCopyWith<$Res>  {
  factory $AttemptHistoryUsageCopyWith(AttemptHistoryUsage value, $Res Function(AttemptHistoryUsage) _then) = _$AttemptHistoryUsageCopyWithImpl;
@useResult
$Res call({
 int bytes, bool isEstimate
});




}
/// @nodoc
class _$AttemptHistoryUsageCopyWithImpl<$Res>
    implements $AttemptHistoryUsageCopyWith<$Res> {
  _$AttemptHistoryUsageCopyWithImpl(this._self, this._then);

  final AttemptHistoryUsage _self;
  final $Res Function(AttemptHistoryUsage) _then;

/// Create a copy of AttemptHistoryUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bytes = null,Object? isEstimate = null,}) {
  return _then(_self.copyWith(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as int,isEstimate: null == isEstimate ? _self.isEstimate : isEstimate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AttemptHistoryUsage].
extension AttemptHistoryUsagePatterns on AttemptHistoryUsage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttemptHistoryUsage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttemptHistoryUsage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttemptHistoryUsage value)  $default,){
final _that = this;
switch (_that) {
case _AttemptHistoryUsage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttemptHistoryUsage value)?  $default,){
final _that = this;
switch (_that) {
case _AttemptHistoryUsage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int bytes,  bool isEstimate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttemptHistoryUsage() when $default != null:
return $default(_that.bytes,_that.isEstimate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int bytes,  bool isEstimate)  $default,) {final _that = this;
switch (_that) {
case _AttemptHistoryUsage():
return $default(_that.bytes,_that.isEstimate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int bytes,  bool isEstimate)?  $default,) {final _that = this;
switch (_that) {
case _AttemptHistoryUsage() when $default != null:
return $default(_that.bytes,_that.isEstimate);case _:
  return null;

}
}

}

/// @nodoc


class _AttemptHistoryUsage extends AttemptHistoryUsage {
  const _AttemptHistoryUsage({required this.bytes, this.isEstimate = false}): super._();
  

@override final  int bytes;
/// Размер оценён по числу строк, а не посчитан по страницам базы.
@override@JsonKey() final  bool isEstimate;

/// Create a copy of AttemptHistoryUsage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttemptHistoryUsageCopyWith<_AttemptHistoryUsage> get copyWith => __$AttemptHistoryUsageCopyWithImpl<_AttemptHistoryUsage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttemptHistoryUsage&&(identical(other.bytes, bytes) || other.bytes == bytes)&&(identical(other.isEstimate, isEstimate) || other.isEstimate == isEstimate));
}


@override
int get hashCode => Object.hash(runtimeType,bytes,isEstimate);

@override
String toString() {
  return 'AttemptHistoryUsage(bytes: $bytes, isEstimate: $isEstimate)';
}


}

/// @nodoc
abstract mixin class _$AttemptHistoryUsageCopyWith<$Res> implements $AttemptHistoryUsageCopyWith<$Res> {
  factory _$AttemptHistoryUsageCopyWith(_AttemptHistoryUsage value, $Res Function(_AttemptHistoryUsage) _then) = __$AttemptHistoryUsageCopyWithImpl;
@override @useResult
$Res call({
 int bytes, bool isEstimate
});




}
/// @nodoc
class __$AttemptHistoryUsageCopyWithImpl<$Res>
    implements _$AttemptHistoryUsageCopyWith<$Res> {
  __$AttemptHistoryUsageCopyWithImpl(this._self, this._then);

  final _AttemptHistoryUsage _self;
  final $Res Function(_AttemptHistoryUsage) _then;

/// Create a copy of AttemptHistoryUsage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bytes = null,Object? isEstimate = null,}) {
  return _then(_AttemptHistoryUsage(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as int,isEstimate: null == isEstimate ? _self.isEstimate : isEstimate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
