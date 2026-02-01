// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TestEntity {
  /// Unique test identifier.
  String get id => throw _privateConstructorUsedError;

  /// Test title.
  String get title => throw _privateConstructorUsedError;

  /// Test type.
  TestType get type => throw _privateConstructorUsedError;

  /// Creation date.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Update date.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Test description.
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TestEntityCopyWith<TestEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestEntityCopyWith<$Res> {
  factory $TestEntityCopyWith(
          TestEntity value, $Res Function(TestEntity) then) =
      _$TestEntityCopyWithImpl<$Res, TestEntity>;
  @useResult
  $Res call(
      {String id,
      String title,
      TestType type,
      DateTime createdAt,
      DateTime updatedAt,
      String? description});
}

/// @nodoc
class _$TestEntityCopyWithImpl<$Res, $Val extends TestEntity>
    implements $TestEntityCopyWith<$Res> {
  _$TestEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? description = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TestType,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestEntityImplCopyWith<$Res>
    implements $TestEntityCopyWith<$Res> {
  factory _$$TestEntityImplCopyWith(
          _$TestEntityImpl value, $Res Function(_$TestEntityImpl) then) =
      __$$TestEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      TestType type,
      DateTime createdAt,
      DateTime updatedAt,
      String? description});
}

/// @nodoc
class __$$TestEntityImplCopyWithImpl<$Res>
    extends _$TestEntityCopyWithImpl<$Res, _$TestEntityImpl>
    implements _$$TestEntityImplCopyWith<$Res> {
  __$$TestEntityImplCopyWithImpl(
      _$TestEntityImpl _value, $Res Function(_$TestEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? description = freezed,
  }) {
    return _then(_$TestEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TestType,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TestEntityImpl implements _TestEntity {
  const _$TestEntityImpl(
      {required this.id,
      required this.title,
      required this.type,
      required this.createdAt,
      required this.updatedAt,
      this.description});

  /// Unique test identifier.
  @override
  final String id;

  /// Test title.
  @override
  final String title;

  /// Test type.
  @override
  final TestType type;

  /// Creation date.
  @override
  final DateTime createdAt;

  /// Update date.
  @override
  final DateTime updatedAt;

  /// Test description.
  @override
  final String? description;

  @override
  String toString() {
    return 'TestEntity(id: $id, title: $title, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, type, createdAt, updatedAt, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestEntityImplCopyWith<_$TestEntityImpl> get copyWith =>
      __$$TestEntityImplCopyWithImpl<_$TestEntityImpl>(this, _$identity);
}

abstract class _TestEntity implements TestEntity {
  const factory _TestEntity(
      {required final String id,
      required final String title,
      required final TestType type,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? description}) = _$TestEntityImpl;

  @override

  /// Unique test identifier.
  String get id;
  @override

  /// Test title.
  String get title;
  @override

  /// Test type.
  TestType get type;
  @override

  /// Creation date.
  DateTime get createdAt;
  @override

  /// Update date.
  DateTime get updatedAt;
  @override

  /// Test description.
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$TestEntityImplCopyWith<_$TestEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
