// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MainEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCards,
    required TResult Function(CardEntity card) addCard,
    required TResult Function(CardEntity oldCard, CardEntity newCard)
        updateCard,
    required TResult Function(CardEntity card) deleteCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCards,
    TResult? Function(CardEntity card)? addCard,
    TResult? Function(CardEntity oldCard, CardEntity newCard)? updateCard,
    TResult? Function(CardEntity card)? deleteCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCards,
    TResult Function(CardEntity card)? addCard,
    TResult Function(CardEntity oldCard, CardEntity newCard)? updateCard,
    TResult Function(CardEntity card)? deleteCard,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEvent$LoadCards value) loadCards,
    required TResult Function(MainEvent$AddCard value) addCard,
    required TResult Function(MainEvent$UpdateCard value) updateCard,
    required TResult Function(MainEvent$DeleteCard value) deleteCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEvent$LoadCards value)? loadCards,
    TResult? Function(MainEvent$AddCard value)? addCard,
    TResult? Function(MainEvent$UpdateCard value)? updateCard,
    TResult? Function(MainEvent$DeleteCard value)? deleteCard,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEvent$LoadCards value)? loadCards,
    TResult Function(MainEvent$AddCard value)? addCard,
    TResult Function(MainEvent$UpdateCard value)? updateCard,
    TResult Function(MainEvent$DeleteCard value)? deleteCard,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainEventCopyWith<$Res> {
  factory $MainEventCopyWith(MainEvent value, $Res Function(MainEvent) then) =
      _$MainEventCopyWithImpl<$Res, MainEvent>;
}

/// @nodoc
class _$MainEventCopyWithImpl<$Res, $Val extends MainEvent>
    implements $MainEventCopyWith<$Res> {
  _$MainEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MainEvent$LoadCardsImplCopyWith<$Res> {
  factory _$$MainEvent$LoadCardsImplCopyWith(_$MainEvent$LoadCardsImpl value,
          $Res Function(_$MainEvent$LoadCardsImpl) then) =
      __$$MainEvent$LoadCardsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainEvent$LoadCardsImplCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEvent$LoadCardsImpl>
    implements _$$MainEvent$LoadCardsImplCopyWith<$Res> {
  __$$MainEvent$LoadCardsImplCopyWithImpl(_$MainEvent$LoadCardsImpl _value,
      $Res Function(_$MainEvent$LoadCardsImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MainEvent$LoadCardsImpl implements MainEvent$LoadCards {
  const _$MainEvent$LoadCardsImpl();

  @override
  String toString() {
    return 'MainEvent.loadCards()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEvent$LoadCardsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCards,
    required TResult Function(CardEntity card) addCard,
    required TResult Function(CardEntity oldCard, CardEntity newCard)
        updateCard,
    required TResult Function(CardEntity card) deleteCard,
  }) {
    return loadCards();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCards,
    TResult? Function(CardEntity card)? addCard,
    TResult? Function(CardEntity oldCard, CardEntity newCard)? updateCard,
    TResult? Function(CardEntity card)? deleteCard,
  }) {
    return loadCards?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCards,
    TResult Function(CardEntity card)? addCard,
    TResult Function(CardEntity oldCard, CardEntity newCard)? updateCard,
    TResult Function(CardEntity card)? deleteCard,
    required TResult orElse(),
  }) {
    if (loadCards != null) {
      return loadCards();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEvent$LoadCards value) loadCards,
    required TResult Function(MainEvent$AddCard value) addCard,
    required TResult Function(MainEvent$UpdateCard value) updateCard,
    required TResult Function(MainEvent$DeleteCard value) deleteCard,
  }) {
    return loadCards(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEvent$LoadCards value)? loadCards,
    TResult? Function(MainEvent$AddCard value)? addCard,
    TResult? Function(MainEvent$UpdateCard value)? updateCard,
    TResult? Function(MainEvent$DeleteCard value)? deleteCard,
  }) {
    return loadCards?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEvent$LoadCards value)? loadCards,
    TResult Function(MainEvent$AddCard value)? addCard,
    TResult Function(MainEvent$UpdateCard value)? updateCard,
    TResult Function(MainEvent$DeleteCard value)? deleteCard,
    required TResult orElse(),
  }) {
    if (loadCards != null) {
      return loadCards(this);
    }
    return orElse();
  }
}

