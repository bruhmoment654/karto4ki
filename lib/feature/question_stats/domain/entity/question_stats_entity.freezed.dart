// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_stats_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestionStatsEntity {

 int get id; String get questionKey; String get frontText; String get backText; int get streak; int get totalCorrect; int get totalIncorrect; int get totalShown; DateTime get createdAt; DateTime get updatedAt; DateTime? get lastAnsweredAt; DateTime? get lastShownAt;
/// Create a copy of QuestionStatsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionStatsEntityCopyWith<QuestionStatsEntity> get copyWith => _$QuestionStatsEntityCopyWithImpl<QuestionStatsEntity>(this as QuestionStatsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionStatsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.questionKey, questionKey) || other.questionKey == questionKey)&&(identical(other.frontText, frontText) || other.frontText == frontText)&&(identical(other.backText, backText) || other.backText == backText)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.totalCorrect, totalCorrect) || other.totalCorrect == totalCorrect)&&(identical(other.totalIncorrect, totalIncorrect) || other.totalIncorrect == totalIncorrect)&&(identical(other.totalShown, totalShown) || other.totalShown == totalShown)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastAnsweredAt, lastAnsweredAt) || other.lastAnsweredAt == lastAnsweredAt)&&(identical(other.lastShownAt, lastShownAt) || other.lastShownAt == lastShownAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,questionKey,frontText,backText,streak,totalCorrect,totalIncorrect,totalShown,createdAt,updatedAt,lastAnsweredAt,lastShownAt);

@override
String toString() {
  return 'QuestionStatsEntity(id: $id, questionKey: $questionKey, frontText: $frontText, backText: $backText, streak: $streak, totalCorrect: $totalCorrect, totalIncorrect: $totalIncorrect, totalShown: $totalShown, createdAt: $createdAt, updatedAt: $updatedAt, lastAnsweredAt: $lastAnsweredAt, lastShownAt: $lastShownAt)';
}


}

