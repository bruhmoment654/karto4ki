// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TestDetailEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int testId) started,
    required TResult Function(String front, String back) cardAdded,
    required TResult Function(int cardId) cardDeleted,
    required TResult Function(CardEntity card) cardUpdated,
    required TResult Function(String title, String? description) testUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int testId)? started,
    TResult? Function(String front, String back)? cardAdded,
    TResult? Function(int cardId)? cardDeleted,
    TResult? Function(CardEntity card)? cardUpdated,
    TResult? Function(String title, String? description)? testUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int testId)? started,
    TResult Function(String front, String back)? cardAdded,
    TResult Function(int cardId)? cardDeleted,
    TResult Function(CardEntity card)? cardUpdated,
    TResult Function(String title, String? description)? testUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TestDetailEvent$Started value) started,
    required TResult Function(_TestDetailEvent$CardAdded value) cardAdded,
    required TResult Function(_TestDetailEvent$CardDeleted value) cardDeleted,
    required TResult Function(_TestDetailEvent$CardUpdated value) cardUpdated,
    required TResult Function(_TestDetailEvent$TestUpdated value) testUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestDetailEvent$Started value)? started,
    TResult? Function(_TestDetailEvent$CardAdded value)? cardAdded,
    TResult? Function(_TestDetailEvent$CardDeleted value)? cardDeleted,
    TResult? Function(_TestDetailEvent$CardUpdated value)? cardUpdated,
    TResult? Function(_TestDetailEvent$TestUpdated value)? testUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestDetailEvent$Started value)? started,
    TResult Function(_TestDetailEvent$CardAdded value)? cardAdded,
    TResult Function(_TestDetailEvent$CardDeleted value)? cardDeleted,
    TResult Function(_TestDetailEvent$CardUpdated value)? cardUpdated,
    TResult Function(_TestDetailEvent$TestUpdated value)? testUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestDetailEventCopyWith<$Res> {
  factory $TestDetailEventCopyWith(
          TestDetailEvent value, $Res Function(TestDetailEvent) then) =
      _$TestDetailEventCopyWithImpl<$Res, TestDetailEvent>;
}

/// @nodoc
class _$TestDetailEventCopyWithImpl<$Res, $Val extends TestDetailEvent>
    implements $TestDetailEventCopyWith<$Res> {
  _$TestDetailEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TestDetailEvent$StartedImplCopyWith<$Res> {
  factory _$$TestDetailEvent$StartedImplCopyWith(
          _$TestDetailEvent$StartedImpl value,
          $Res Function(_$TestDetailEvent$StartedImpl) then) =
      __$$TestDetailEvent$StartedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int testId});
}

