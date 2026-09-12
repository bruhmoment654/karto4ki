// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CardEntity {

/// Unique card identifier.
 String get id;/// Test identifier that owns this card.
 String get testId;/// Question (front side of the card).
 String get front;/// Варианты ответов (до 3).
 List<String> get answers;/// Creation date.
 DateTime get createdAt;/// Update date.
 DateTime get updatedAt;/// Флаг подмешанной карточки (только в памяти, не в БД).
 bool get isMixedIn;
/// Create a copy of CardEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardEntityCopyWith<CardEntity> get copyWith => _$CardEntityCopyWithImpl<CardEntity>(this as CardEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.testId, testId) || other.testId == testId)&&(identical(other.front, front) || other.front == front)&&const DeepCollectionEquality().equals(other.answers, answers)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isMixedIn, isMixedIn) || other.isMixedIn == isMixedIn));
}


@override
int get hashCode => Object.hash(runtimeType,id,testId,front,const DeepCollectionEquality().hash(answers),createdAt,updatedAt,isMixedIn);

@override
String toString() {
  return 'CardEntity(id: $id, testId: $testId, front: $front, answers: $answers, createdAt: $createdAt, updatedAt: $updatedAt, isMixedIn: $isMixedIn)';
}


}

/// @nodoc
abstract mixin class $CardEntityCopyWith<$Res>  {
  factory $CardEntityCopyWith(CardEntity value, $Res Function(CardEntity) _then) = _$CardEntityCopyWithImpl;
@useResult
$Res call({
 String id, String testId, String front, List<String> answers, DateTime createdAt, DateTime updatedAt, bool isMixedIn
});




}
/// @nodoc
class _$CardEntityCopyWithImpl<$Res>
    implements $CardEntityCopyWith<$Res> {
  _$CardEntityCopyWithImpl(this._self, this._then);

  final CardEntity _self;
  final $Res Function(CardEntity) _then;

/// Create a copy of CardEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? testId = null,Object? front = null,Object? answers = null,Object? createdAt = null,Object? updatedAt = null,Object? isMixedIn = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,front: null == front ? _self.front : front // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isMixedIn: null == isMixedIn ? _self.isMixedIn : isMixedIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CardEntity].
extension CardEntityPatterns on CardEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardEntity value)  $default,){
final _that = this;
switch (_that) {
case _CardEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CardEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String testId,  String front,  List<String> answers,  DateTime createdAt,  DateTime updatedAt,  bool isMixedIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardEntity() when $default != null:
return $default(_that.id,_that.testId,_that.front,_that.answers,_that.createdAt,_that.updatedAt,_that.isMixedIn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String testId,  String front,  List<String> answers,  DateTime createdAt,  DateTime updatedAt,  bool isMixedIn)  $default,) {final _that = this;
switch (_that) {
case _CardEntity():
return $default(_that.id,_that.testId,_that.front,_that.answers,_that.createdAt,_that.updatedAt,_that.isMixedIn);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String testId,  String front,  List<String> answers,  DateTime createdAt,  DateTime updatedAt,  bool isMixedIn)?  $default,) {final _that = this;
switch (_that) {
case _CardEntity() when $default != null:
return $default(_that.id,_that.testId,_that.front,_that.answers,_that.createdAt,_that.updatedAt,_that.isMixedIn);case _:
  return null;

}
}

}

/// @nodoc


class _CardEntity extends CardEntity {
  const _CardEntity({required this.id, required this.testId, required this.front, required final  List<String> answers, required this.createdAt, required this.updatedAt, this.isMixedIn = false}): _answers = answers,super._();
  

/// Unique card identifier.
@override final  String id;
/// Test identifier that owns this card.
@override final  String testId;
/// Question (front side of the card).
@override final  String front;
/// Варианты ответов (до 3).
 final  List<String> _answers;
/// Варианты ответов (до 3).
@override List<String> get answers {
  if (_answers is EqualUnmodifiableListView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answers);
}

/// Creation date.
@override final  DateTime createdAt;
/// Update date.
@override final  DateTime updatedAt;
/// Флаг подмешанной карточки (только в памяти, не в БД).
@override@JsonKey() final  bool isMixedIn;

/// Create a copy of CardEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardEntityCopyWith<_CardEntity> get copyWith => __$CardEntityCopyWithImpl<_CardEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.testId, testId) || other.testId == testId)&&(identical(other.front, front) || other.front == front)&&const DeepCollectionEquality().equals(other._answers, _answers)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isMixedIn, isMixedIn) || other.isMixedIn == isMixedIn));
}


@override
int get hashCode => Object.hash(runtimeType,id,testId,front,const DeepCollectionEquality().hash(_answers),createdAt,updatedAt,isMixedIn);

@override
String toString() {
  return 'CardEntity(id: $id, testId: $testId, front: $front, answers: $answers, createdAt: $createdAt, updatedAt: $updatedAt, isMixedIn: $isMixedIn)';
}


}

/// @nodoc
abstract mixin class _$CardEntityCopyWith<$Res> implements $CardEntityCopyWith<$Res> {
  factory _$CardEntityCopyWith(_CardEntity value, $Res Function(_CardEntity) _then) = __$CardEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String testId, String front, List<String> answers, DateTime createdAt, DateTime updatedAt, bool isMixedIn
});




}
/// @nodoc
class __$CardEntityCopyWithImpl<$Res>
    implements _$CardEntityCopyWith<$Res> {
  __$CardEntityCopyWithImpl(this._self, this._then);

  final _CardEntity _self;
  final $Res Function(_CardEntity) _then;

/// Create a copy of CardEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? testId = null,Object? front = null,Object? answers = null,Object? createdAt = null,Object? updatedAt = null,Object? isMixedIn = null,}) {
  return _then(_CardEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,front: null == front ? _self.front : front // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isMixedIn: null == isMixedIn ? _self.isMixedIn : isMixedIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
