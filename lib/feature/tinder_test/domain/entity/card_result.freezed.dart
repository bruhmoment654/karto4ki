// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CardResult {

/// Card identifier.
 String get cardId;/// Whether the answer was correct.
 bool get isCorrect;/// Timestamp when the answer was given.
 DateTime get answeredAt;
/// Create a copy of CardResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardResultCopyWith<CardResult> get copyWith => _$CardResultCopyWithImpl<CardResult>(this as CardResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardResult&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.answeredAt, answeredAt) || other.answeredAt == answeredAt));
}


@override
int get hashCode => Object.hash(runtimeType,cardId,isCorrect,answeredAt);

@override
String toString() {
  return 'CardResult(cardId: $cardId, isCorrect: $isCorrect, answeredAt: $answeredAt)';
}


}

/// @nodoc
abstract mixin class $CardResultCopyWith<$Res>  {
  factory $CardResultCopyWith(CardResult value, $Res Function(CardResult) _then) = _$CardResultCopyWithImpl;
@useResult
$Res call({
 String cardId, bool isCorrect, DateTime answeredAt
});




}
/// @nodoc
class _$CardResultCopyWithImpl<$Res>
    implements $CardResultCopyWith<$Res> {
  _$CardResultCopyWithImpl(this._self, this._then);

  final CardResult _self;
  final $Res Function(CardResult) _then;

/// Create a copy of CardResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cardId = null,Object? isCorrect = null,Object? answeredAt = null,}) {
  return _then(_self.copyWith(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,answeredAt: null == answeredAt ? _self.answeredAt : answeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CardResult].
extension CardResultPatterns on CardResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardResult value)  $default,){
final _that = this;
switch (_that) {
case _CardResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardResult value)?  $default,){
final _that = this;
switch (_that) {
case _CardResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cardId,  bool isCorrect,  DateTime answeredAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardResult() when $default != null:
return $default(_that.cardId,_that.isCorrect,_that.answeredAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cardId,  bool isCorrect,  DateTime answeredAt)  $default,) {final _that = this;
switch (_that) {
case _CardResult():
return $default(_that.cardId,_that.isCorrect,_that.answeredAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cardId,  bool isCorrect,  DateTime answeredAt)?  $default,) {final _that = this;
switch (_that) {
case _CardResult() when $default != null:
return $default(_that.cardId,_that.isCorrect,_that.answeredAt);case _:
  return null;

}
}

}

/// @nodoc


class _CardResult implements CardResult {
  const _CardResult({required this.cardId, required this.isCorrect, required this.answeredAt});
  

/// Card identifier.
@override final  String cardId;
/// Whether the answer was correct.
@override final  bool isCorrect;
/// Timestamp when the answer was given.
@override final  DateTime answeredAt;

/// Create a copy of CardResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardResultCopyWith<_CardResult> get copyWith => __$CardResultCopyWithImpl<_CardResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardResult&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.answeredAt, answeredAt) || other.answeredAt == answeredAt));
}


@override
int get hashCode => Object.hash(runtimeType,cardId,isCorrect,answeredAt);

@override
String toString() {
  return 'CardResult(cardId: $cardId, isCorrect: $isCorrect, answeredAt: $answeredAt)';
}


}

/// @nodoc
abstract mixin class _$CardResultCopyWith<$Res> implements $CardResultCopyWith<$Res> {
  factory _$CardResultCopyWith(_CardResult value, $Res Function(_CardResult) _then) = __$CardResultCopyWithImpl;
@override @useResult
$Res call({
 String cardId, bool isCorrect, DateTime answeredAt
});




}
/// @nodoc
class __$CardResultCopyWithImpl<$Res>
    implements _$CardResultCopyWith<$Res> {
  __$CardResultCopyWithImpl(this._self, this._then);

  final _CardResult _self;
  final $Res Function(_CardResult) _then;

/// Create a copy of CardResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cardId = null,Object? isCorrect = null,Object? answeredAt = null,}) {
  return _then(_CardResult(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,answeredAt: null == answeredAt ? _self.answeredAt : answeredAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
