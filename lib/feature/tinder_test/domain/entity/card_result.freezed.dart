// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CardResult {
  /// Card identifier.
  String get cardId => throw _privateConstructorUsedError;

  /// Whether the answer was correct.
  bool get isCorrect => throw _privateConstructorUsedError;

  /// Timestamp when the answer was given.
  DateTime get answeredAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CardResultCopyWith<CardResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardResultCopyWith<$Res> {
  factory $CardResultCopyWith(
          CardResult value, $Res Function(CardResult) then) =
      _$CardResultCopyWithImpl<$Res, CardResult>;
  @useResult
  $Res call({String cardId, bool isCorrect, DateTime answeredAt});
}

/// @nodoc
class _$CardResultCopyWithImpl<$Res, $Val extends CardResult>
    implements $CardResultCopyWith<$Res> {
  _$CardResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
    Object? isCorrect = null,
    Object? answeredAt = null,
  }) {
    return _then(_value.copyWith(
      cardId: null == cardId
          ? _value.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      answeredAt: null == answeredAt
          ? _value.answeredAt
          : answeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CardResultImplCopyWith<$Res>
    implements $CardResultCopyWith<$Res> {
  factory _$$CardResultImplCopyWith(
          _$CardResultImpl value, $Res Function(_$CardResultImpl) then) =
      __$$CardResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String cardId, bool isCorrect, DateTime answeredAt});
}

/// @nodoc
class __$$CardResultImplCopyWithImpl<$Res>
    extends _$CardResultCopyWithImpl<$Res, _$CardResultImpl>
    implements _$$CardResultImplCopyWith<$Res> {
  __$$CardResultImplCopyWithImpl(
      _$CardResultImpl _value, $Res Function(_$CardResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
    Object? isCorrect = null,
    Object? answeredAt = null,
  }) {
    return _then(_$CardResultImpl(
      cardId: null == cardId
          ? _value.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      answeredAt: null == answeredAt
          ? _value.answeredAt
          : answeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$CardResultImpl implements _CardResult {
  const _$CardResultImpl(
      {required this.cardId,
      required this.isCorrect,
      required this.answeredAt});

  /// Card identifier.
  @override
  final String cardId;

  /// Whether the answer was correct.
  @override
  final bool isCorrect;

  /// Timestamp when the answer was given.
  @override
  final DateTime answeredAt;

  @override
  String toString() {
    return 'CardResult(cardId: $cardId, isCorrect: $isCorrect, answeredAt: $answeredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardResultImpl &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.answeredAt, answeredAt) ||
                other.answeredAt == answeredAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cardId, isCorrect, answeredAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CardResultImplCopyWith<_$CardResultImpl> get copyWith =>
      __$$CardResultImplCopyWithImpl<_$CardResultImpl>(this, _$identity);
}

abstract class _CardResult implements CardResult {
  const factory _CardResult(
      {required final String cardId,
      required final bool isCorrect,
      required final DateTime answeredAt}) = _$CardResultImpl;

  @override

  /// Card identifier.
  String get cardId;
  @override

  /// Whether the answer was correct.
  bool get isCorrect;
  @override

  /// Timestamp when the answer was given.
  DateTime get answeredAt;
  @override
  @JsonKey(ignore: true)
  _$$CardResultImplCopyWith<_$CardResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
