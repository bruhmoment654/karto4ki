// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_group_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TestGroupEntity {

 String get id; String get title; DateTime get createdAt; DateTime get updatedAt; int get testCount;/// Прогресс изучения по всем тестам группы.
 StudyProgressEntity get progress;
/// Create a copy of TestGroupEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestGroupEntityCopyWith<TestGroupEntity> get copyWith => _$TestGroupEntityCopyWithImpl<TestGroupEntity>(this as TestGroupEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestGroupEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.testCount, testCount) || other.testCount == testCount)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,createdAt,updatedAt,testCount,progress);

@override
String toString() {
  return 'TestGroupEntity(id: $id, title: $title, createdAt: $createdAt, updatedAt: $updatedAt, testCount: $testCount, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $TestGroupEntityCopyWith<$Res>  {
  factory $TestGroupEntityCopyWith(TestGroupEntity value, $Res Function(TestGroupEntity) _then) = _$TestGroupEntityCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime createdAt, DateTime updatedAt, int testCount, StudyProgressEntity progress
});


$StudyProgressEntityCopyWith<$Res> get progress;

}
/// @nodoc
class _$TestGroupEntityCopyWithImpl<$Res>
    implements $TestGroupEntityCopyWith<$Res> {
  _$TestGroupEntityCopyWithImpl(this._self, this._then);

  final TestGroupEntity _self;
  final $Res Function(TestGroupEntity) _then;

/// Create a copy of TestGroupEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? createdAt = null,Object? updatedAt = null,Object? testCount = null,Object? progress = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,testCount: null == testCount ? _self.testCount : testCount // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as StudyProgressEntity,
  ));
}
/// Create a copy of TestGroupEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudyProgressEntityCopyWith<$Res> get progress {
  
  return $StudyProgressEntityCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// Adds pattern-matching-related methods to [TestGroupEntity].
extension TestGroupEntityPatterns on TestGroupEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestGroupEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestGroupEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestGroupEntity value)  $default,){
final _that = this;
switch (_that) {
case _TestGroupEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestGroupEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TestGroupEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime createdAt,  DateTime updatedAt,  int testCount,  StudyProgressEntity progress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestGroupEntity() when $default != null:
return $default(_that.id,_that.title,_that.createdAt,_that.updatedAt,_that.testCount,_that.progress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime createdAt,  DateTime updatedAt,  int testCount,  StudyProgressEntity progress)  $default,) {final _that = this;
switch (_that) {
case _TestGroupEntity():
return $default(_that.id,_that.title,_that.createdAt,_that.updatedAt,_that.testCount,_that.progress);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime createdAt,  DateTime updatedAt,  int testCount,  StudyProgressEntity progress)?  $default,) {final _that = this;
switch (_that) {
case _TestGroupEntity() when $default != null:
return $default(_that.id,_that.title,_that.createdAt,_that.updatedAt,_that.testCount,_that.progress);case _:
  return null;

}
}

}

/// @nodoc


class _TestGroupEntity implements TestGroupEntity {
  const _TestGroupEntity({required this.id, required this.title, required this.createdAt, required this.updatedAt, required this.testCount, this.progress = StudyProgressEntity.empty});
  

@override final  String id;
@override final  String title;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  int testCount;
/// Прогресс изучения по всем тестам группы.
@override@JsonKey() final  StudyProgressEntity progress;

/// Create a copy of TestGroupEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestGroupEntityCopyWith<_TestGroupEntity> get copyWith => __$TestGroupEntityCopyWithImpl<_TestGroupEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestGroupEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.testCount, testCount) || other.testCount == testCount)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,createdAt,updatedAt,testCount,progress);

@override
String toString() {
  return 'TestGroupEntity(id: $id, title: $title, createdAt: $createdAt, updatedAt: $updatedAt, testCount: $testCount, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$TestGroupEntityCopyWith<$Res> implements $TestGroupEntityCopyWith<$Res> {
  factory _$TestGroupEntityCopyWith(_TestGroupEntity value, $Res Function(_TestGroupEntity) _then) = __$TestGroupEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime createdAt, DateTime updatedAt, int testCount, StudyProgressEntity progress
});


@override $StudyProgressEntityCopyWith<$Res> get progress;

}
/// @nodoc
class __$TestGroupEntityCopyWithImpl<$Res>
    implements _$TestGroupEntityCopyWith<$Res> {
  __$TestGroupEntityCopyWithImpl(this._self, this._then);

  final _TestGroupEntity _self;
  final $Res Function(_TestGroupEntity) _then;

/// Create a copy of TestGroupEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? createdAt = null,Object? updatedAt = null,Object? testCount = null,Object? progress = null,}) {
  return _then(_TestGroupEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,testCount: null == testCount ? _self.testCount : testCount // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as StudyProgressEntity,
  ));
}

/// Create a copy of TestGroupEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudyProgressEntityCopyWith<$Res> get progress {
  
  return $StudyProgressEntityCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}

// dart format on