/// @nodoc
class __$$TestDetailEvent$StartedImplCopyWithImpl<$Res>
    extends _$TestDetailEventCopyWithImpl<$Res, _$TestDetailEvent$StartedImpl>
    implements _$$TestDetailEvent$StartedImplCopyWith<$Res> {
  __$$TestDetailEvent$StartedImplCopyWithImpl(
      _$TestDetailEvent$StartedImpl _value,
      $Res Function(_$TestDetailEvent$StartedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
  }) {
    return _then(_$TestDetailEvent$StartedImpl(
      testId: null == testId
          ? _value.testId
          : testId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TestDetailEvent$StartedImpl implements _TestDetailEvent$Started {
  const _$TestDetailEvent$StartedImpl({required this.testId});

  @override
  final int testId;

  @override
  String toString() {
    return 'TestDetailEvent.started(testId: $testId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestDetailEvent$StartedImpl &&
            (identical(other.testId, testId) || other.testId == testId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, testId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestDetailEvent$StartedImplCopyWith<_$TestDetailEvent$StartedImpl>
      get copyWith => __$$TestDetailEvent$StartedImplCopyWithImpl<
          _$TestDetailEvent$StartedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int testId) started,
    required TResult Function(String front, String back) cardAdded,
    required TResult Function(int cardId) cardDeleted,
    required TResult Function(CardEntity card) cardUpdated,
    required TResult Function(String title, String? description) testUpdated,
  }) {
    return started(testId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int testId)? started,
    TResult? Function(String front, String back)? cardAdded,
    TResult? Function(int cardId)? cardDeleted,
    TResult? Function(CardEntity card)? cardUpdated,
    TResult? Function(String title, String? description)? testUpdated,
  }) {
    return started?.call(testId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int testId)? started,
    TResult Function(String front, String back)? cardAdded,
    TResult Function(int cardId)? cardDeleted,
    TResult Function(CardEntity card)? cardUpdated,
    TResult Function(String title, String? description)? testUpdated,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(testId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TestDetailEvent$Started value) started,
    required TResult Function(_TestDetailEvent$CardAdded value) cardAdded,
    required TResult Function(_TestDetailEvent$CardDeleted value) cardDeleted,
    required TResult Function(_TestDetailEvent$CardUpdated value) cardUpdated,
    required TResult Function(_TestDetailEvent$TestUpdated value) testUpdated,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestDetailEvent$Started value)? started,
    TResult? Function(_TestDetailEvent$CardAdded value)? cardAdded,
    TResult? Function(_TestDetailEvent$CardDeleted value)? cardDeleted,
    TResult? Function(_TestDetailEvent$CardUpdated value)? cardUpdated,
    TResult? Function(_TestDetailEvent$TestUpdated value)? testUpdated,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestDetailEvent$Started value)? started,
    TResult Function(_TestDetailEvent$CardAdded value)? cardAdded,
    TResult Function(_TestDetailEvent$CardDeleted value)? cardDeleted,
    TResult Function(_TestDetailEvent$CardUpdated value)? cardUpdated,
    TResult Function(_TestDetailEvent$TestUpdated value)? testUpdated,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _TestDetailEvent$Started implements TestDetailEvent {
  const factory _TestDetailEvent$Started({required final int testId}) =
      _$TestDetailEvent$StartedImpl;

  int get testId;
  @JsonKey(ignore: true)
  _$$TestDetailEvent$StartedImplCopyWith<_$TestDetailEvent$StartedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestDetailEvent$CardAddedImplCopyWith<$Res> {
  factory _$$TestDetailEvent$CardAddedImplCopyWith(
          _$TestDetailEvent$CardAddedImpl value,
          $Res Function(_$TestDetailEvent$CardAddedImpl) then) =
      __$$TestDetailEvent$CardAddedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String front, String back});
}

/// @nodoc
class __$$TestDetailEvent$CardAddedImplCopyWithImpl<$Res>
    extends _$TestDetailEventCopyWithImpl<$Res, _$TestDetailEvent$CardAddedImpl>
    implements _$$TestDetailEvent$CardAddedImplCopyWith<$Res> {
  __$$TestDetailEvent$CardAddedImplCopyWithImpl(
      _$TestDetailEvent$CardAddedImpl _value,
      $Res Function(_$TestDetailEvent$CardAddedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? front = null,
    Object? back = null,
  }) {
    return _then(_$TestDetailEvent$CardAddedImpl(
      front: null == front
          ? _value.front
          : front // ignore: cast_nullable_to_non_nullable
              as String,
      back: null == back
          ? _value.back
          : back // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TestDetailEvent$CardAddedImpl implements _TestDetailEvent$CardAdded {
  const _$TestDetailEvent$CardAddedImpl(
      {required this.front, required this.back});

  @override
  final String front;
  @override
  final String back;

  @override
  String toString() {
    return 'TestDetailEvent.cardAdded(front: $front, back: $back)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestDetailEvent$CardAddedImpl &&
            (identical(other.front, front) || other.front == front) &&
            (identical(other.back, back) || other.back == back));
  }

  @override
  int get hashCode => Object.hash(runtimeType, front, back);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestDetailEvent$CardAddedImplCopyWith<_$TestDetailEvent$CardAddedImpl>
      get copyWith => __$$TestDetailEvent$CardAddedImplCopyWithImpl<
          _$TestDetailEvent$CardAddedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int testId) started,
    required TResult Function(String front, String back) cardAdded,
    required TResult Function(int cardId) cardDeleted,
    required TResult Function(CardEntity card) cardUpdated,
    required TResult Function(String title, String? description) testUpdated,
  }) {
    return cardAdded(front, back);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int testId)? started,
    TResult? Function(String front, String back)? cardAdded,
    TResult? Function(int cardId)? cardDeleted,
    TResult? Function(CardEntity card)? cardUpdated,
    TResult? Function(String title, String? description)? testUpdated,
  }) {
    return cardAdded?.call(front, back);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int testId)? started,
    TResult Function(String front, String back)? cardAdded,
    TResult Function(int cardId)? cardDeleted,
    TResult Function(CardEntity card)? cardUpdated,
    TResult Function(String title, String? description)? testUpdated,
    required TResult orElse(),
  }) {
    if (cardAdded != null) {
      return cardAdded(front, back);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TestDetailEvent$Started value) started,
    required TResult Function(_TestDetailEvent$CardAdded value) cardAdded,
    required TResult Function(_TestDetailEvent$CardDeleted value) cardDeleted,
    required TResult Function(_TestDetailEvent$CardUpdated value) cardUpdated,
    required TResult Function(_TestDetailEvent$TestUpdated value) testUpdated,
  }) {
    return cardAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestDetailEvent$Started value)? started,
    TResult? Function(_TestDetailEvent$CardAdded value)? cardAdded,
    TResult? Function(_TestDetailEvent$CardDeleted value)? cardDeleted,
    TResult? Function(_TestDetailEvent$CardUpdated value)? cardUpdated,
    TResult? Function(_TestDetailEvent$TestUpdated value)? testUpdated,
  }) {
    return cardAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestDetailEvent$Started value)? started,
    TResult Function(_TestDetailEvent$CardAdded value)? cardAdded,
    TResult Function(_TestDetailEvent$CardDeleted value)? cardDeleted,
    TResult Function(_TestDetailEvent$CardUpdated value)? cardUpdated,
    TResult Function(_TestDetailEvent$TestUpdated value)? testUpdated,
    required TResult orElse(),
  }) {
    if (cardAdded != null) {
      return cardAdded(this);
    }
    return orElse();
  }
}

