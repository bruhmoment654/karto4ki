// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TestEntity {

/// Unique test identifier.
 String get id;/// Test title.
 String get title;/// Test type.
 TestType get type;/// Creation date.
 DateTime get createdAt;/// Update date.
 DateTime get updatedAt;/// Test description.
 String? get description;/// Количество вопросов (карточек) в тесте.
 int get questionCount;/// Прогресс изучения теста.
 StudyProgressEntity get progress;
/// Create a copy of TestEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestEntityCopyWith<TestEntity> get copyWith => _$TestEntityCopyWithImpl<TestEntity>(this as TestEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,type,createdAt,updatedAt,description,questionCount,progress);

@override
String toString() {
  return 'TestEntity(id: $id, title: $title, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, questionCount: $questionCount, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $TestEntityCopyWith<$Res>  {
  factory $TestEntityCopyWith(TestEntity value, $Res Function(TestEntity) _then) = _$TestEntityCopyWithImpl;
@useResult
$Res call({
 String id, String title, TestType type, DateTime createdAt, DateTime updatedAt, String? description, int questionCount, StudyProgressEntity progress
});


$StudyProgressEntityCopyWith<$Res> get progress;

}
/// @nodoc
class _$TestEntityCopyWithImpl<$Res>
    implements $TestEntityCopyWith<$Res> {
  _$TestEntityCopyWithImpl(this._self, this._then);

  final TestEntity _self;
  final $Res Function(TestEntity) _then;

/// Create a copy of TestEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? type = null,Object? createdAt = null,Object? updatedAt = null,Object? description = freezed,Object? questionCount = null,Object? progress = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TestType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as StudyProgressEntity,
  ));
}
/// Create a copy of TestEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudyProgressEntityCopyWith<$Res> get progress {
  
  return $StudyProgressEntityCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}
}


/// Adds pattern-matching-related methods to [TestEntity].
extension TestEntityPatterns on TestEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TestEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TestEntity value)  $default,){
final _that = this;
switch (_that) {
case _TestEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TestEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TestEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  TestType type,  DateTime createdAt,  DateTime updatedAt,  String? description,  int questionCount,  StudyProgressEntity progress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestEntity() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.createdAt,_that.updatedAt,_that.description,_that.questionCount,_that.progress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  TestType type,  DateTime createdAt,  DateTime updatedAt,  String? description,  int questionCount,  StudyProgressEntity progress)  $default,) {final _that = this;
switch (_that) {
case _TestEntity():
return $default(_that.id,_that.title,_that.type,_that.createdAt,_that.updatedAt,_that.description,_that.questionCount,_that.progress);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  TestType type,  DateTime createdAt,  DateTime updatedAt,  String? description,  int questionCount,  StudyProgressEntity progress)?  $default,) {final _that = this;
switch (_that) {
case _TestEntity() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.createdAt,_that.updatedAt,_that.description,_that.questionCount,_that.progress);case _:
  return null;

}
}

}

/// @nodoc


class _TestEntity implements TestEntity {
  const _TestEntity({required this.id, required this.title, required this.type, required this.createdAt, required this.updatedAt, this.description, this.questionCount = 0, this.progress = StudyProgressEntity.empty});
  

/// Unique test identifier.
@override final  String id;
/// Test title.
@override final  String title;
/// Test type.
@override final  TestType type;
/// Creation date.
@override final  DateTime createdAt;
/// Update date.
@override final  DateTime updatedAt;
/// Test description.
@override final  String? description;
/// Количество вопросов (карточек) в тесте.
@override@JsonKey() final  int questionCount;
/// Прогресс изучения теста.
@override@JsonKey() final  StudyProgressEntity progress;

/// Create a copy of TestEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestEntityCopyWith<_TestEntity> get copyWith => __$TestEntityCopyWithImpl<_TestEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,type,createdAt,updatedAt,description,questionCount,progress);

@override
String toString() {
  return 'TestEntity(id: $id, title: $title, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, description: $description, questionCount: $questionCount, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$TestEntityCopyWith<$Res> implements $TestEntityCopyWith<$Res> {
  factory _$TestEntityCopyWith(_TestEntity value, $Res Function(_TestEntity) _then) = __$TestEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, TestType type, DateTime createdAt, DateTime updatedAt, String? description, int questionCount, StudyProgressEntity progress
});


@override $StudyProgressEntityCopyWith<$Res> get progress;

}
/// @nodoc
class __$TestEntityCopyWithImpl<$Res>
    implements _$TestEntityCopyWith<$Res> {
  __$TestEntityCopyWithImpl(this._self, this._then);

  final _TestEntity _self;
  final $Res Function(_TestEntity) _then;

/// Create a copy of TestEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? type = null,Object? createdAt = null,Object? updatedAt = null,Object? description = freezed,Object? questionCount = null,Object? progress = null,}) {
  return _then(_TestEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TestType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as StudyProgressEntity,
  ));
}

/// Create a copy of TestEntity
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