abstract class MainEvent$LoadCards implements MainEvent {
  const factory MainEvent$LoadCards() = _$MainEvent$LoadCardsImpl;
}

/// @nodoc
abstract class _$$MainEvent$AddCardImplCopyWith<$Res> {
  factory _$$MainEvent$AddCardImplCopyWith(_$MainEvent$AddCardImpl value,
          $Res Function(_$MainEvent$AddCardImpl) then) =
      __$$MainEvent$AddCardImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CardEntity card});

  $CardEntityCopyWith<$Res> get card;
}

/// @nodoc
class __$$MainEvent$AddCardImplCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEvent$AddCardImpl>
    implements _$$MainEvent$AddCardImplCopyWith<$Res> {
  __$$MainEvent$AddCardImplCopyWithImpl(_$MainEvent$AddCardImpl _value,
      $Res Function(_$MainEvent$AddCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? card = null,
  }) {
    return _then(_$MainEvent$AddCardImpl(
      null == card
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

class _$MainEvent$AddCardImpl implements MainEvent$AddCard {
  const _$MainEvent$AddCardImpl(this.card);

  @override
  final CardEntity card;

  @override
  String toString() {
    return 'MainEvent.addCard(card: $card)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEvent$AddCardImpl &&
            (identical(other.card, card) || other.card == card));
  }

  @override
  int get hashCode => Object.hash(runtimeType, card);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainEvent$AddCardImplCopyWith<_$MainEvent$AddCardImpl> get copyWith =>
      __$$MainEvent$AddCardImplCopyWithImpl<_$MainEvent$AddCardImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCards,
    required TResult Function(CardEntity card) addCard,
    required TResult Function(CardEntity oldCard, CardEntity newCard)
        updateCard,
    required TResult Function(CardEntity card) deleteCard,
  }) {
    return addCard(card);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCards,
    TResult? Function(CardEntity card)? addCard,
    TResult? Function(CardEntity oldCard, CardEntity newCard)? updateCard,
    TResult? Function(CardEntity card)? deleteCard,
  }) {
    return addCard?.call(card);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCards,
    TResult Function(CardEntity card)? addCard,
    TResult Function(CardEntity oldCard, CardEntity newCard)? updateCard,
    TResult Function(CardEntity card)? deleteCard,
    required TResult orElse(),
  }) {
    if (addCard != null) {
      return addCard(card);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEvent$LoadCards value) loadCards,
    required TResult Function(MainEvent$AddCard value) addCard,
    required TResult Function(MainEvent$UpdateCard value) updateCard,
    required TResult Function(MainEvent$DeleteCard value) deleteCard,
  }) {
    return addCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEvent$LoadCards value)? loadCards,
    TResult? Function(MainEvent$AddCard value)? addCard,
    TResult? Function(MainEvent$UpdateCard value)? updateCard,
    TResult? Function(MainEvent$DeleteCard value)? deleteCard,
  }) {
    return addCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEvent$LoadCards value)? loadCards,
    TResult Function(MainEvent$AddCard value)? addCard,
    TResult Function(MainEvent$UpdateCard value)? updateCard,
    TResult Function(MainEvent$DeleteCard value)? deleteCard,
    required TResult orElse(),
  }) {
    if (addCard != null) {
      return addCard(this);
    }
    return orElse();
  }
}

abstract class MainEvent$AddCard implements MainEvent {
  const factory MainEvent$AddCard(final CardEntity card) =
      _$MainEvent$AddCardImpl;

  CardEntity get card;
  @JsonKey(ignore: true)
  _$$MainEvent$AddCardImplCopyWith<_$MainEvent$AddCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MainEvent$UpdateCardImplCopyWith<$Res> {
  factory _$$MainEvent$UpdateCardImplCopyWith(_$MainEvent$UpdateCardImpl value,
          $Res Function(_$MainEvent$UpdateCardImpl) then) =
      __$$MainEvent$UpdateCardImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CardEntity oldCard, CardEntity newCard});

  $CardEntityCopyWith<$Res> get oldCard;
  $CardEntityCopyWith<$Res> get newCard;
}

