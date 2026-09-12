// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MainEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MainEvent()';
}


}

/// @nodoc
class $MainEventCopyWith<$Res>  {
$MainEventCopyWith(MainEvent _, $Res Function(MainEvent) __);
}


/// Adds pattern-matching-related methods to [MainEvent].
extension MainEventPatterns on MainEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MainEvent$LoadCards value)?  loadCards,TResult Function( MainEvent$AddCard value)?  addCard,TResult Function( MainEvent$UpdateCard value)?  updateCard,TResult Function( MainEvent$DeleteCard value)?  deleteCard,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MainEvent$LoadCards() when loadCards != null:
return loadCards(_that);case MainEvent$AddCard() when addCard != null:
return addCard(_that);case MainEvent$UpdateCard() when updateCard != null:
return updateCard(_that);case MainEvent$DeleteCard() when deleteCard != null:
return deleteCard(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MainEvent$LoadCards value)  loadCards,required TResult Function( MainEvent$AddCard value)  addCard,required TResult Function( MainEvent$UpdateCard value)  updateCard,required TResult Function( MainEvent$DeleteCard value)  deleteCard,}){
final _that = this;
switch (_that) {
case MainEvent$LoadCards():
return loadCards(_that);case MainEvent$AddCard():
return addCard(_that);case MainEvent$UpdateCard():
return updateCard(_that);case MainEvent$DeleteCard():
return deleteCard(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MainEvent$LoadCards value)?  loadCards,TResult? Function( MainEvent$AddCard value)?  addCard,TResult? Function( MainEvent$UpdateCard value)?  updateCard,TResult? Function( MainEvent$DeleteCard value)?  deleteCard,}){
final _that = this;
switch (_that) {
case MainEvent$LoadCards() when loadCards != null:
return loadCards(_that);case MainEvent$AddCard() when addCard != null:
return addCard(_that);case MainEvent$UpdateCard() when updateCard != null:
return updateCard(_that);case MainEvent$DeleteCard() when deleteCard != null:
return deleteCard(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadCards,TResult Function( CardEntity card)?  addCard,TResult Function( CardEntity oldCard,  CardEntity newCard)?  updateCard,TResult Function( CardEntity card)?  deleteCard,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MainEvent$LoadCards() when loadCards != null:
return loadCards();case MainEvent$AddCard() when addCard != null:
return addCard(_that.card);case MainEvent$UpdateCard() when updateCard != null:
return updateCard(_that.oldCard,_that.newCard);case MainEvent$DeleteCard() when deleteCard != null:
return deleteCard(_that.card);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadCards,required TResult Function( CardEntity card)  addCard,required TResult Function( CardEntity oldCard,  CardEntity newCard)  updateCard,required TResult Function( CardEntity card)  deleteCard,}) {final _that = this;
switch (_that) {
case MainEvent$LoadCards():
return loadCards();case MainEvent$AddCard():
return addCard(_that.card);case MainEvent$UpdateCard():
return updateCard(_that.oldCard,_that.newCard);case MainEvent$DeleteCard():
return deleteCard(_that.card);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadCards,TResult? Function( CardEntity card)?  addCard,TResult? Function( CardEntity oldCard,  CardEntity newCard)?  updateCard,TResult? Function( CardEntity card)?  deleteCard,}) {final _that = this;
switch (_that) {
case MainEvent$LoadCards() when loadCards != null:
return loadCards();case MainEvent$AddCard() when addCard != null:
return addCard(_that.card);case MainEvent$UpdateCard() when updateCard != null:
return updateCard(_that.oldCard,_that.newCard);case MainEvent$DeleteCard() when deleteCard != null:
return deleteCard(_that.card);case _:
  return null;

}
}

}

/// @nodoc


class MainEvent$LoadCards implements MainEvent {
  const MainEvent$LoadCards();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainEvent$LoadCards);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MainEvent.loadCards()';
}


}




/// @nodoc


class MainEvent$AddCard implements MainEvent {
  const MainEvent$AddCard(this.card);
  

 final  CardEntity card;

/// Create a copy of MainEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainEvent$AddCardCopyWith<MainEvent$AddCard> get copyWith => _$MainEvent$AddCardCopyWithImpl<MainEvent$AddCard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainEvent$AddCard&&(identical(other.card, card) || other.card == card));
}