abstract class _TestDetailEvent$CardAdded implements TestDetailEvent {
  const factory _TestDetailEvent$CardAdded(
      {required final String front,
      required final String back}) = _$TestDetailEvent$CardAddedImpl;

  String get front;
  String get back;
  @JsonKey(ignore: true)
  _$$TestDetailEvent$CardAddedImplCopyWith<_$TestDetailEvent$CardAddedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestDetailEvent$CardDeletedImplCopyWith<$Res> {
  factory _$$TestDetailEvent$CardDeletedImplCopyWith(
          _$TestDetailEvent$CardDeletedImpl value,
          $Res Function(_$TestDetailEvent$CardDeletedImpl) then) =
      __$$TestDetailEvent$CardDeletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int cardId});
}

/// @nodoc
class __$$TestDetailEvent$CardDeletedImplCopyWithImpl<$Res>
    extends _$TestDetailEventCopyWithImpl<$Res,
        _$TestDetailEvent$CardDeletedImpl>
    implements _$$TestDetailEvent$CardDeletedImplCopyWith<$Res> {
  __$$TestDetailEvent$CardDeletedImplCopyWithImpl(
      _$TestDetailEvent$CardDeletedImpl _value,
      $Res Function(_$TestDetailEvent$CardDeletedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
  }) {
    return _then(_$TestDetailEvent$CardDeletedImpl(
      cardId: null == cardId
          ? _value.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TestDetailEvent$CardDeletedImpl
    implements _TestDetailEvent$CardDeleted {
  const _$TestDetailEvent$CardDeletedImpl({required this.cardId});

  @override
  final int cardId;

  @override
  String toString() {
    return 'TestDetailEvent.cardDeleted(cardId: $cardId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestDetailEvent$CardDeletedImpl &&
            (identical(other.cardId, cardId) || other.cardId == cardId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cardId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestDetailEvent$CardDeletedImplCopyWith<_$TestDetailEvent$CardDeletedImpl>
      get copyWith => __$$TestDetailEvent$CardDeletedImplCopyWithImpl<
          _$TestDetailEvent$CardDeletedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int testId) started,
    required TResult Function(String front, String back) cardAdded,
    required TResult Function(int cardId) cardDeleted,
    required TResult Function(CardEntity card) cardUpdated,
    required TResult Function(String title, String? description) testUpdated,
  }) {
    return cardDeleted(cardId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int testId)? started,
    TResult? Function(String front, String back)? cardAdded,
    TResult? Function(int cardId)? cardDeleted,
    TResult? Function(CardEntity card)? cardUpdated,
    TResult? Function(String title, String? description)? testUpdated,
  }) {
    return cardDeleted?.call(cardId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int testId)? started,
    TResult Function(String front, String back)? cardAdded,
    TResult Function(int cardId)? cardDeleted,
    TResult Function(CardEntity card)? cardUpdated,
    TResult Function(String title, String? description)? testUpdated,
    required TResult orElse(),
  }) {
    if (cardDeleted != null) {
      return cardDeleted(cardId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TestDetailEvent$Started value) started,
    required TResult Function(_TestDetailEvent$CardAdded value) cardAdded,
    required TResult Function(_TestDetailEvent$CardDeleted value) cardDeleted,
    required TResult Function(_TestDetailEvent$CardUpdated value) cardUpdated,
    required TResult Function(_TestDetailEvent$TestUpdated value) testUpdated,
  }) {
    return cardDeleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestDetailEvent$Started value)? started,
    TResult? Function(_TestDetailEvent$CardAdded value)? cardAdded,
    TResult? Function(_TestDetailEvent$CardDeleted value)? cardDeleted,
    TResult? Function(_TestDetailEvent$CardUpdated value)? cardUpdated,
    TResult? Function(_TestDetailEvent$TestUpdated value)? testUpdated,
  }) {
    return cardDeleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestDetailEvent$Started value)? started,
    TResult Function(_TestDetailEvent$CardAdded value)? cardAdded,
    TResult Function(_TestDetailEvent$CardDeleted value)? cardDeleted,
    TResult Function(_TestDetailEvent$CardUpdated value)? cardUpdated,
    TResult Function(_TestDetailEvent$TestUpdated value)? testUpdated,
    required TResult orElse(),
  }) {
    if (cardDeleted != null) {
      return cardDeleted(this);
    }
    return orElse();
  }
}

