// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_progress_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudyProgressEntity {

/// Ни разу не показывались.
 int get newCount;/// Показывались, но ещё не освоены и не слабые.
 int get learningCount;/// Серия верных ответов не ниже порога освоения.
 int get masteredCount;/// Последние ответы неверные.
 int get weakCount;/// Доля верных ответов (0..1) за последние прохождения; `null` — на этом
/// устройстве прохождений нет.
 double? get accuracy;/// Последнее завершённое прохождение; `null` — прохождений нет.
 DateTime? get lastStudiedAt;
/// Create a copy of StudyProgressEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyProgressEntityCopyWith<StudyProgressEntity> get copyWith => _$StudyProgressEntityCopyWithImpl<StudyProgressEntity>(this as StudyProgressEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyProgressEntity&&(identical(other.newCount, newCount) || other.newCount == newCount)&&(identical(other.learningCount, learningCount) || other.learningCount == learningCount)&&(identical(other.masteredCount, masteredCount) || other.masteredCount == masteredCount)&&(identical(other.weakCount, weakCount) || other.weakCount == weakCount)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.lastStudiedAt, lastStudiedAt) || other.lastStudiedAt == lastStudiedAt));
}


@override
int get hashCode => Object.hash(runtimeType,newCount,learningCount,masteredCount,weakCount,accuracy,lastStudiedAt);

@override
String toString() {
  return 'StudyProgressEntity(newCount: $newCount, learningCount: $learningCount, masteredCount: $masteredCount, weakCount: $weakCount, accuracy: $accuracy, lastStudiedAt: $lastStudiedAt)';
}


}

/// @nodoc
abstract mixin class $StudyProgressEntityCopyWith<$Res>  {
  factory $StudyProgressEntityCopyWith(StudyProgressEntity value, $Res Function(StudyProgressEntity) _then) = _$StudyProgressEntityCopyWithImpl;
@useResult
$Res call({
 int newCount, int learningCount, int masteredCount, int weakCount, double? accuracy, DateTime? lastStudiedAt
});




}
/// @nodoc
class _$StudyProgressEntityCopyWithImpl<$Res>
    implements $StudyProgressEntityCopyWith<$Res> {
  _$StudyProgressEntityCopyWithImpl(this._self, this._then);

  final StudyProgressEntity _self;
  final $Res Function(StudyProgressEntity) _then;

/// Create a copy of StudyProgressEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? newCount = null,Object? learningCount = null,Object? masteredCount = null,Object? weakCount = null,Object? accuracy = freezed,Object? lastStudiedAt = freezed,}) {
  return _then(_self.copyWith(
newCount: null == newCount ? _self.newCount : newCount // ignore: cast_nullable_to_non_nullable
as int,learningCount: null == learningCount ? _self.learningCount : learningCount // ignore: cast_nullable_to_non_nullable
as int,masteredCount: null == masteredCount ? _self.masteredCount : masteredCount // ignore: cast_nullable_to_non_nullable
as int,weakCount: null == weakCount ? _self.weakCount : weakCount // ignore: cast_nullable_to_non_nullable
as int,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double?,lastStudiedAt: freezed == lastStudiedAt ? _self.lastStudiedAt : lastStudiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyProgressEntity].
extension StudyProgressEntityPatterns on StudyProgressEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyProgressEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyProgressEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyProgressEntity value)  $default,){
final _that = this;
switch (_that) {
case _StudyProgressEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyProgressEntity value)?  $default,){
final _that = this;
switch (_that) {
case _StudyProgressEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int newCount,  int learningCount,  int masteredCount,  int weakCount,  double? accuracy,  DateTime? lastStudiedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyProgressEntity() when $default != null:
return $default(_that.newCount,_that.learningCount,_that.masteredCount,_that.weakCount,_that.accuracy,_that.lastStudiedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int newCount,  int learningCount,  int masteredCount,  int weakCount,  double? accuracy,  DateTime? lastStudiedAt)  $default,) {final _that = this;
switch (_that) {
case _StudyProgressEntity():
return $default(_that.newCount,_that.learningCount,_that.masteredCount,_that.weakCount,_that.accuracy,_that.lastStudiedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int newCount,  int learningCount,  int masteredCount,  int weakCount,  double? accuracy,  DateTime? lastStudiedAt)?  $default,) {final _that = this;
switch (_that) {
case _StudyProgressEntity() when $default != null:
return $default(_that.newCount,_that.learningCount,_that.masteredCount,_that.weakCount,_that.accuracy,_that.lastStudiedAt);case _:
  return null;

}
}

}

/// @nodoc


class _StudyProgressEntity extends StudyProgressEntity {
  const _StudyProgressEntity({this.newCount = 0, this.learningCount = 0, this.masteredCount = 0, this.weakCount = 0, this.accuracy, this.lastStudiedAt}): super._();
  

/// Ни разу не показывались.
@override@JsonKey() final  int newCount;
/// Показывались, но ещё не освоены и не слабые.
@override@JsonKey() final  int learningCount;
/// Серия верных ответов не ниже порога освоения.
@override@JsonKey() final  int masteredCount;
/// Последние ответы неверные.
@override@JsonKey() final  int weakCount;
/// Доля верных ответов (0..1) за последние прохождения; `null` — на этом
/// устройстве прохождений нет.
@override final  double? accuracy;
/// Последнее завершённое прохождение; `null` — прохождений нет.
@override final  DateTime? lastStudiedAt;

/// Create a copy of StudyProgressEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyProgressEntityCopyWith<_StudyProgressEntity> get copyWith => __$StudyProgressEntityCopyWithImpl<_StudyProgressEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyProgressEntity&&(identical(other.newCount, newCount) || other.newCount == newCount)&&(identical(other.learningCount, learningCount) || other.learningCount == learningCount)&&(identical(other.masteredCount, masteredCount) || other.masteredCount == masteredCount)&&(identical(other.weakCount, weakCount) || other.weakCount == weakCount)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.lastStudiedAt, lastStudiedAt) || other.lastStudiedAt == lastStudiedAt));
}


@override
int get hashCode => Object.hash(runtimeType,newCount,learningCount,masteredCount,weakCount,accuracy,lastStudiedAt);

@override
String toString() {
  return 'StudyProgressEntity(newCount: $newCount, learningCount: $learningCount, masteredCount: $masteredCount, weakCount: $weakCount, accuracy: $accuracy, lastStudiedAt: $lastStudiedAt)';
}


}

