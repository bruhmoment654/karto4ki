// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CardEntity {
  /// Unique card identifier.
  String get id => throw _privateConstructorUsedError;

  /// Test identifier that owns this card.
  String get testId => throw _privateConstructorUsedError;

  /// Question (front side of the card).
  String get front => throw _privateConstructorUsedError;

  /// Варианты ответов (до 3).
  List<String> get answers => throw _privateConstructorUsedError;

  /// Creation date.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Update date.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Флаг подмешанной карточки (только в памяти, не в БД).
  bool get isMixedIn => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CardEntityCopyWith<CardEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardEntityCopyWith<$Res> {
  factory $CardEntityCopyWith(
          CardEntity value, $Res Function(CardEntity) then) =
      _$CardEntityCopyWithImpl<$Res, CardEntity>;
  @useResult
  $Res call(
      {String id,
      String testId,
      String front,
      List<String> answers,
      DateTime createdAt,
      DateTime updatedAt,
      bool isMixedIn});
}

/// @nodoc
class _$CardEntityCopyWithImpl<$Res, $Val extends CardEntity>
    implements $CardEntityCopyWith<$Res> {
  _$CardEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? testId = null,
    Object? front = null,
    Object? answers = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isMixedIn = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      testId: null == testId
          ? _value.testId
          : testId // ignore: cast_nullable_to_non_nullable
              as String,
      front: null == front
          ? _value.front
          : front // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isMixedIn: null == isMixedIn
          ? _value.isMixedIn
          : isMixedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CardEntityImplCopyWith<$Res>
    implements $CardEntityCopyWith<$Res> {
  factory _$$CardEntityImplCopyWith(
          _$CardEntityImpl value, $Res Function(_$CardEntityImpl) then) =
      __$$CardEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String testId,
      String front,
      List<String> answers,
      DateTime createdAt,
      DateTime updatedAt,
      bool isMixedIn});
}

/// @nodoc
class __$$CardEntityImplCopyWithImpl<$Res>
    extends _$CardEntityCopyWithImpl<$Res, _$CardEntityImpl>
    implements _$$CardEntityImplCopyWith<$Res> {
  __$$CardEntityImplCopyWithImpl(
      _$CardEntityImpl _value, $Res Function(_$CardEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? testId = null,
    Object? front = null,
    Object? answers = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? isMixedIn = null,
  }) {
    return _then(_$CardEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      testId: null == testId
          ? _value.testId
          : testId // ignore: cast_nullable_to_non_nullable
              as String,
      front: null == front
          ? _value.front
          : front // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isMixedIn: null == isMixedIn
          ? _value.isMixedIn
          : isMixedIn // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CardEntityImpl extends _CardEntity {
  const _$CardEntityImpl(
      {required this.id,
      required this.testId,
      required this.front,
      required final List<String> answers,
      required this.createdAt,
      required this.updatedAt,
      this.isMixedIn = false})
      : _answers = answers,
        super._();

  /// Unique card identifier.
  @override
  final String id;

  /// Test identifier that owns this card.
  @override
  final String testId;

  /// Question (front side of the card).
  @override
  final String front;

  /// Варианты ответов (до 3).
  final List<String> _answers;

  /// Варианты ответов (до 3).
  @override
  List<String> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  /// Creation date.
  @override
  final DateTime createdAt;

  /// Update date.
  @override
  final DateTime updatedAt;

  /// Флаг подмешанной карточки (только в памяти, не в БД).
  @override
  @JsonKey()
  final bool isMixedIn;

  @override
  String toString() {
    return 'CardEntity(id: $id, testId: $testId, front: $front, answers: $answers, createdAt: $createdAt, updatedAt: $updatedAt, isMixedIn: $isMixedIn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.testId, testId) || other.testId == testId) &&
            (identical(other.front, front) || other.front == front) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isMixedIn, isMixedIn) ||
                other.isMixedIn == isMixedIn));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      testId,
      front,
      const DeepCollectionEquality().hash(_answers),
      createdAt,
      updatedAt,
      isMixedIn);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CardEntityImplCopyWith<_$CardEntityImpl> get copyWith =>
      __$$CardEntityImplCopyWithImpl<_$CardEntityImpl>(this, _$identity);
}

abstract class _CardEntity extends CardEntity {
  const factory _CardEntity(
      {required final String id,
      required final String testId,
      required final String front,
      required final List<String> answers,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final bool isMixedIn}) = _$CardEntityImpl;
  const _CardEntity._() : super._();

  @override

  /// Unique card identifier.
  String get id;
  @override

  /// Test identifier that owns this card.
  String get testId;
  @override

  /// Question (front side of the card).
  String get front;
  @override

  /// Варианты ответов (до 3).
  List<String> get answers;
  @override

  /// Creation date.
  DateTime get createdAt;
  @override

  /// Update date.
  DateTime get updatedAt;
  @override

  /// Флаг подмешанной карточки (только в памяти, не в БД).
  bool get isMixedIn;
  @override
  @JsonKey(ignore: true)
  _$$CardEntityImplCopyWith<_$CardEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