@override
int get hashCode => Object.hash(runtimeType,card);

@override
String toString() {
  return 'MainEvent.addCard(card: $card)';
}


}

/// @nodoc
abstract mixin class $MainEvent$AddCardCopyWith<$Res> implements $MainEventCopyWith<$Res> {
  factory $MainEvent$AddCardCopyWith(MainEvent$AddCard value, $Res Function(MainEvent$AddCard) _then) = _$MainEvent$AddCardCopyWithImpl;
@useResult
$Res call({
 CardEntity card
});


$CardEntityCopyWith<$Res> get card;

}
/// @nodoc
class _$MainEvent$AddCardCopyWithImpl<$Res>
    implements $MainEvent$AddCardCopyWith<$Res> {
  _$MainEvent$AddCardCopyWithImpl(this._self, this._then);

  final MainEvent$AddCard _self;
  final $Res Function(MainEvent$AddCard) _then;

/// Create a copy of MainEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? card = null,}) {
  return _then(MainEvent$AddCard(
null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as CardEntity,
  ));
}

/// Create a copy of MainEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardEntityCopyWith<$Res> get card {
  
  return $CardEntityCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}
}

/// @nodoc


class MainEvent$UpdateCard implements MainEvent {
  const MainEvent$UpdateCard({required this.oldCard, required this.newCard});
  

 final  CardEntity oldCard;
 final  CardEntity newCard;

/// Create a copy of MainEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainEvent$UpdateCardCopyWith<MainEvent$UpdateCard> get copyWith => _$MainEvent$UpdateCardCopyWithImpl<MainEvent$UpdateCard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainEvent$UpdateCard&&(identical(other.oldCard, oldCard) || other.oldCard == oldCard)&&(identical(other.newCard, newCard) || other.newCard == newCard));
}


@override
int get hashCode => Object.hash(runtimeType,oldCard,newCard);

@override
String toString() {
  return 'MainEvent.updateCard(oldCard: $oldCard, newCard: $newCard)';
}


}

/// @nodoc
abstract mixin class $MainEvent$UpdateCardCopyWith<$Res> implements $MainEventCopyWith<$Res> {
  factory $MainEvent$UpdateCardCopyWith(MainEvent$UpdateCard value, $Res Function(MainEvent$UpdateCard) _then) = _$MainEvent$UpdateCardCopyWithImpl;
@useResult
$Res call({
 CardEntity oldCard, CardEntity newCard
});


$CardEntityCopyWith<$Res> get oldCard;$CardEntityCopyWith<$Res> get newCard;

}
/// @nodoc
class _$MainEvent$UpdateCardCopyWithImpl<$Res>
    implements $MainEvent$UpdateCardCopyWith<$Res> {
  _$MainEvent$UpdateCardCopyWithImpl(this._self, this._then);

  final MainEvent$UpdateCard _self;
  final $Res Function(MainEvent$UpdateCard) _then;

/// Create a copy of MainEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldCard = null,Object? newCard = null,}) {
  return _then(MainEvent$UpdateCard(
oldCard: null == oldCard ? _self.oldCard : oldCard // ignore: cast_nullable_to_non_nullable
as CardEntity,newCard: null == newCard ? _self.newCard : newCard // ignore: cast_nullable_to_non_nullable
as CardEntity,
  ));
}

/// Create a copy of MainEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardEntityCopyWith<$Res> get oldCard {
  
  return $CardEntityCopyWith<$Res>(_self.oldCard, (value) {
    return _then(_self.copyWith(oldCard: value));
  });
}/// Create a copy of MainEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardEntityCopyWith<$Res> get newCard {
  
  return $CardEntityCopyWith<$Res>(_self.newCard, (value) {
    return _then(_self.copyWith(newCard: value));
  });
}
}

/// @nodoc


class MainEvent$DeleteCard implements MainEvent {
  const MainEvent$DeleteCard(this.card);
  

 final  CardEntity card;

/// Create a copy of MainEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainEvent$DeleteCardCopyWith<MainEvent$DeleteCard> get copyWith => _$MainEvent$DeleteCardCopyWithImpl<MainEvent$DeleteCard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainEvent$DeleteCard&&(identical(other.card, card) || other.card == card));
}


