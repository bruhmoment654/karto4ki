// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TestDetailEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestDetailEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TestDetailEvent()';
}


}

/// @nodoc
class $TestDetailEventCopyWith<$Res>  {
$TestDetailEventCopyWith(TestDetailEvent _, $Res Function(TestDetailEvent) __);
}


/// Adds pattern-matching-related methods to [TestDetailEvent].
extension TestDetailEventPatterns on TestDetailEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _TestDetailEvent$Started value)?  started,TResult Function( _TestDetailEvent$CardAdded value)?  cardAdded,TResult Function( _TestDetailEvent$CardDeleted value)?  cardDeleted,TResult Function( _TestDetailEvent$CardUpdated value)?  cardUpdated,TResult Function( _TestDetailEvent$TestUpdated value)?  testUpdated,TResult Function( _TestDetailEvent$CardsImported value)?  cardsImported,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TestDetailEvent$Started() when started != null:
return started(_that);case _TestDetailEvent$CardAdded() when cardAdded != null:
return cardAdded(_that);case _TestDetailEvent$CardDeleted() when cardDeleted != null:
return cardDeleted(_that);case _TestDetailEvent$CardUpdated() when cardUpdated != null:
return cardUpdated(_that);case _TestDetailEvent$TestUpdated() when testUpdated != null:
return testUpdated(_that);case _TestDetailEvent$CardsImported() when cardsImported != null:
return cardsImported(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _TestDetailEvent$Started value)  started,required TResult Function( _TestDetailEvent$CardAdded value)  cardAdded,required TResult Function( _TestDetailEvent$CardDeleted value)  cardDeleted,required TResult Function( _TestDetailEvent$CardUpdated value)  cardUpdated,required TResult Function( _TestDetailEvent$TestUpdated value)  testUpdated,required TResult Function( _TestDetailEvent$CardsImported value)  cardsImported,}){
final _that = this;
switch (_that) {
case _TestDetailEvent$Started():
return started(_that);case _TestDetailEvent$CardAdded():
return cardAdded(_that);case _TestDetailEvent$CardDeleted():
return cardDeleted(_that);case _TestDetailEvent$CardUpdated():
return cardUpdated(_that);case _TestDetailEvent$TestUpdated():
return testUpdated(_that);case _TestDetailEvent$CardsImported():
return cardsImported(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _TestDetailEvent$Started value)?  started,TResult? Function( _TestDetailEvent$CardAdded value)?  cardAdded,TResult? Function( _TestDetailEvent$CardDeleted value)?  cardDeleted,TResult? Function( _TestDetailEvent$CardUpdated value)?  cardUpdated,TResult? Function( _TestDetailEvent$TestUpdated value)?  testUpdated,TResult? Function( _TestDetailEvent$CardsImported value)?  cardsImported,}){
final _that = this;
switch (_that) {
case _TestDetailEvent$Started() when started != null:
return started(_that);case _TestDetailEvent$CardAdded() when cardAdded != null:
return cardAdded(_that);case _TestDetailEvent$CardDeleted() when cardDeleted != null:
return cardDeleted(_that);case _TestDetailEvent$CardUpdated() when cardUpdated != null:
return cardUpdated(_that);case _TestDetailEvent$TestUpdated() when testUpdated != null:
return testUpdated(_that);case _TestDetailEvent$CardsImported() when cardsImported != null:
return cardsImported(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String testId)?  started,TResult Function( String front,  String back)?  cardAdded,TResult Function( String cardId)?  cardDeleted,TResult Function( CardEntity card)?  cardUpdated,TResult Function( String title,  String? description)?  testUpdated,TResult Function( List<({String front, String back})> cards)?  cardsImported,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TestDetailEvent$Started() when started != null:
return started(_that.testId);case _TestDetailEvent$CardAdded() when cardAdded != null:
return cardAdded(_that.front,_that.back);case _TestDetailEvent$CardDeleted() when cardDeleted != null:
return cardDeleted(_that.cardId);case _TestDetailEvent$CardUpdated() when cardUpdated != null:
return cardUpdated(_that.card);case _TestDetailEvent$TestUpdated() when testUpdated != null:
return testUpdated(_that.title,_that.description);case _TestDetailEvent$CardsImported() when cardsImported != null:
return cardsImported(_that.cards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String testId)  started,required TResult Function( String front,  String back)  cardAdded,required TResult Function( String cardId)  cardDeleted,required TResult Function( CardEntity card)  cardUpdated,required TResult Function( String title,  String? description)  testUpdated,required TResult Function( List<({String front, String back})> cards)  cardsImported,}) {final _that = this;
switch (_that) {
case _TestDetailEvent$Started():
return started(_that.testId);case _TestDetailEvent$CardAdded():
return cardAdded(_that.front,_that.back);case _TestDetailEvent$CardDeleted():
return cardDeleted(_that.cardId);case _TestDetailEvent$CardUpdated():
return cardUpdated(_that.card);case _TestDetailEvent$TestUpdated():
return testUpdated(_that.title,_that.description);case _TestDetailEvent$CardsImported():
return cardsImported(_that.cards);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String testId)?  started,TResult? Function( String front,  String back)?  cardAdded,TResult? Function( String cardId)?  cardDeleted,TResult? Function( CardEntity card)?  cardUpdated,TResult? Function( String title,  String? description)?  testUpdated,TResult? Function( List<({String front, String back})> cards)?  cardsImported,}) {final _that = this;
switch (_that) {
case _TestDetailEvent$Started() when started != null:
return started(_that.testId);case _TestDetailEvent$CardAdded() when cardAdded != null:
return cardAdded(_that.front,_that.back);case _TestDetailEvent$CardDeleted() when cardDeleted != null:
return cardDeleted(_that.cardId);case _TestDetailEvent$CardUpdated() when cardUpdated != null:
return cardUpdated(_that.card);case _TestDetailEvent$TestUpdated() when testUpdated != null:
return testUpdated(_that.title,_that.description);case _TestDetailEvent$CardsImported() when cardsImported != null:
return cardsImported(_that.cards);case _:
  return null;

}
}

}