/// @nodoc
abstract mixin class _$StudyProgressEntityCopyWith<$Res> implements $StudyProgressEntityCopyWith<$Res> {
  factory _$StudyProgressEntityCopyWith(_StudyProgressEntity value, $Res Function(_StudyProgressEntity) _then) = __$StudyProgressEntityCopyWithImpl;
@override @useResult
$Res call({
 int newCount, int learningCount, int masteredCount, int weakCount, double? accuracy, DateTime? lastStudiedAt
});




}
/// @nodoc
class __$StudyProgressEntityCopyWithImpl<$Res>
    implements _$StudyProgressEntityCopyWith<$Res> {
  __$StudyProgressEntityCopyWithImpl(this._self, this._then);

  final _StudyProgressEntity _self;
  final $Res Function(_StudyProgressEntity) _then;

/// Create a copy of StudyProgressEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? newCount = null,Object? learningCount = null,Object? masteredCount = null,Object? weakCount = null,Object? accuracy = freezed,Object? lastStudiedAt = freezed,}) {
  return _then(_StudyProgressEntity(
newCount: null == newCount ? _self.newCount : newCount // ignore: cast_nullable_to_non_nullable
as int,learningCount: null == learningCount ? _self.learningCount : learningCount // ignore: cast_nullable_to_non_nullable
as int,masteredCount: null == masteredCount ? _self.masteredCount : masteredCount // ignore: cast_nullable_to_non_nullable
as int,weakCount: null == weakCount ? _self.weakCount : weakCount // ignore: cast_nullable_to_non_nullable
as int,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double?,lastStudiedAt: freezed == lastStudiedAt ? _self.lastStudiedAt : lastStudiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
