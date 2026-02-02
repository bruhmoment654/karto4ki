// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TestSession {
  /// Test identifier.
  String get testId => throw _privateConstructorUsedError;

  /// List of cards to go through.
  List<CardEntity> get cards => throw _privateConstructorUsedError;

  /// Current card index.
  int get currentIndex => throw _privateConstructorUsedError;

  /// Results for answered cards.
  List<CardResult> get results => throw _privateConstructorUsedError;

  /// Session start time.
  DateTime get startedAt => throw _privateConstructorUsedError;

  /// Session completion time (null if not completed).
  DateTime? get completedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TestSessionCopyWith<TestSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestSessionCopyWith<$Res> {
  factory $TestSessionCopyWith(
          TestSession value, $Res Function(TestSession) then) =
      _$TestSessionCopyWithImpl<$Res, TestSession>;
  @useResult
  $Res call(
      {String testId,
      List<CardEntity> cards,
      int currentIndex,
      List<CardResult> results,
      DateTime startedAt,
      DateTime? completedAt});
}

/// @nodoc
class _$TestSessionCopyWithImpl<$Res, $Val extends TestSession>
    implements $TestSessionCopyWith<$Res> {
  _$TestSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
    Object? cards = null,
    Object? currentIndex = null,
    Object? results = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      testId: null == testId
          ? _value.testId
          : testId // ignore: cast_nullable_to_non_nullable
              as String,
      cards: null == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardEntity>,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<CardResult>,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestSessionImplCopyWith<$Res>
    implements $TestSessionCopyWith<$Res> {
  factory _$$TestSessionImplCopyWith(
          _$TestSessionImpl value, $Res Function(_$TestSessionImpl) then) =
      __$$TestSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String testId,
      List<CardEntity> cards,
      int currentIndex,
      List<CardResult> results,
      DateTime startedAt,
      DateTime? completedAt});
}

/// @nodoc
class __$$TestSessionImplCopyWithImpl<$Res>
    extends _$TestSessionCopyWithImpl<$Res, _$TestSessionImpl>
    implements _$$TestSessionImplCopyWith<$Res> {
  __$$TestSessionImplCopyWithImpl(
      _$TestSessionImpl _value, $Res Function(_$TestSessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
    Object? cards = null,
    Object? currentIndex = null,
    Object? results = null,
    Object? startedAt = null,
    Object? completedAt = freezed,
  }) {
    return _then(_$TestSessionImpl(
      testId: null == testId
          ? _value.testId
          : testId // ignore: cast_nullable_to_non_nullable
              as String,
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardEntity>,
      currentIndex: null == currentIndex
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<CardResult>,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$TestSessionImpl extends _TestSession {
  const _$TestSessionImpl(
      {required this.testId,
      required final List<CardEntity> cards,
      required this.currentIndex,
      required final List<CardResult> results,
      required this.startedAt,
      this.completedAt})
      : _cards = cards,
        _results = results,
        super._();

  /// Test identifier.
  @override
  final String testId;

  /// List of cards to go through.
  final List<CardEntity> _cards;

  /// List of cards to go through.
  @override
  List<CardEntity> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  /// Current card index.
  @override
  final int currentIndex;

  /// Results for answered cards.
  final List<CardResult> _results;

  /// Results for answered cards.
  @override
  List<CardResult> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  /// Session start time.
  @override
  final DateTime startedAt;

  /// Session completion time (null if not completed).
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'TestSession(testId: $testId, cards: $cards, currentIndex: $currentIndex, results: $results, startedAt: $startedAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestSessionImpl &&
            (identical(other.testId, testId) || other.testId == testId) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      testId,
      const DeepCollectionEquality().hash(_cards),
      currentIndex,
      const DeepCollectionEquality().hash(_results),
      startedAt,
      completedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestSessionImplCopyWith<_$TestSessionImpl> get copyWith =>
      __$$TestSessionImplCopyWithImpl<_$TestSessionImpl>(this, _$identity);
}

abstract class _TestSession extends TestSession {
  const factory _TestSession(
      {required final String testId,
      required final List<CardEntity> cards,
      required final int currentIndex,
      required final List<CardResult> results,
      required final DateTime startedAt,
      final DateTime? completedAt}) = _$TestSessionImpl;
  const _TestSession._() : super._();

  @override

  /// Test identifier.
  String get testId;
  @override

  /// List of cards to go through.
  List<CardEntity> get cards;
  @override

  /// Current card index.
  int get currentIndex;
  @override

  /// Results for answered cards.
  List<CardResult> get results;
  @override

  /// Session start time.
  DateTime get startedAt;
  @override

  /// Session completion time (null if not completed).
  DateTime? get completedAt;
  @override
  @JsonKey(ignore: true)
  _$$TestSessionImplCopyWith<_$TestSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
