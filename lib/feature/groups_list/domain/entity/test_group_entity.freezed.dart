// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_group_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TestGroupEntity {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  int get testCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TestGroupEntityCopyWith<TestGroupEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestGroupEntityCopyWith<$Res> {
  factory $TestGroupEntityCopyWith(
          TestGroupEntity value, $Res Function(TestGroupEntity) then) =
      _$TestGroupEntityCopyWithImpl<$Res, TestGroupEntity>;
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime createdAt,
      DateTime updatedAt,
      int testCount});
}

/// @nodoc
class _$TestGroupEntityCopyWithImpl<$Res, $Val extends TestGroupEntity>
    implements $TestGroupEntityCopyWith<$Res> {
  _$TestGroupEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? testCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      testCount: null == testCount
          ? _value.testCount
          : testCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestGroupEntityImplCopyWith<$Res>
    implements $TestGroupEntityCopyWith<$Res> {
  factory _$$TestGroupEntityImplCopyWith(_$TestGroupEntityImpl value,
          $Res Function(_$TestGroupEntityImpl) then) =
      __$$TestGroupEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime createdAt,
      DateTime updatedAt,
      int testCount});
}

/// @nodoc
class __$$TestGroupEntityImplCopyWithImpl<$Res>
    extends _$TestGroupEntityCopyWithImpl<$Res, _$TestGroupEntityImpl>
    implements _$$TestGroupEntityImplCopyWith<$Res> {
  __$$TestGroupEntityImplCopyWithImpl(
      _$TestGroupEntityImpl _value, $Res Function(_$TestGroupEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? testCount = null,
  }) {
    return _then(_$TestGroupEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      testCount: null == testCount
          ? _value.testCount
          : testCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TestGroupEntityImpl implements _TestGroupEntity {
  const _$TestGroupEntityImpl(
      {required this.id,
      required this.title,
      required this.createdAt,
      required this.updatedAt,
      required this.testCount});

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final int testCount;

  @override
  String toString() {
    return 'TestGroupEntity(id: $id, title: $title, createdAt: $createdAt, updatedAt: $updatedAt, testCount: $testCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestGroupEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.testCount, testCount) ||
                other.testCount == testCount));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, createdAt, updatedAt, testCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestGroupEntityImplCopyWith<_$TestGroupEntityImpl> get copyWith =>
      __$$TestGroupEntityImplCopyWithImpl<_$TestGroupEntityImpl>(
          this, _$identity);
}

abstract class _TestGroupEntity implements TestGroupEntity {
  const factory _TestGroupEntity(
      {required final String id,
      required final String title,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final int testCount}) = _$TestGroupEntityImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  int get testCount;
  @override
  @JsonKey(ignore: true)
  _$$TestGroupEntityImplCopyWith<_$TestGroupEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