@override
int get hashCode => Object.hash(runtimeType,card);

@override
String toString() {
  return 'MainEvent.deleteCard(card: $card)';
}


}

/// @nodoc
abstract mixin class $MainEvent$DeleteCardCopyWith<$Res> implements $MainEventCopyWith<$Res> {
  factory $MainEvent$DeleteCardCopyWith(MainEvent$DeleteCard value, $Res Function(MainEvent$DeleteCard) _then) = _$MainEvent$DeleteCardCopyWithImpl;
@useResult
$Res call({
 CardEntity card
});


$CardEntityCopyWith<$Res> get card;

}
/// @nodoc
class _$MainEvent$DeleteCardCopyWithImpl<$Res>
    implements $MainEvent$DeleteCardCopyWith<$Res> {
  _$MainEvent$DeleteCardCopyWithImpl(this._self, this._then);

  final MainEvent$DeleteCard _self;
  final $Res Function(MainEvent$DeleteCard) _then;

/// Create a copy of MainEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? card = null,}) {
  return _then(MainEvent$DeleteCard(
null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as CardEntity,
  ));
}

/// Create a copy of MainEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardEntityCopyWith<$Res> get card {
  
  return $CardEntityCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}
}

/// @nodoc
mixin _$MainState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MainState()';
}


}

/// @nodoc
class $MainStateCopyWith<$Res>  {
$MainStateCopyWith(MainState _, $Res Function(MainState) __);
}


/// Adds pattern-matching-related methods to [MainState].
extension MainStatePatterns on MainState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MainState$Loading value)?  loading,TResult Function( MainState$Data value)?  data,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MainState$Loading() when loading != null:
return loading(_that);case MainState$Data() when data != null:
return data(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MainState$Loading value)  loading,required TResult Function( MainState$Data value)  data,}){
final _that = this;
switch (_that) {
case MainState$Loading():
return loading(_that);case MainState$Data():
return data(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MainState$Loading value)?  loading,TResult? Function( MainState$Data value)?  data,}){
final _that = this;
switch (_that) {
case MainState$Loading() when loading != null:
return loading(_that);case MainState$Data() when data != null:
return data(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<CardEntity> cards)?  data,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MainState$Loading() when loading != null:
return loading();case MainState$Data() when data != null:
return data(_that.cards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<CardEntity> cards)  data,}) {final _that = this;
switch (_that) {
case MainState$Loading():
return loading();case MainState$Data():
return data(_that.cards);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<CardEntity> cards)?  data,}) {final _that = this;
switch (_that) {
case MainState$Loading() when loading != null:
return loading();case MainState$Data() when data != null:
return data(_that.cards);case _:
  return null;

}
}

}

/// @nodoc


class MainState$Loading extends MainState {
  const MainState$Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainState$Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MainState.loading()';
}


}




/// @nodoc


class MainState$Data extends MainState {
  const MainState$Data({required final  List<CardEntity> cards}): _cards = cards,super._();
  

 final  List<CardEntity> _cards;
 List<CardEntity> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}


/// Create a copy of MainState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainState$DataCopyWith<MainState$Data> get copyWith => _$MainState$DataCopyWithImpl<MainState$Data>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainState$Data&&const DeepCollectionEquality().equals(other._cards, _cards));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cards));

@override
String toString() {
  return 'MainState.data(cards: $cards)';
}


}

/// @nodoc
abstract mixin class $MainState$DataCopyWith<$Res> implements $MainStateCopyWith<$Res> {
  factory $MainState$DataCopyWith(MainState$Data value, $Res Function(MainState$Data) _then) = _$MainState$DataCopyWithImpl;
@useResult
$Res call({
 List<CardEntity> cards
});




}
/// @nodoc
class _$MainState$DataCopyWithImpl<$Res>
    implements $MainState$DataCopyWith<$Res> {
  _$MainState$DataCopyWithImpl(this._self, this._then);

  final MainState$Data _self;
  final $Res Function(MainState$Data) _then;

/// Create a copy of MainState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cards = null,}) {
  return _then(MainState$Data(
cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardEntity>,
  ));
}


}

// dart format on