abstract class _TestDetailEvent$CardDeleted implements TestDetailEvent {
  const factory _TestDetailEvent$CardDeleted({required final int cardId}) =
      _$TestDetailEvent$CardDeletedImpl;

  int get cardId;
  @JsonKey(ignore: true)
  _$$TestDetailEvent$CardDeletedImplCopyWith<_$TestDetailEvent$CardDeletedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestDetailEvent$CardUpdatedImplCopyWith<$Res> {
  factory _$$TestDetailEvent$CardUpdatedImplCopyWith(
          _$TestDetailEvent$CardUpdatedImpl value,
          $Res Function(_$TestDetailEvent$CardUpdatedImpl) then) =
      __$$TestDetailEvent$CardUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CardEntity card});

  $CardEntityCopyWith<$Res> get card;
}

/// @nodoc
class __$$TestDetailEvent$CardUpdatedImplCopyWithImpl<$Res>
    extends _$TestDetailEventCopyWithImpl<$Res,
        _$TestDetailEvent$CardUpdatedImpl>
    implements _$$TestDetailEvent$CardUpdatedImplCopyWith<$Res> {
  __$$TestDetailEvent$CardUpdatedImplCopyWithImpl(
      _$TestDetailEvent$CardUpdatedImpl _value,
      $Res Function(_$TestDetailEvent$CardUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? card = null,
  }) {
    return _then(_$TestDetailEvent$CardUpdatedImpl(
      card: null == card
          ? _value.card
          : card // ignore: cast_nullable_to_non_nullable
              as CardEntity,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $CardEntityCopyWith<$Res> get card {
    return $CardEntityCopyWith<$Res>(_value.card, (value) {
      return _then(_value.copyWith(card: value));
    });
  }
}

/// @nodoc

class _$TestDetailEvent$CardUpdatedImpl
    implements _TestDetailEvent$CardUpdated {
  const _$TestDetailEvent$CardUpdatedImpl({required this.card});

  @override
  final CardEntity card;

  @override
  String toString() {
    return 'TestDetailEvent.cardUpdated(card: $card)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestDetailEvent$CardUpdatedImpl &&
            (identical(other.card, card) || other.card == card));
  }

  @override
  int get hashCode => Object.hash(runtimeType, card);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestDetailEvent$CardUpdatedImplCopyWith<_$TestDetailEvent$CardUpdatedImpl>
      get copyWith => __$$TestDetailEvent$CardUpdatedImplCopyWithImpl<
          _$TestDetailEvent$CardUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int testId) started,
    required TResult Function(String front, String back) cardAdded,
    required TResult Function(int cardId) cardDeleted,
    required TResult Function(CardEntity card) cardUpdated,
    required TResult Function(String title, String? description) testUpdated,
  }) {
    return cardUpdated(card);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int testId)? started,
    TResult? Function(String front, String back)? cardAdded,
    TResult? Function(int cardId)? cardDeleted,
    TResult? Function(CardEntity card)? cardUpdated,
    TResult? Function(String title, String? description)? testUpdated,
  }) {
    return cardUpdated?.call(card);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int testId)? started,
    TResult Function(String front, String back)? cardAdded,
    TResult Function(int cardId)? cardDeleted,
    TResult Function(CardEntity card)? cardUpdated,
    TResult Function(String title, String? description)? testUpdated,
    required TResult orElse(),
  }) {
    if (cardUpdated != null) {
      return cardUpdated(card);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TestDetailEvent$Started value) started,
    required TResult Function(_TestDetailEvent$CardAdded value) cardAdded,
    required TResult Function(_TestDetailEvent$CardDeleted value) cardDeleted,
    required TResult Function(_TestDetailEvent$CardUpdated value) cardUpdated,
    required TResult Function(_TestDetailEvent$TestUpdated value) testUpdated,
  }) {
    return cardUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestDetailEvent$Started value)? started,
    TResult? Function(_TestDetailEvent$CardAdded value)? cardAdded,
    TResult? Function(_TestDetailEvent$CardDeleted value)? cardDeleted,
    TResult? Function(_TestDetailEvent$CardUpdated value)? cardUpdated,
    TResult? Function(_TestDetailEvent$TestUpdated value)? testUpdated,
  }) {
    return cardUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestDetailEvent$Started value)? started,
    TResult Function(_TestDetailEvent$CardAdded value)? cardAdded,
    TResult Function(_TestDetailEvent$CardDeleted value)? cardDeleted,
    TResult Function(_TestDetailEvent$CardUpdated value)? cardUpdated,
    TResult Function(_TestDetailEvent$TestUpdated value)? testUpdated,
    required TResult orElse(),
  }) {
    if (cardUpdated != null) {
      return cardUpdated(this);
    }
    return orElse();
  }
}