/// @nodoc
class __$$MainEvent$UpdateCardImplCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEvent$UpdateCardImpl>
    implements _$$MainEvent$UpdateCardImplCopyWith<$Res> {
  __$$MainEvent$UpdateCardImplCopyWithImpl(_$MainEvent$UpdateCardImpl _value,
      $Res Function(_$MainEvent$UpdateCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldCard = null,
    Object? newCard = null,
  }) {
    return _then(_$MainEvent$UpdateCardImpl(
      oldCard: null == oldCard
          ? _value.oldCard
          : oldCard // ignore: cast_nullable_to_non_nullable
              as CardEntity,
      newCard: null == newCard
          ? _value.newCard
          : newCard // ignore: cast_nullable_to_non_nullable
              as CardEntity,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $CardEntityCopyWith<$Res> get oldCard {
    return $CardEntityCopyWith<$Res>(_value.oldCard, (value) {
      return _then(_value.copyWith(oldCard: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CardEntityCopyWith<$Res> get newCard {
    return $CardEntityCopyWith<$Res>(_value.newCard, (value) {
      return _then(_value.copyWith(newCard: value));
    });
  }
}

/// @nodoc

class _$MainEvent$UpdateCardImpl implements MainEvent$UpdateCard {
  const _$MainEvent$UpdateCardImpl(
      {required this.oldCard, required this.newCard});

  @override
  final CardEntity oldCard;
  @override
  final CardEntity newCard;

  @override
  String toString() {
    return 'MainEvent.updateCard(oldCard: $oldCard, newCard: $newCard)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEvent$UpdateCardImpl &&
            (identical(other.oldCard, oldCard) || other.oldCard == oldCard) &&
            (identical(other.newCard, newCard) || other.newCard == newCard));
  }

  @override
  int get hashCode => Object.hash(runtimeType, oldCard, newCard);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainEvent$UpdateCardImplCopyWith<_$MainEvent$UpdateCardImpl>
      get copyWith =>
          __$$MainEvent$UpdateCardImplCopyWithImpl<_$MainEvent$UpdateCardImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCards,
    required TResult Function(CardEntity card) addCard,
    required TResult Function(CardEntity oldCard, CardEntity newCard)
        updateCard,
    required TResult Function(CardEntity card) deleteCard,
  }) {
    return updateCard(oldCard, newCard);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCards,
    TResult? Function(CardEntity card)? addCard,
    TResult? Function(CardEntity oldCard, CardEntity newCard)? updateCard,
    TResult? Function(CardEntity card)? deleteCard,
  }) {
    return updateCard?.call(oldCard, newCard);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCards,
    TResult Function(CardEntity card)? addCard,
    TResult Function(CardEntity oldCard, CardEntity newCard)? updateCard,
    TResult Function(CardEntity card)? deleteCard,
    required TResult orElse(),
  }) {
    if (updateCard != null) {
      return updateCard(oldCard, newCard);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEvent$LoadCards value) loadCards,
    required TResult Function(MainEvent$AddCard value) addCard,
    required TResult Function(MainEvent$UpdateCard value) updateCard,
    required TResult Function(MainEvent$DeleteCard value) deleteCard,
  }) {
    return updateCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEvent$LoadCards value)? loadCards,
    TResult? Function(MainEvent$AddCard value)? addCard,
    TResult? Function(MainEvent$UpdateCard value)? updateCard,
    TResult? Function(MainEvent$DeleteCard value)? deleteCard,
  }) {
    return updateCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEvent$LoadCards value)? loadCards,
    TResult Function(MainEvent$AddCard value)? addCard,
    TResult Function(MainEvent$UpdateCard value)? updateCard,
    TResult Function(MainEvent$DeleteCard value)? deleteCard,
    required TResult orElse(),
  }) {
    if (updateCard != null) {
      return updateCard(this);
    }
    return orElse();
  }
}