/// @nodoc
abstract mixin class $QuestionStatsEntityCopyWith<$Res>  {
  factory $QuestionStatsEntityCopyWith(QuestionStatsEntity value, $Res Function(QuestionStatsEntity) _then) = _$QuestionStatsEntityCopyWithImpl;
@useResult
$Res call({
 int id, String questionKey, String frontText, String backText, int streak, int totalCorrect, int totalIncorrect, int totalShown, DateTime createdAt, DateTime updatedAt, DateTime? lastAnsweredAt, DateTime? lastShownAt
});




}
/// @nodoc
class _$QuestionStatsEntityCopyWithImpl<$Res>
    implements $QuestionStatsEntityCopyWith<$Res> {
  _$QuestionStatsEntityCopyWithImpl(this._self, this._then);

  final QuestionStatsEntity _self;
  final $Res Function(QuestionStatsEntity) _then;

/// Create a copy of QuestionStatsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? questionKey = null,Object? frontText = null,Object? backText = null,Object? streak = null,Object? totalCorrect = null,Object? totalIncorrect = null,Object? totalShown = null,Object? createdAt = null,Object? updatedAt = null,Object? lastAnsweredAt = freezed,Object? lastShownAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,questionKey: null == questionKey ? _self.questionKey : questionKey // ignore: cast_nullable_to_non_nullable
as String,frontText: null == frontText ? _self.frontText : frontText // ignore: cast_nullable_to_non_nullable
as String,backText: null == backText ? _self.backText : backText // ignore: cast_nullable_to_non_nullable
as String,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,totalCorrect: null == totalCorrect ? _self.totalCorrect : totalCorrect // ignore: cast_nullable_to_non_nullable
as int,totalIncorrect: null == totalIncorrect ? _self.totalIncorrect : totalIncorrect // ignore: cast_nullable_to_non_nullable
as int,totalShown: null == totalShown ? _self.totalShown : totalShown // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastAnsweredAt: freezed == lastAnsweredAt ? _self.lastAnsweredAt : lastAnsweredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastShownAt: freezed == lastShownAt ? _self.lastShownAt : lastShownAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuestionStatsEntity].
extension QuestionStatsEntityPatterns on QuestionStatsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionStatsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionStatsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionStatsEntity value)  $default,){
final _that = this;
switch (_that) {
case _QuestionStatsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionStatsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionStatsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String questionKey,  String frontText,  String backText,  int streak,  int totalCorrect,  int totalIncorrect,  int totalShown,  DateTime createdAt,  DateTime updatedAt,  DateTime? lastAnsweredAt,  DateTime? lastShownAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionStatsEntity() when $default != null:
return $default(_that.id,_that.questionKey,_that.frontText,_that.backText,_that.streak,_that.totalCorrect,_that.totalIncorrect,_that.totalShown,_that.createdAt,_that.updatedAt,_that.lastAnsweredAt,_that.lastShownAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String questionKey,  String frontText,  String backText,  int streak,  int totalCorrect,  int totalIncorrect,  int totalShown,  DateTime createdAt,  DateTime updatedAt,  DateTime? lastAnsweredAt,  DateTime? lastShownAt)  $default,) {final _that = this;
switch (_that) {
case _QuestionStatsEntity():
return $default(_that.id,_that.questionKey,_that.frontText,_that.backText,_that.streak,_that.totalCorrect,_that.totalIncorrect,_that.totalShown,_that.createdAt,_that.updatedAt,_that.lastAnsweredAt,_that.lastShownAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String questionKey,  String frontText,  String backText,  int streak,  int totalCorrect,  int totalIncorrect,  int totalShown,  DateTime createdAt,  DateTime updatedAt,  DateTime? lastAnsweredAt,  DateTime? lastShownAt)?  $default,) {final _that = this;
switch (_that) {
case _QuestionStatsEntity() when $default != null:
return $default(_that.id,_that.questionKey,_that.frontText,_that.backText,_that.streak,_that.totalCorrect,_that.totalIncorrect,_that.totalShown,_that.createdAt,_that.updatedAt,_that.lastAnsweredAt,_that.lastShownAt);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionStatsEntity implements QuestionStatsEntity {
  const _QuestionStatsEntity({required this.id, required this.questionKey, required this.frontText, required this.backText, required this.streak, required this.totalCorrect, required this.totalIncorrect, required this.totalShown, required this.createdAt, required this.updatedAt, this.lastAnsweredAt, this.lastShownAt});
  

@override final  int id;
@override final  String questionKey;
@override final  String frontText;
@override final  String backText;
@override final  int streak;
@override final  int totalCorrect;
@override final  int totalIncorrect;
@override final  int totalShown;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? lastAnsweredAt;
@override final  DateTime? lastShownAt;

/// Create a copy of QuestionStatsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionStatsEntityCopyWith<_QuestionStatsEntity> get copyWith => __$QuestionStatsEntityCopyWithImpl<_QuestionStatsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionStatsEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.questionKey, questionKey) || other.questionKey == questionKey)&&(identical(other.frontText, frontText) || other.frontText == frontText)&&(identical(other.backText, backText) || other.backText == backText)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.totalCorrect, totalCorrect) || other.totalCorrect == totalCorrect)&&(identical(other.totalIncorrect, totalIncorrect) || other.totalIncorrect == totalIncorrect)&&(identical(other.totalShown, totalShown) || other.totalShown == totalShown)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastAnsweredAt, lastAnsweredAt) || other.lastAnsweredAt == lastAnsweredAt)&&(identical(other.lastShownAt, lastShownAt) || other.lastShownAt == lastShownAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,questionKey,frontText,backText,streak,totalCorrect,totalIncorrect,totalShown,createdAt,updatedAt,lastAnsweredAt,lastShownAt);

@override
String toString() {
  return 'QuestionStatsEntity(id: $id, questionKey: $questionKey, frontText: $frontText, backText: $backText, streak: $streak, totalCorrect: $totalCorrect, totalIncorrect: $totalIncorrect, totalShown: $totalShown, createdAt: $createdAt, updatedAt: $updatedAt, lastAnsweredAt: $lastAnsweredAt, lastShownAt: $lastShownAt)';
}


}

/// @nodoc
abstract mixin class _$QuestionStatsEntityCopyWith<$Res> implements $QuestionStatsEntityCopyWith<$Res> {
  factory _$QuestionStatsEntityCopyWith(_QuestionStatsEntity value, $Res Function(_QuestionStatsEntity) _then) = __$QuestionStatsEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String questionKey, String frontText, String backText, int streak, int totalCorrect, int totalIncorrect, int totalShown, DateTime createdAt, DateTime updatedAt, DateTime? lastAnsweredAt, DateTime? lastShownAt
});




}
/// @nodoc
class __$QuestionStatsEntityCopyWithImpl<$Res>
    implements _$QuestionStatsEntityCopyWith<$Res> {
  __$QuestionStatsEntityCopyWithImpl(this._self, this._then);

  final _QuestionStatsEntity _self;
  final $Res Function(_QuestionStatsEntity) _then;

/// Create a copy of QuestionStatsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? questionKey = null,Object? frontText = null,Object? backText = null,Object? streak = null,Object? totalCorrect = null,Object? totalIncorrect = null,Object? totalShown = null,Object? createdAt = null,Object? updatedAt = null,Object? lastAnsweredAt = freezed,Object? lastShownAt = freezed,}) {
  return _then(_QuestionStatsEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,questionKey: null == questionKey ? _self.questionKey : questionKey // ignore: cast_nullable_to_non_nullable
as String,frontText: null == frontText ? _self.frontText : frontText // ignore: cast_nullable_to_non_nullable
as String,backText: null == backText ? _self.backText : backText // ignore: cast_nullable_to_non_nullable
as String,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,totalCorrect: null == totalCorrect ? _self.totalCorrect : totalCorrect // ignore: cast_nullable_to_non_nullable
as int,totalIncorrect: null == totalIncorrect ? _self.totalIncorrect : totalIncorrect // ignore: cast_nullable_to_non_nullable
as int,totalShown: null == totalShown ? _self.totalShown : totalShown // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastAnsweredAt: freezed == lastAnsweredAt ? _self.lastAnsweredAt : lastAnsweredAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastShownAt: freezed == lastShownAt ? _self.lastShownAt : lastShownAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