abstract class _TestDetailEvent$CardUpdated implements TestDetailEvent {
  const factory _TestDetailEvent$CardUpdated({required final CardEntity card}) =
      _$TestDetailEvent$CardUpdatedImpl;

  CardEntity get card;
  @JsonKey(ignore: true)
  _$$TestDetailEvent$CardUpdatedImplCopyWith<_$TestDetailEvent$CardUpdatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestDetailEvent$TestUpdatedImplCopyWith<$Res> {
  factory _$$TestDetailEvent$TestUpdatedImplCopyWith(
          _$TestDetailEvent$TestUpdatedImpl value,
          $Res Function(_$TestDetailEvent$TestUpdatedImpl) then) =
      __$$TestDetailEvent$TestUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title, String? description});
}

/// @nodoc
class __$$TestDetailEvent$TestUpdatedImplCopyWithImpl<$Res>
    extends _$TestDetailEventCopyWithImpl<$Res,
        _$TestDetailEvent$TestUpdatedImpl>
    implements _$$TestDetailEvent$TestUpdatedImplCopyWith<$Res> {
  __$$TestDetailEvent$TestUpdatedImplCopyWithImpl(
      _$TestDetailEvent$TestUpdatedImpl _value,
      $Res Function(_$TestDetailEvent$TestUpdatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
  }) {
    return _then(_$TestDetailEvent$TestUpdatedImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TestDetailEvent$TestUpdatedImpl
    implements _TestDetailEvent$TestUpdated {
  const _$TestDetailEvent$TestUpdatedImpl(
      {required this.title, this.description});

  @override
  final String title;
  @override
  final String? description;

  @override
  String toString() {
    return 'TestDetailEvent.testUpdated(title: $title, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestDetailEvent$TestUpdatedImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestDetailEvent$TestUpdatedImplCopyWith<_$TestDetailEvent$TestUpdatedImpl>
      get copyWith => __$$TestDetailEvent$TestUpdatedImplCopyWithImpl<
          _$TestDetailEvent$TestUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int testId) started,
    required TResult Function(String front, String back) cardAdded,
    required TResult Function(int cardId) cardDeleted,
    required TResult Function(CardEntity card) cardUpdated,
    required TResult Function(String title, String? description) testUpdated,
  }) {
    return testUpdated(title, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int testId)? started,
    TResult? Function(String front, String back)? cardAdded,
    TResult? Function(int cardId)? cardDeleted,
    TResult? Function(CardEntity card)? cardUpdated,
    TResult? Function(String title, String? description)? testUpdated,
  }) {
    return testUpdated?.call(title, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int testId)? started,
    TResult Function(String front, String back)? cardAdded,
    TResult Function(int cardId)? cardDeleted,
    TResult Function(CardEntity card)? cardUpdated,
    TResult Function(String title, String? description)? testUpdated,
    required TResult orElse(),
  }) {
    if (testUpdated != null) {
      return testUpdated(title, description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TestDetailEvent$Started value) started,
    required TResult Function(_TestDetailEvent$CardAdded value) cardAdded,
    required TResult Function(_TestDetailEvent$CardDeleted value) cardDeleted,
    required TResult Function(_TestDetailEvent$CardUpdated value) cardUpdated,
    required TResult Function(_TestDetailEvent$TestUpdated value) testUpdated,
  }) {
    return testUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TestDetailEvent$Started value)? started,
    TResult? Function(_TestDetailEvent$CardAdded value)? cardAdded,
    TResult? Function(_TestDetailEvent$CardDeleted value)? cardDeleted,
    TResult? Function(_TestDetailEvent$CardUpdated value)? cardUpdated,
    TResult? Function(_TestDetailEvent$TestUpdated value)? testUpdated,
  }) {
    return testUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TestDetailEvent$Started value)? started,
    TResult Function(_TestDetailEvent$CardAdded value)? cardAdded,
    TResult Function(_TestDetailEvent$CardDeleted value)? cardDeleted,
    TResult Function(_TestDetailEvent$CardUpdated value)? cardUpdated,
    TResult Function(_TestDetailEvent$TestUpdated value)? testUpdated,
    required TResult orElse(),
  }) {
    if (testUpdated != null) {
      return testUpdated(this);
    }
    return orElse();
  }
}

