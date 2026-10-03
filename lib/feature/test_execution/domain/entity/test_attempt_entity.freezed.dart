// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_attempt_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TestAttemptEntity {

 String get id; String get testId; DateTime get startedAt; DateTime get completedAt; int get total; int get correct;
/// Create a copy of TestAttemptEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestAttemptEntityCopyWith<TestAttemptEntity> get copyWith => _$TestAttemptEntityCopyWithImpl<TestAttemptEntity>(this as TestAttemptEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestAttemptEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.testId, testId) || other.testId == testId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.correct, correct) || other.correct == correct));
}


@override
int get hashCode => Object.hash(runtimeType,id,testId,startedAt,completedAt,total,correct);

@override
String toString() {
  return 'TestAttemptEntity(id: $id, testId: $testId, startedAt: $startedAt, completedAt: $completedAt, total: $total, correct: $correct)';
}


}

/// @nodoc
abstract mixin class $TestAttemptEntityCopyWith<$Res>  {
  factory $TestAttemptEntityCopyWith(TestAttemptEntity value, $Res Function(TestAttemptEntity) _then) = _$TestAttemptEntityCopyWithImpl;
@useResult
$Res call({
 String id, String testId, DateTime startedAt, DateTime completedAt, int total, int correct
});




}
/// @nodoc
class _$TestAttemptEntityCopyWithImpl<$Res>
    implements $TestAttemptEntityCopyWith<$Res> {
  _$TestAttemptEntityCopyWithImpl(this._self, this._then);

  final TestAttemptEntity _self;
  final $Res Function(TestAttemptEntity) _then;

/// Create a copy of TestAttemptEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? testId = null,Object? startedAt = null,Object? completedAt = null,Object? total = null,Object? correct = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TestAttemptEntity].
extension TestAttemptEntityPatterns on TestAttemptEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestAttemptEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestAttemptEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestAttemptEntity value)  $default,){
final _that = this;
switch (_that) {
case _TestAttemptEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestAttemptEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TestAttemptEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String testId,  DateTime startedAt,  DateTime completedAt,  int total,  int correct)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestAttemptEntity() when $default != null:
return $default(_that.id,_that.testId,_that.startedAt,_that.completedAt,_that.total,_that.correct);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String testId,  DateTime startedAt,  DateTime completedAt,  int total,  int correct)  $default,) {final _that = this;
switch (_that) {
case _TestAttemptEntity():
return $default(_that.id,_that.testId,_that.startedAt,_that.completedAt,_that.total,_that.correct);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String testId,  DateTime startedAt,  DateTime completedAt,  int total,  int correct)?  $default,) {final _that = this;
switch (_that) {
case _TestAttemptEntity() when $default != null:
return $default(_that.id,_that.testId,_that.startedAt,_that.completedAt,_that.total,_that.correct);case _:
  return null;

}
}

}

/// @nodoc


class _TestAttemptEntity extends TestAttemptEntity {
  const _TestAttemptEntity({required this.id, required this.testId, required this.startedAt, required this.completedAt, required this.total, required this.correct}): super._();
  

@override final  String id;
@override final  String testId;
@override final  DateTime startedAt;
@override final  DateTime completedAt;
@override final  int total;
@override final  int correct;

/// Create a copy of TestAttemptEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestAttemptEntityCopyWith<_TestAttemptEntity> get copyWith => __$TestAttemptEntityCopyWithImpl<_TestAttemptEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestAttemptEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.testId, testId) || other.testId == testId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.total, total) || other.total == total)&&(identical(other.correct, correct) || other.correct == correct));
}


@override
int get hashCode => Object.hash(runtimeType,id,testId,startedAt,completedAt,total,correct);

@override
String toString() {
  return 'TestAttemptEntity(id: $id, testId: $testId, startedAt: $startedAt, completedAt: $completedAt, total: $total, correct: $correct)';
}


}

/// @nodoc
abstract mixin class _$TestAttemptEntityCopyWith<$Res> implements $TestAttemptEntityCopyWith<$Res> {
  factory _$TestAttemptEntityCopyWith(_TestAttemptEntity value, $Res Function(_TestAttemptEntity) _then) = __$TestAttemptEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String testId, DateTime startedAt, DateTime completedAt, int total, int correct
});




}
/// @nodoc
class __$TestAttemptEntityCopyWithImpl<$Res>
    implements _$TestAttemptEntityCopyWith<$Res> {
  __$TestAttemptEntityCopyWithImpl(this._self, this._then);

  final _TestAttemptEntity _self;
  final $Res Function(_TestAttemptEntity) _then;

/// Create a copy of TestAttemptEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? testId = null,Object? startedAt = null,Object? completedAt = null,Object? total = null,Object? correct = null,}) {
  return _then(_TestAttemptEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