/// @nodoc


class _TestDetailEvent$Started implements TestDetailEvent {
  const _TestDetailEvent$Started({required this.testId});
  

 final  String testId;

/// Create a copy of TestDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestDetailEvent$StartedCopyWith<_TestDetailEvent$Started> get copyWith => __$TestDetailEvent$StartedCopyWithImpl<_TestDetailEvent$Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestDetailEvent$Started&&(identical(other.testId, testId) || other.testId == testId));
}


@override
int get hashCode => Object.hash(runtimeType,testId);

@override
String toString() {
  return 'TestDetailEvent.started(testId: $testId)';
}


}

/// @nodoc
abstract mixin class _$TestDetailEvent$StartedCopyWith<$Res> implements $TestDetailEventCopyWith<$Res> {
  factory _$TestDetailEvent$StartedCopyWith(_TestDetailEvent$Started value, $Res Function(_TestDetailEvent$Started) _then) = __$TestDetailEvent$StartedCopyWithImpl;
@useResult
$Res call({
 String testId
});




}
/// @nodoc
class __$TestDetailEvent$StartedCopyWithImpl<$Res>
    implements _$TestDetailEvent$StartedCopyWith<$Res> {
  __$TestDetailEvent$StartedCopyWithImpl(this._self, this._then);

  final _TestDetailEvent$Started _self;
  final $Res Function(_TestDetailEvent$Started) _then;

/// Create a copy of TestDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? testId = null,}) {
  return _then(_TestDetailEvent$Started(
testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TestDetailEvent$CardAdded implements TestDetailEvent {
  const _TestDetailEvent$CardAdded({required this.front, required this.back});
  

 final  String front;
 final  String back;

/// Create a copy of TestDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestDetailEvent$CardAddedCopyWith<_TestDetailEvent$CardAdded> get copyWith => __$TestDetailEvent$CardAddedCopyWithImpl<_TestDetailEvent$CardAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestDetailEvent$CardAdded&&(identical(other.front, front) || other.front == front)&&(identical(other.back, back) || other.back == back));
}


@override
int get hashCode => Object.hash(runtimeType,front,back);

@override
String toString() {
  return 'TestDetailEvent.cardAdded(front: $front, back: $back)';
}


}

/// @nodoc
abstract mixin class _$TestDetailEvent$CardAddedCopyWith<$Res> implements $TestDetailEventCopyWith<$Res> {
  factory _$TestDetailEvent$CardAddedCopyWith(_TestDetailEvent$CardAdded value, $Res Function(_TestDetailEvent$CardAdded) _then) = __$TestDetailEvent$CardAddedCopyWithImpl;
@useResult
$Res call({
 String front, String back
});




}
/// @nodoc
class __$TestDetailEvent$CardAddedCopyWithImpl<$Res>
    implements _$TestDetailEvent$CardAddedCopyWith<$Res> {
  __$TestDetailEvent$CardAddedCopyWithImpl(this._self, this._then);

  final _TestDetailEvent$CardAdded _self;
  final $Res Function(_TestDetailEvent$CardAdded) _then;

/// Create a copy of TestDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? front = null,Object? back = null,}) {
  return _then(_TestDetailEvent$CardAdded(
front: null == front ? _self.front : front // ignore: cast_nullable_to_non_nullable
as String,back: null == back ? _self.back : back // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TestDetailEvent$CardDeleted implements TestDetailEvent {
  const _TestDetailEvent$CardDeleted({required this.cardId});
  

 final  String cardId;

/// Create a copy of TestDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestDetailEvent$CardDeletedCopyWith<_TestDetailEvent$CardDeleted> get copyWith => __$TestDetailEvent$CardDeletedCopyWithImpl<_TestDetailEvent$CardDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestDetailEvent$CardDeleted&&(identical(other.cardId, cardId) || other.cardId == cardId));
}


@override
int get hashCode => Object.hash(runtimeType,cardId);

@override
String toString() {
  return 'TestDetailEvent.cardDeleted(cardId: $cardId)';
}


}

/// @nodoc
abstract mixin class _$TestDetailEvent$CardDeletedCopyWith<$Res> implements $TestDetailEventCopyWith<$Res> {
  factory _$TestDetailEvent$CardDeletedCopyWith(_TestDetailEvent$CardDeleted value, $Res Function(_TestDetailEvent$CardDeleted) _then) = __$TestDetailEvent$CardDeletedCopyWithImpl;
@useResult
$Res call({
 String cardId
});




}
/// @nodoc
class __$TestDetailEvent$CardDeletedCopyWithImpl<$Res>
    implements _$TestDetailEvent$CardDeletedCopyWith<$Res> {
  __$TestDetailEvent$CardDeletedCopyWithImpl(this._self, this._then);

  final _TestDetailEvent$CardDeleted _self;
  final $Res Function(_TestDetailEvent$CardDeleted) _then;

/// Create a copy of TestDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cardId = null,}) {
  return _then(_TestDetailEvent$CardDeleted(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TestDetailEvent$CardUpdated implements TestDetailEvent {
  const _TestDetailEvent$CardUpdated({required this.card});
  

 final  CardEntity card;

/// Create a copy of TestDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestDetailEvent$CardUpdatedCopyWith<_TestDetailEvent$CardUpdated> get copyWith => __$TestDetailEvent$CardUpdatedCopyWithImpl<_TestDetailEvent$CardUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestDetailEvent$CardUpdated&&(identical(other.card, card) || other.card == card));
}


@override
int get hashCode => Object.hash(runtimeType,card);

@override
String toString() {
  return 'TestDetailEvent.cardUpdated(card: $card)';
}


}

/// @nodoc
abstract mixin class _$TestDetailEvent$CardUpdatedCopyWith<$Res> implements $TestDetailEventCopyWith<$Res> {
  factory _$TestDetailEvent$CardUpdatedCopyWith(_TestDetailEvent$CardUpdated value, $Res Function(_TestDetailEvent$CardUpdated) _then) = __$TestDetailEvent$CardUpdatedCopyWithImpl;
@useResult
$Res call({
 CardEntity card
});


$CardEntityCopyWith<$Res> get card;

}
/// @nodoc
class __$TestDetailEvent$CardUpdatedCopyWithImpl<$Res>
    implements _$TestDetailEvent$CardUpdatedCopyWith<$Res> {
  __$TestDetailEvent$CardUpdatedCopyWithImpl(this._self, this._then);

  final _TestDetailEvent$CardUpdated _self;
  final $Res Function(_TestDetailEvent$CardUpdated) _then;

/// Create a copy of TestDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? card = null,}) {
  return _then(_TestDetailEvent$CardUpdated(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as CardEntity,
  ));
}

/// Create a copy of TestDetailEvent
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


class _TestDetailEvent$TestUpdated implements TestDetailEvent {
  const _TestDetailEvent$TestUpdated({required this.title, this.description});
  

 final  String title;
 final  String? description;

/// Create a copy of TestDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestDetailEvent$TestUpdatedCopyWith<_TestDetailEvent$TestUpdated> get copyWith => __$TestDetailEvent$TestUpdatedCopyWithImpl<_TestDetailEvent$TestUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestDetailEvent$TestUpdated&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,title,description);

@override
String toString() {
  return 'TestDetailEvent.testUpdated(title: $title, description: $description)';
}


}

/// @nodoc
abstract mixin class _$TestDetailEvent$TestUpdatedCopyWith<$Res> implements $TestDetailEventCopyWith<$Res> {
  factory _$TestDetailEvent$TestUpdatedCopyWith(_TestDetailEvent$TestUpdated value, $Res Function(_TestDetailEvent$TestUpdated) _then) = __$TestDetailEvent$TestUpdatedCopyWithImpl;
@useResult
$Res call({
 String title, String? description
});




}
/// @nodoc
class __$TestDetailEvent$TestUpdatedCopyWithImpl<$Res>
    implements _$TestDetailEvent$TestUpdatedCopyWith<$Res> {
  __$TestDetailEvent$TestUpdatedCopyWithImpl(this._self, this._then);

  final _TestDetailEvent$TestUpdated _self;
  final $Res Function(_TestDetailEvent$TestUpdated) _then;

/// Create a copy of TestDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = freezed,}) {
  return _then(_TestDetailEvent$TestUpdated(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _TestDetailEvent$CardsImported implements TestDetailEvent {
  const _TestDetailEvent$CardsImported({required final  List<({String front, String back})> cards}): _cards = cards;
  

 final  List<({String front, String back})> _cards;
 List<({String front, String back})> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}


/// Create a copy of TestDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TestDetailEvent$CardsImportedCopyWith<_TestDetailEvent$CardsImported> get copyWith => __$TestDetailEvent$CardsImportedCopyWithImpl<_TestDetailEvent$CardsImported>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TestDetailEvent$CardsImported&&const DeepCollectionEquality().equals(other._cards, _cards));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cards));

@override
String toString() {
  return 'TestDetailEvent.cardsImported(cards: $cards)';
}


}

/// @nodoc
abstract mixin class _$TestDetailEvent$CardsImportedCopyWith<$Res> implements $TestDetailEventCopyWith<$Res> {
  factory _$TestDetailEvent$CardsImportedCopyWith(_TestDetailEvent$CardsImported value, $Res Function(_TestDetailEvent$CardsImported) _then) = __$TestDetailEvent$CardsImportedCopyWithImpl;
@useResult
$Res call({
 List<({String front, String back})> cards
});




}
/// @nodoc
class __$TestDetailEvent$CardsImportedCopyWithImpl<$Res>
    implements _$TestDetailEvent$CardsImportedCopyWith<$Res> {
  __$TestDetailEvent$CardsImportedCopyWithImpl(this._self, this._then);

  final _TestDetailEvent$CardsImported _self;
  final $Res Function(_TestDetailEvent$CardsImported) _then;

/// Create a copy of TestDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cards = null,}) {
  return _then(_TestDetailEvent$CardsImported(
cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<({String front, String back})>,
  ));
}


}

/// @nodoc
mixin _$TestDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TestDetailState()';
}


}

/// @nodoc
class $TestDetailStateCopyWith<$Res>  {
$TestDetailStateCopyWith(TestDetailState _, $Res Function(TestDetailState) __);
}


/// Adds pattern-matching-related methods to [TestDetailState].
extension TestDetailStatePatterns on TestDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TestDetailState$Loading value)?  loading,TResult Function( TestDetailState$Loaded value)?  loaded,TResult Function( TestDetailState$Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TestDetailState$Loading() when loading != null:
return loading(_that);case TestDetailState$Loaded() when loaded != null:
return loaded(_that);case TestDetailState$Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TestDetailState$Loading value)  loading,required TResult Function( TestDetailState$Loaded value)  loaded,required TResult Function( TestDetailState$Error value)  error,}){
final _that = this;
switch (_that) {
case TestDetailState$Loading():
return loading(_that);case TestDetailState$Loaded():
return loaded(_that);case TestDetailState$Error():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TestDetailState$Loading value)?  loading,TResult? Function( TestDetailState$Loaded value)?  loaded,TResult? Function( TestDetailState$Error value)?  error,}){
final _that = this;
switch (_that) {
case TestDetailState$Loading() when loading != null:
return loading(_that);case TestDetailState$Loaded() when loaded != null:
return loaded(_that);case TestDetailState$Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( TestEntity test,  List<CardEntity> cards)?  loaded,TResult Function( Failure failure)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TestDetailState$Loading() when loading != null:
return loading();case TestDetailState$Loaded() when loaded != null:
return loaded(_that.test,_that.cards);case TestDetailState$Error() when error != null:
return error(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( TestEntity test,  List<CardEntity> cards)  loaded,required TResult Function( Failure failure)  error,}) {final _that = this;
switch (_that) {
case TestDetailState$Loading():
return loading();case TestDetailState$Loaded():
return loaded(_that.test,_that.cards);case TestDetailState$Error():
return error(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( TestEntity test,  List<CardEntity> cards)?  loaded,TResult? Function( Failure failure)?  error,}) {final _that = this;
switch (_that) {
case TestDetailState$Loading() when loading != null:
return loading();case TestDetailState$Loaded() when loaded != null:
return loaded(_that.test,_that.cards);case TestDetailState$Error() when error != null:
return error(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class TestDetailState$Loading extends TestDetailState {
  const TestDetailState$Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestDetailState$Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TestDetailState.loading()';
}


}




/// @nodoc


class TestDetailState$Loaded extends TestDetailState {
  const TestDetailState$Loaded({required this.test, required final  List<CardEntity> cards}): _cards = cards,super._();
  

 final  TestEntity test;
 final  List<CardEntity> _cards;
 List<CardEntity> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}


/// Create a copy of TestDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestDetailState$LoadedCopyWith<TestDetailState$Loaded> get copyWith => _$TestDetailState$LoadedCopyWithImpl<TestDetailState$Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestDetailState$Loaded&&(identical(other.test, test) || other.test == test)&&const DeepCollectionEquality().equals(other._cards, _cards));
}


@override
int get hashCode => Object.hash(runtimeType,test,const DeepCollectionEquality().hash(_cards));

@override
String toString() {
  return 'TestDetailState.loaded(test: $test, cards: $cards)';
}


}

/// @nodoc
abstract mixin class $TestDetailState$LoadedCopyWith<$Res> implements $TestDetailStateCopyWith<$Res> {
  factory $TestDetailState$LoadedCopyWith(TestDetailState$Loaded value, $Res Function(TestDetailState$Loaded) _then) = _$TestDetailState$LoadedCopyWithImpl;
@useResult
$Res call({
 TestEntity test, List<CardEntity> cards
});


$TestEntityCopyWith<$Res> get test;

}
/// @nodoc
class _$TestDetailState$LoadedCopyWithImpl<$Res>
    implements $TestDetailState$LoadedCopyWith<$Res> {
  _$TestDetailState$LoadedCopyWithImpl(this._self, this._then);

  final TestDetailState$Loaded _self;
  final $Res Function(TestDetailState$Loaded) _then;

/// Create a copy of TestDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? test = null,Object? cards = null,}) {
  return _then(TestDetailState$Loaded(
test: null == test ? _self.test : test // ignore: cast_nullable_to_non_nullable
as TestEntity,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<CardEntity>,
  ));
}

/// Create a copy of TestDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestEntityCopyWith<$Res> get test {
  
  return $TestEntityCopyWith<$Res>(_self.test, (value) {
    return _then(_self.copyWith(test: value));
  });
}
}

/// @nodoc


class TestDetailState$Error extends TestDetailState {
  const TestDetailState$Error({required this.failure}): super._();
  

 final  Failure failure;

/// Create a copy of TestDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TestDetailState$ErrorCopyWith<TestDetailState$Error> get copyWith => _$TestDetailState$ErrorCopyWithImpl<TestDetailState$Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TestDetailState$Error&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'TestDetailState.error(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $TestDetailState$ErrorCopyWith<$Res> implements $TestDetailStateCopyWith<$Res> {
  factory $TestDetailState$ErrorCopyWith(TestDetailState$Error value, $Res Function(TestDetailState$Error) _then) = _$TestDetailState$ErrorCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$TestDetailState$ErrorCopyWithImpl<$Res>
    implements $TestDetailState$ErrorCopyWith<$Res> {
  _$TestDetailState$ErrorCopyWithImpl(this._self, this._then);

  final TestDetailState$Error _self;
  final $Res Function(TestDetailState$Error) _then;

/// Create a copy of TestDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(TestDetailState$Error(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