abstract class _TestDetailEvent$TestUpdated implements TestDetailEvent {
  const factory _TestDetailEvent$TestUpdated(
      {required final String title,
      final String? description}) = _$TestDetailEvent$TestUpdatedImpl;

  String get title;
  String? get description;
  @JsonKey(ignore: true)
  _$$TestDetailEvent$TestUpdatedImplCopyWith<_$TestDetailEvent$TestUpdatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TestDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(TestEntity test, List<CardEntity> cards) loaded,
    required TResult Function(Failure failure) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(TestEntity test, List<CardEntity> cards)? loaded,
    TResult? Function(Failure failure)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(TestEntity test, List<CardEntity> cards)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestDetailState$Loading value) loading,
    required TResult Function(TestDetailState$Loaded value) loaded,
    required TResult Function(TestDetailState$Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestDetailState$Loading value)? loading,
    TResult? Function(TestDetailState$Loaded value)? loaded,
    TResult? Function(TestDetailState$Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestDetailState$Loading value)? loading,
    TResult Function(TestDetailState$Loaded value)? loaded,
    TResult Function(TestDetailState$Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestDetailStateCopyWith<$Res> {
  factory $TestDetailStateCopyWith(
          TestDetailState value, $Res Function(TestDetailState) then) =
      _$TestDetailStateCopyWithImpl<$Res, TestDetailState>;
}

/// @nodoc
class _$TestDetailStateCopyWithImpl<$Res, $Val extends TestDetailState>
    implements $TestDetailStateCopyWith<$Res> {
  _$TestDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TestDetailState$LoadingImplCopyWith<$Res> {
  factory _$$TestDetailState$LoadingImplCopyWith(
          _$TestDetailState$LoadingImpl value,
          $Res Function(_$TestDetailState$LoadingImpl) then) =
      __$$TestDetailState$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TestDetailState$LoadingImplCopyWithImpl<$Res>
    extends _$TestDetailStateCopyWithImpl<$Res, _$TestDetailState$LoadingImpl>
    implements _$$TestDetailState$LoadingImplCopyWith<$Res> {
  __$$TestDetailState$LoadingImplCopyWithImpl(
      _$TestDetailState$LoadingImpl _value,
      $Res Function(_$TestDetailState$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TestDetailState$LoadingImpl extends TestDetailState$Loading {
  const _$TestDetailState$LoadingImpl() : super._();

  @override
  String toString() {
    return 'TestDetailState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestDetailState$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(TestEntity test, List<CardEntity> cards) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(TestEntity test, List<CardEntity> cards)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(TestEntity test, List<CardEntity> cards)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestDetailState$Loading value) loading,
    required TResult Function(TestDetailState$Loaded value) loaded,
    required TResult Function(TestDetailState$Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestDetailState$Loading value)? loading,
    TResult? Function(TestDetailState$Loaded value)? loaded,
    TResult? Function(TestDetailState$Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestDetailState$Loading value)? loading,
    TResult Function(TestDetailState$Loaded value)? loaded,
    TResult Function(TestDetailState$Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TestDetailState$Loading extends TestDetailState {
  const factory TestDetailState$Loading() = _$TestDetailState$LoadingImpl;
  const TestDetailState$Loading._() : super._();
}

/// @nodoc
abstract class _$$TestDetailState$LoadedImplCopyWith<$Res> {
  factory _$$TestDetailState$LoadedImplCopyWith(
          _$TestDetailState$LoadedImpl value,
          $Res Function(_$TestDetailState$LoadedImpl) then) =
      __$$TestDetailState$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TestEntity test, List<CardEntity> cards});

  $TestEntityCopyWith<$Res> get test;
}

/// @nodoc
class __$$TestDetailState$LoadedImplCopyWithImpl<$Res>
    extends _$TestDetailStateCopyWithImpl<$Res, _$TestDetailState$LoadedImpl>
    implements _$$TestDetailState$LoadedImplCopyWith<$Res> {
  __$$TestDetailState$LoadedImplCopyWithImpl(
      _$TestDetailState$LoadedImpl _value,
      $Res Function(_$TestDetailState$LoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? test = null,
    Object? cards = null,
  }) {
    return _then(_$TestDetailState$LoadedImpl(
      test: null == test
          ? _value.test
          : test // ignore: cast_nullable_to_non_nullable
              as TestEntity,
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardEntity>,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TestEntityCopyWith<$Res> get test {
    return $TestEntityCopyWith<$Res>(_value.test, (value) {
      return _then(_value.copyWith(test: value));
    });
  }
}

/// @nodoc

class _$TestDetailState$LoadedImpl extends TestDetailState$Loaded {
  const _$TestDetailState$LoadedImpl(
      {required this.test, required final List<CardEntity> cards})
      : _cards = cards,
        super._();

  @override
  final TestEntity test;
  final List<CardEntity> _cards;
  @override
  List<CardEntity> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  String toString() {
    return 'TestDetailState.loaded(test: $test, cards: $cards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestDetailState$LoadedImpl &&
            (identical(other.test, test) || other.test == test) &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, test, const DeepCollectionEquality().hash(_cards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestDetailState$LoadedImplCopyWith<_$TestDetailState$LoadedImpl>
      get copyWith => __$$TestDetailState$LoadedImplCopyWithImpl<
          _$TestDetailState$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(TestEntity test, List<CardEntity> cards) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return loaded(test, cards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(TestEntity test, List<CardEntity> cards)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return loaded?.call(test, cards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(TestEntity test, List<CardEntity> cards)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(test, cards);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestDetailState$Loading value) loading,
    required TResult Function(TestDetailState$Loaded value) loaded,
    required TResult Function(TestDetailState$Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestDetailState$Loading value)? loading,
    TResult? Function(TestDetailState$Loaded value)? loaded,
    TResult? Function(TestDetailState$Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestDetailState$Loading value)? loading,
    TResult Function(TestDetailState$Loaded value)? loaded,
    TResult Function(TestDetailState$Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TestDetailState$Loaded extends TestDetailState {
  const factory TestDetailState$Loaded(
      {required final TestEntity test,
      required final List<CardEntity> cards}) = _$TestDetailState$LoadedImpl;
  const TestDetailState$Loaded._() : super._();

  TestEntity get test;
  List<CardEntity> get cards;
  @JsonKey(ignore: true)
  _$$TestDetailState$LoadedImplCopyWith<_$TestDetailState$LoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TestDetailState$ErrorImplCopyWith<$Res> {
  factory _$$TestDetailState$ErrorImplCopyWith(
          _$TestDetailState$ErrorImpl value,
          $Res Function(_$TestDetailState$ErrorImpl) then) =
      __$$TestDetailState$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Failure failure});
}

/// @nodoc
class __$$TestDetailState$ErrorImplCopyWithImpl<$Res>
    extends _$TestDetailStateCopyWithImpl<$Res, _$TestDetailState$ErrorImpl>
    implements _$$TestDetailState$ErrorImplCopyWith<$Res> {
  __$$TestDetailState$ErrorImplCopyWithImpl(_$TestDetailState$ErrorImpl _value,
      $Res Function(_$TestDetailState$ErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? failure = null,
  }) {
    return _then(_$TestDetailState$ErrorImpl(
      failure: null == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

/// @nodoc

class _$TestDetailState$ErrorImpl extends TestDetailState$Error {
  const _$TestDetailState$ErrorImpl({required this.failure}) : super._();

  @override
  final Failure failure;

  @override
  String toString() {
    return 'TestDetailState.error(failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestDetailState$ErrorImpl &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(runtimeType, failure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestDetailState$ErrorImplCopyWith<_$TestDetailState$ErrorImpl>
      get copyWith => __$$TestDetailState$ErrorImplCopyWithImpl<
          _$TestDetailState$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(TestEntity test, List<CardEntity> cards) loaded,
    required TResult Function(Failure failure) error,
  }) {
    return error(failure);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(TestEntity test, List<CardEntity> cards)? loaded,
    TResult? Function(Failure failure)? error,
  }) {
    return error?.call(failure);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(TestEntity test, List<CardEntity> cards)? loaded,
    TResult Function(Failure failure)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TestDetailState$Loading value) loading,
    required TResult Function(TestDetailState$Loaded value) loaded,
    required TResult Function(TestDetailState$Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TestDetailState$Loading value)? loading,
    TResult? Function(TestDetailState$Loaded value)? loaded,
    TResult? Function(TestDetailState$Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TestDetailState$Loading value)? loading,
    TResult Function(TestDetailState$Loaded value)? loaded,
    TResult Function(TestDetailState$Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TestDetailState$Error extends TestDetailState {
  const factory TestDetailState$Error({required final Failure failure}) =
      _$TestDetailState$ErrorImpl;
  const TestDetailState$Error._() : super._();

  Failure get failure;
  @JsonKey(ignore: true)
  _$$TestDetailState$ErrorImplCopyWith<_$TestDetailState$ErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}