abstract class MainEvent$UpdateCard implements MainEvent {
  const factory MainEvent$UpdateCard(
      {required final CardEntity oldCard,
      required final CardEntity newCard}) = _$MainEvent$UpdateCardImpl;

  CardEntity get oldCard;
  CardEntity get newCard;
  @JsonKey(ignore: true)
  _$$MainEvent$UpdateCardImplCopyWith<_$MainEvent$UpdateCardImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MainEvent$DeleteCardImplCopyWith<$Res> {
  factory _$$MainEvent$DeleteCardImplCopyWith(_$MainEvent$DeleteCardImpl value,
          $Res Function(_$MainEvent$DeleteCardImpl) then) =
      __$$MainEvent$DeleteCardImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CardEntity card});

  $CardEntityCopyWith<$Res> get card;
}

/// @nodoc
class __$$MainEvent$DeleteCardImplCopyWithImpl<$Res>
    extends _$MainEventCopyWithImpl<$Res, _$MainEvent$DeleteCardImpl>
    implements _$$MainEvent$DeleteCardImplCopyWith<$Res> {
  __$$MainEvent$DeleteCardImplCopyWithImpl(_$MainEvent$DeleteCardImpl _value,
      $Res Function(_$MainEvent$DeleteCardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? card = null,
  }) {
    return _then(_$MainEvent$DeleteCardImpl(
      null == card
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

class _$MainEvent$DeleteCardImpl implements MainEvent$DeleteCard {
  const _$MainEvent$DeleteCardImpl(this.card);

  @override
  final CardEntity card;

  @override
  String toString() {
    return 'MainEvent.deleteCard(card: $card)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainEvent$DeleteCardImpl &&
            (identical(other.card, card) || other.card == card));
  }

  @override
  int get hashCode => Object.hash(runtimeType, card);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainEvent$DeleteCardImplCopyWith<_$MainEvent$DeleteCardImpl>
      get copyWith =>
          __$$MainEvent$DeleteCardImplCopyWithImpl<_$MainEvent$DeleteCardImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCards,
    required TResult Function(CardEntity card) addCard,
    required TResult Function(CardEntity oldCard, CardEntity newCard)
        updateCard,
    required TResult Function(CardEntity card) deleteCard,
  }) {
    return deleteCard(card);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCards,
    TResult? Function(CardEntity card)? addCard,
    TResult? Function(CardEntity oldCard, CardEntity newCard)? updateCard,
    TResult? Function(CardEntity card)? deleteCard,
  }) {
    return deleteCard?.call(card);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCards,
    TResult Function(CardEntity card)? addCard,
    TResult Function(CardEntity oldCard, CardEntity newCard)? updateCard,
    TResult Function(CardEntity card)? deleteCard,
    required TResult orElse(),
  }) {
    if (deleteCard != null) {
      return deleteCard(card);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainEvent$LoadCards value) loadCards,
    required TResult Function(MainEvent$AddCard value) addCard,
    required TResult Function(MainEvent$UpdateCard value) updateCard,
    required TResult Function(MainEvent$DeleteCard value) deleteCard,
  }) {
    return deleteCard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainEvent$LoadCards value)? loadCards,
    TResult? Function(MainEvent$AddCard value)? addCard,
    TResult? Function(MainEvent$UpdateCard value)? updateCard,
    TResult? Function(MainEvent$DeleteCard value)? deleteCard,
  }) {
    return deleteCard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainEvent$LoadCards value)? loadCards,
    TResult Function(MainEvent$AddCard value)? addCard,
    TResult Function(MainEvent$UpdateCard value)? updateCard,
    TResult Function(MainEvent$DeleteCard value)? deleteCard,
    required TResult orElse(),
  }) {
    if (deleteCard != null) {
      return deleteCard(this);
    }
    return orElse();
  }
}

abstract class MainEvent$DeleteCard implements MainEvent {
  const factory MainEvent$DeleteCard(final CardEntity card) =
      _$MainEvent$DeleteCardImpl;

  CardEntity get card;
  @JsonKey(ignore: true)
  _$$MainEvent$DeleteCardImplCopyWith<_$MainEvent$DeleteCardImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MainState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<CardEntity> cards) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CardEntity> cards)? data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CardEntity> cards)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainState$Loading value) loading,
    required TResult Function(MainState$Data value) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainState$Loading value)? loading,
    TResult? Function(MainState$Data value)? data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainState$Loading value)? loading,
    TResult Function(MainState$Data value)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainStateCopyWith<$Res> {
  factory $MainStateCopyWith(MainState value, $Res Function(MainState) then) =
      _$MainStateCopyWithImpl<$Res, MainState>;
}

/// @nodoc
class _$MainStateCopyWithImpl<$Res, $Val extends MainState>
    implements $MainStateCopyWith<$Res> {
  _$MainStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MainState$LoadingImplCopyWith<$Res> {
  factory _$$MainState$LoadingImplCopyWith(_$MainState$LoadingImpl value,
          $Res Function(_$MainState$LoadingImpl) then) =
      __$$MainState$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MainState$LoadingImplCopyWithImpl<$Res>
    extends _$MainStateCopyWithImpl<$Res, _$MainState$LoadingImpl>
    implements _$$MainState$LoadingImplCopyWith<$Res> {
  __$$MainState$LoadingImplCopyWithImpl(_$MainState$LoadingImpl _value,
      $Res Function(_$MainState$LoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MainState$LoadingImpl extends MainState$Loading {
  const _$MainState$LoadingImpl() : super._();

  @override
  String toString() {
    return 'MainState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MainState$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<CardEntity> cards) data,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CardEntity> cards)? data,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CardEntity> cards)? data,
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
    required TResult Function(MainState$Loading value) loading,
    required TResult Function(MainState$Data value) data,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainState$Loading value)? loading,
    TResult? Function(MainState$Data value)? data,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainState$Loading value)? loading,
    TResult Function(MainState$Data value)? data,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class MainState$Loading extends MainState {
  const factory MainState$Loading() = _$MainState$LoadingImpl;
  const MainState$Loading._() : super._();
}

/// @nodoc
abstract class _$$MainState$DataImplCopyWith<$Res> {
  factory _$$MainState$DataImplCopyWith(_$MainState$DataImpl value,
          $Res Function(_$MainState$DataImpl) then) =
      __$$MainState$DataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CardEntity> cards});
}

/// @nodoc
class __$$MainState$DataImplCopyWithImpl<$Res>
    extends _$MainStateCopyWithImpl<$Res, _$MainState$DataImpl>
    implements _$$MainState$DataImplCopyWith<$Res> {
  __$$MainState$DataImplCopyWithImpl(
      _$MainState$DataImpl _value, $Res Function(_$MainState$DataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
  }) {
    return _then(_$MainState$DataImpl(
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<CardEntity>,
    ));
  }
}

/// @nodoc

class _$MainState$DataImpl extends MainState$Data {
  const _$MainState$DataImpl({required final List<CardEntity> cards})
      : _cards = cards,
        super._();

  final List<CardEntity> _cards;
  @override
  List<CardEntity> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  String toString() {
    return 'MainState.data(cards: $cards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainState$DataImpl &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainState$DataImplCopyWith<_$MainState$DataImpl> get copyWith =>
      __$$MainState$DataImplCopyWithImpl<_$MainState$DataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<CardEntity> cards) data,
  }) {
    return data(cards);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CardEntity> cards)? data,
  }) {
    return data?.call(cards);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CardEntity> cards)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(cards);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MainState$Loading value) loading,
    required TResult Function(MainState$Data value) data,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MainState$Loading value)? loading,
    TResult? Function(MainState$Data value)? data,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MainState$Loading value)? loading,
    TResult Function(MainState$Data value)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class MainState$Data extends MainState {
  const factory MainState$Data({required final List<CardEntity> cards}) =
      _$MainState$DataImpl;
  const MainState$Data._() : super._();

  List<CardEntity> get cards;
  @JsonKey(ignore: true)
  _$$MainState$DataImplCopyWith<_$MainState$DataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
