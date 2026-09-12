// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tinder_test_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TinderTestEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TinderTestEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TinderTestEvent()';
}


}

/// @nodoc
class $TinderTestEventCopyWith<$Res>  {
$TinderTestEventCopyWith(TinderTestEvent _, $Res Function(TinderTestEvent) __);
}


/// Adds pattern-matching-related methods to [TinderTestEvent].
extension TinderTestEventPatterns on TinderTestEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _TinderTestEvent$Started value)?  started,TResult Function( _TinderTestEvent$SwipedLeft value)?  swipedLeft,TResult Function( _TinderTestEvent$SwipedRight value)?  swipedRight,TResult Function( _TinderTestEvent$Completed value)?  completed,TResult Function( _TinderTestEvent$Discard value)?  discard,TResult Function( _TinderTestEvent$Restarted value)?  restarted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TinderTestEvent$Started() when started != null:
return started(_that);case _TinderTestEvent$SwipedLeft() when swipedLeft != null:
return swipedLeft(_that);case _TinderTestEvent$SwipedRight() when swipedRight != null:
return swipedRight(_that);case _TinderTestEvent$Completed() when completed != null:
return completed(_that);case _TinderTestEvent$Discard() when discard != null:
return discard(_that);case _TinderTestEvent$Restarted() when restarted != null:
return restarted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _TinderTestEvent$Started value)  started,required TResult Function( _TinderTestEvent$SwipedLeft value)  swipedLeft,required TResult Function( _TinderTestEvent$SwipedRight value)  swipedRight,required TResult Function( _TinderTestEvent$Completed value)  completed,required TResult Function( _TinderTestEvent$Discard value)  discard,required TResult Function( _TinderTestEvent$Restarted value)  restarted,}){
final _that = this;
switch (_that) {
case _TinderTestEvent$Started():
return started(_that);case _TinderTestEvent$SwipedLeft():
return swipedLeft(_that);case _TinderTestEvent$SwipedRight():
return swipedRight(_that);case _TinderTestEvent$Completed():
return completed(_that);case _TinderTestEvent$Discard():
return discard(_that);case _TinderTestEvent$Restarted():
return restarted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _TinderTestEvent$Started value)?  started,TResult? Function( _TinderTestEvent$SwipedLeft value)?  swipedLeft,TResult? Function( _TinderTestEvent$SwipedRight value)?  swipedRight,TResult? Function( _TinderTestEvent$Completed value)?  completed,TResult? Function( _TinderTestEvent$Discard value)?  discard,TResult? Function( _TinderTestEvent$Restarted value)?  restarted,}){
final _that = this;
switch (_that) {
case _TinderTestEvent$Started() when started != null:
return started(_that);case _TinderTestEvent$SwipedLeft() when swipedLeft != null:
return swipedLeft(_that);case _TinderTestEvent$SwipedRight() when swipedRight != null:
return swipedRight(_that);case _TinderTestEvent$Completed() when completed != null:
return completed(_that);case _TinderTestEvent$Discard() when discard != null:
return discard(_that);case _TinderTestEvent$Restarted() when restarted != null:
return restarted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String testId,  bool swapSides,  int answerIndex,  bool mixup,  int mixupMin,  int mixupMax,  bool resume)?  started,TResult Function( String cardId)?  swipedLeft,TResult Function( String cardId)?  swipedRight,TResult Function()?  completed,TResult Function()?  discard,TResult Function()?  restarted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TinderTestEvent$Started() when started != null:
return started(_that.testId,_that.swapSides,_that.answerIndex,_that.mixup,_that.mixupMin,_that.mixupMax,_that.resume);case _TinderTestEvent$SwipedLeft() when swipedLeft != null:
return swipedLeft(_that.cardId);case _TinderTestEvent$SwipedRight() when swipedRight != null:
return swipedRight(_that.cardId);case _TinderTestEvent$Completed() when completed != null:
return completed();case _TinderTestEvent$Discard() when discard != null:
return discard();case _TinderTestEvent$Restarted() when restarted != null:
return restarted();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String testId,  bool swapSides,  int answerIndex,  bool mixup,  int mixupMin,  int mixupMax,  bool resume)  started,required TResult Function( String cardId)  swipedLeft,required TResult Function( String cardId)  swipedRight,required TResult Function()  completed,required TResult Function()  discard,required TResult Function()  restarted,}) {final _that = this;
switch (_that) {
case _TinderTestEvent$Started():
return started(_that.testId,_that.swapSides,_that.answerIndex,_that.mixup,_that.mixupMin,_that.mixupMax,_that.resume);case _TinderTestEvent$SwipedLeft():
return swipedLeft(_that.cardId);case _TinderTestEvent$SwipedRight():
return swipedRight(_that.cardId);case _TinderTestEvent$Completed():
return completed();case _TinderTestEvent$Discard():
return discard();case _TinderTestEvent$Restarted():
return restarted();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String testId,  bool swapSides,  int answerIndex,  bool mixup,  int mixupMin,  int mixupMax,  bool resume)?  started,TResult? Function( String cardId)?  swipedLeft,TResult? Function( String cardId)?  swipedRight,TResult? Function()?  completed,TResult? Function()?  discard,TResult? Function()?  restarted,}) {final _that = this;
switch (_that) {
case _TinderTestEvent$Started() when started != null:
return started(_that.testId,_that.swapSides,_that.answerIndex,_that.mixup,_that.mixupMin,_that.mixupMax,_that.resume);case _TinderTestEvent$SwipedLeft() when swipedLeft != null:
return swipedLeft(_that.cardId);case _TinderTestEvent$SwipedRight() when swipedRight != null:
return swipedRight(_that.cardId);case _TinderTestEvent$Completed() when completed != null:
return completed();case _TinderTestEvent$Discard() when discard != null:
return discard();case _TinderTestEvent$Restarted() when restarted != null:
return restarted();case _:
  return null;

}
}

}

/// @nodoc


class _TinderTestEvent$Started implements TinderTestEvent {
  const _TinderTestEvent$Started({required this.testId, this.swapSides = false, this.answerIndex = 0, this.mixup = false, this.mixupMin = 1, this.mixupMax = 5, this.resume = false});
  

 final  String testId;
@JsonKey() final  bool swapSides;
@JsonKey() final  int answerIndex;
@JsonKey() final  bool mixup;
@JsonKey() final  int mixupMin;
@JsonKey() final  int mixupMax;
@JsonKey() final  bool resume;

/// Create a copy of TinderTestEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TinderTestEvent$StartedCopyWith<_TinderTestEvent$Started> get copyWith => __$TinderTestEvent$StartedCopyWithImpl<_TinderTestEvent$Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TinderTestEvent$Started&&(identical(other.testId, testId) || other.testId == testId)&&(identical(other.swapSides, swapSides) || other.swapSides == swapSides)&&(identical(other.answerIndex, answerIndex) || other.answerIndex == answerIndex)&&(identical(other.mixup, mixup) || other.mixup == mixup)&&(identical(other.mixupMin, mixupMin) || other.mixupMin == mixupMin)&&(identical(other.mixupMax, mixupMax) || other.mixupMax == mixupMax)&&(identical(other.resume, resume) || other.resume == resume));
}


@override
int get hashCode => Object.hash(runtimeType,testId,swapSides,answerIndex,mixup,mixupMin,mixupMax,resume);

@override
String toString() {
  return 'TinderTestEvent.started(testId: $testId, swapSides: $swapSides, answerIndex: $answerIndex, mixup: $mixup, mixupMin: $mixupMin, mixupMax: $mixupMax, resume: $resume)';
}


}

/// @nodoc
abstract mixin class _$TinderTestEvent$StartedCopyWith<$Res> implements $TinderTestEventCopyWith<$Res> {
  factory _$TinderTestEvent$StartedCopyWith(_TinderTestEvent$Started value, $Res Function(_TinderTestEvent$Started) _then) = __$TinderTestEvent$StartedCopyWithImpl;
@useResult
$Res call({
 String testId, bool swapSides, int answerIndex, bool mixup, int mixupMin, int mixupMax, bool resume
});




}
/// @nodoc
class __$TinderTestEvent$StartedCopyWithImpl<$Res>
    implements _$TinderTestEvent$StartedCopyWith<$Res> {
  __$TinderTestEvent$StartedCopyWithImpl(this._self, this._then);

  final _TinderTestEvent$Started _self;
  final $Res Function(_TinderTestEvent$Started) _then;

/// Create a copy of TinderTestEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? testId = null,Object? swapSides = null,Object? answerIndex = null,Object? mixup = null,Object? mixupMin = null,Object? mixupMax = null,Object? resume = null,}) {
  return _then(_TinderTestEvent$Started(
testId: null == testId ? _self.testId : testId // ignore: cast_nullable_to_non_nullable
as String,swapSides: null == swapSides ? _self.swapSides : swapSides // ignore: cast_nullable_to_non_nullable
as bool,answerIndex: null == answerIndex ? _self.answerIndex : answerIndex // ignore: cast_nullable_to_non_nullable
as int,mixup: null == mixup ? _self.mixup : mixup // ignore: cast_nullable_to_non_nullable
as bool,mixupMin: null == mixupMin ? _self.mixupMin : mixupMin // ignore: cast_nullable_to_non_nullable
as int,mixupMax: null == mixupMax ? _self.mixupMax : mixupMax // ignore: cast_nullable_to_non_nullable
as int,resume: null == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _TinderTestEvent$SwipedLeft implements TinderTestEvent {
  const _TinderTestEvent$SwipedLeft({required this.cardId});
  

 final  String cardId;

/// Create a copy of TinderTestEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TinderTestEvent$SwipedLeftCopyWith<_TinderTestEvent$SwipedLeft> get copyWith => __$TinderTestEvent$SwipedLeftCopyWithImpl<_TinderTestEvent$SwipedLeft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TinderTestEvent$SwipedLeft&&(identical(other.cardId, cardId) || other.cardId == cardId));
}


@override
int get hashCode => Object.hash(runtimeType,cardId);

@override
String toString() {
  return 'TinderTestEvent.swipedLeft(cardId: $cardId)';
}


}

/// @nodoc
abstract mixin class _$TinderTestEvent$SwipedLeftCopyWith<$Res> implements $TinderTestEventCopyWith<$Res> {
  factory _$TinderTestEvent$SwipedLeftCopyWith(_TinderTestEvent$SwipedLeft value, $Res Function(_TinderTestEvent$SwipedLeft) _then) = __$TinderTestEvent$SwipedLeftCopyWithImpl;
@useResult
$Res call({
 String cardId
});




}
/// @nodoc
class __$TinderTestEvent$SwipedLeftCopyWithImpl<$Res>
    implements _$TinderTestEvent$SwipedLeftCopyWith<$Res> {
  __$TinderTestEvent$SwipedLeftCopyWithImpl(this._self, this._then);

  final _TinderTestEvent$SwipedLeft _self;
  final $Res Function(_TinderTestEvent$SwipedLeft) _then;

/// Create a copy of TinderTestEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cardId = null,}) {
  return _then(_TinderTestEvent$SwipedLeft(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TinderTestEvent$SwipedRight implements TinderTestEvent {
  const _TinderTestEvent$SwipedRight({required this.cardId});
  

 final  String cardId;

/// Create a copy of TinderTestEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TinderTestEvent$SwipedRightCopyWith<_TinderTestEvent$SwipedRight> get copyWith => __$TinderTestEvent$SwipedRightCopyWithImpl<_TinderTestEvent$SwipedRight>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TinderTestEvent$SwipedRight&&(identical(other.cardId, cardId) || other.cardId == cardId));
}


@override
int get hashCode => Object.hash(runtimeType,cardId);

@override
String toString() {
  return 'TinderTestEvent.swipedRight(cardId: $cardId)';
}


}

/// @nodoc
abstract mixin class _$TinderTestEvent$SwipedRightCopyWith<$Res> implements $TinderTestEventCopyWith<$Res> {
  factory _$TinderTestEvent$SwipedRightCopyWith(_TinderTestEvent$SwipedRight value, $Res Function(_TinderTestEvent$SwipedRight) _then) = __$TinderTestEvent$SwipedRightCopyWithImpl;
@useResult
$Res call({
 String cardId
});




}
/// @nodoc
class __$TinderTestEvent$SwipedRightCopyWithImpl<$Res>
    implements _$TinderTestEvent$SwipedRightCopyWith<$Res> {
  __$TinderTestEvent$SwipedRightCopyWithImpl(this._self, this._then);

  final _TinderTestEvent$SwipedRight _self;
  final $Res Function(_TinderTestEvent$SwipedRight) _then;

/// Create a copy of TinderTestEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cardId = null,}) {
  return _then(_TinderTestEvent$SwipedRight(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TinderTestEvent$Completed implements TinderTestEvent {
  const _TinderTestEvent$Completed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TinderTestEvent$Completed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TinderTestEvent.completed()';
}


}




/// @nodoc


class _TinderTestEvent$Discard implements TinderTestEvent {
  const _TinderTestEvent$Discard();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TinderTestEvent$Discard);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TinderTestEvent.discard()';
}


}




/// @nodoc


class _TinderTestEvent$Restarted implements TinderTestEvent {
  const _TinderTestEvent$Restarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TinderTestEvent$Restarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TinderTestEvent.restarted()';
}


}




/// @nodoc
mixin _$TinderTestState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TinderTestState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TinderTestState()';
}


}

/// @nodoc
class $TinderTestStateCopyWith<$Res>  {
$TinderTestStateCopyWith(TinderTestState _, $Res Function(TinderTestState) __);
}


/// Adds pattern-matching-related methods to [TinderTestState].
extension TinderTestStatePatterns on TinderTestState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TinderTestState$Initial value)?  initial,TResult Function( TinderTestState$Loading value)?  loading,TResult Function( TinderTestState$Empty value)?  empty,TResult Function( TinderTestState$InProgress value)?  inProgress,TResult Function( TinderTestState$Completed value)?  completed,TResult Function( TinderTestState$Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TinderTestState$Initial() when initial != null:
return initial(_that);case TinderTestState$Loading() when loading != null:
return loading(_that);case TinderTestState$Empty() when empty != null:
return empty(_that);case TinderTestState$InProgress() when inProgress != null:
return inProgress(_that);case TinderTestState$Completed() when completed != null:
return completed(_that);case TinderTestState$Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TinderTestState$Initial value)  initial,required TResult Function( TinderTestState$Loading value)  loading,required TResult Function( TinderTestState$Empty value)  empty,required TResult Function( TinderTestState$InProgress value)  inProgress,required TResult Function( TinderTestState$Completed value)  completed,required TResult Function( TinderTestState$Error value)  error,}){
final _that = this;
switch (_that) {
case TinderTestState$Initial():
return initial(_that);case TinderTestState$Loading():
return loading(_that);case TinderTestState$Empty():
return empty(_that);case TinderTestState$InProgress():
return inProgress(_that);case TinderTestState$Completed():
return completed(_that);case TinderTestState$Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TinderTestState$Initial value)?  initial,TResult? Function( TinderTestState$Loading value)?  loading,TResult? Function( TinderTestState$Empty value)?  empty,TResult? Function( TinderTestState$InProgress value)?  inProgress,TResult? Function( TinderTestState$Completed value)?  completed,TResult? Function( TinderTestState$Error value)?  error,}){
final _that = this;
switch (_that) {
case TinderTestState$Initial() when initial != null:
return initial(_that);case TinderTestState$Loading() when loading != null:
return loading(_that);case TinderTestState$Empty() when empty != null:
return empty(_that);case TinderTestState$InProgress() when inProgress != null:
return inProgress(_that);case TinderTestState$Completed() when completed != null:
return completed(_that);case TinderTestState$Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  empty,TResult Function( TestSession session,  CardEntity currentCard,  bool isUndo)?  inProgress,TResult Function( TestSession session)?  completed,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TinderTestState$Initial() when initial != null:
return initial();case TinderTestState$Loading() when loading != null:
return loading();case TinderTestState$Empty() when empty != null:
return empty();case TinderTestState$InProgress() when inProgress != null:
return inProgress(_that.session,_that.currentCard,_that.isUndo);case TinderTestState$Completed() when completed != null:
return completed(_that.session);case TinderTestState$Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  empty,required TResult Function( TestSession session,  CardEntity currentCard,  bool isUndo)  inProgress,required TResult Function( TestSession session)  completed,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case TinderTestState$Initial():
return initial();case TinderTestState$Loading():
return loading();case TinderTestState$Empty():
return empty();case TinderTestState$InProgress():
return inProgress(_that.session,_that.currentCard,_that.isUndo);case TinderTestState$Completed():
return completed(_that.session);case TinderTestState$Error():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  empty,TResult? Function( TestSession session,  CardEntity currentCard,  bool isUndo)?  inProgress,TResult? Function( TestSession session)?  completed,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case TinderTestState$Initial() when initial != null:
return initial();case TinderTestState$Loading() when loading != null:
return loading();case TinderTestState$Empty() when empty != null:
return empty();case TinderTestState$InProgress() when inProgress != null:
return inProgress(_that.session,_that.currentCard,_that.isUndo);case TinderTestState$Completed() when completed != null:
return completed(_that.session);case TinderTestState$Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TinderTestState$Initial extends TinderTestState {
  const TinderTestState$Initial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TinderTestState$Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TinderTestState.initial()';
}


}




/// @nodoc


class TinderTestState$Loading extends TinderTestState {
  const TinderTestState$Loading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TinderTestState$Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TinderTestState.loading()';
}


}




/// @nodoc


class TinderTestState$Empty extends TinderTestState {
  const TinderTestState$Empty(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TinderTestState$Empty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TinderTestState.empty()';
}


}




/// @nodoc


class TinderTestState$InProgress extends TinderTestState {
  const TinderTestState$InProgress({required this.session, required this.currentCard, this.isUndo = false}): super._();
  

 final  TestSession session;
 final  CardEntity currentCard;
@JsonKey() final  bool isUndo;

/// Create a copy of TinderTestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TinderTestState$InProgressCopyWith<TinderTestState$InProgress> get copyWith => _$TinderTestState$InProgressCopyWithImpl<TinderTestState$InProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TinderTestState$InProgress&&(identical(other.session, session) || other.session == session)&&(identical(other.currentCard, currentCard) || other.currentCard == currentCard)&&(identical(other.isUndo, isUndo) || other.isUndo == isUndo));
}


@override
int get hashCode => Object.hash(runtimeType,session,currentCard,isUndo);

@override
String toString() {
  return 'TinderTestState.inProgress(session: $session, currentCard: $currentCard, isUndo: $isUndo)';
}


}

/// @nodoc
abstract mixin class $TinderTestState$InProgressCopyWith<$Res> implements $TinderTestStateCopyWith<$Res> {
  factory $TinderTestState$InProgressCopyWith(TinderTestState$InProgress value, $Res Function(TinderTestState$InProgress) _then) = _$TinderTestState$InProgressCopyWithImpl;
@useResult
$Res call({
 TestSession session, CardEntity currentCard, bool isUndo
});


$TestSessionCopyWith<$Res> get session;$CardEntityCopyWith<$Res> get currentCard;

}
/// @nodoc
class _$TinderTestState$InProgressCopyWithImpl<$Res>
    implements $TinderTestState$InProgressCopyWith<$Res> {
  _$TinderTestState$InProgressCopyWithImpl(this._self, this._then);

  final TinderTestState$InProgress _self;
  final $Res Function(TinderTestState$InProgress) _then;

/// Create a copy of TinderTestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? session = null,Object? currentCard = null,Object? isUndo = null,}) {
  return _then(TinderTestState$InProgress(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as TestSession,currentCard: null == currentCard ? _self.currentCard : currentCard // ignore: cast_nullable_to_non_nullable
as CardEntity,isUndo: null == isUndo ? _self.isUndo : isUndo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of TinderTestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestSessionCopyWith<$Res> get session {
  
  return $TestSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of TinderTestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardEntityCopyWith<$Res> get currentCard {
  
  return $CardEntityCopyWith<$Res>(_self.currentCard, (value) {
    return _then(_self.copyWith(currentCard: value));
  });
}
}

/// @nodoc


class TinderTestState$Completed extends TinderTestState {
  const TinderTestState$Completed({required this.session}): super._();
  

 final  TestSession session;

/// Create a copy of TinderTestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TinderTestState$CompletedCopyWith<TinderTestState$Completed> get copyWith => _$TinderTestState$CompletedCopyWithImpl<TinderTestState$Completed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TinderTestState$Completed&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode => Object.hash(runtimeType,session);

@override
String toString() {
  return 'TinderTestState.completed(session: $session)';
}


}

/// @nodoc
abstract mixin class $TinderTestState$CompletedCopyWith<$Res> implements $TinderTestStateCopyWith<$Res> {
  factory $TinderTestState$CompletedCopyWith(TinderTestState$Completed value, $Res Function(TinderTestState$Completed) _then) = _$TinderTestState$CompletedCopyWithImpl;
@useResult
$Res call({
 TestSession session
});


$TestSessionCopyWith<$Res> get session;

}
/// @nodoc
class _$TinderTestState$CompletedCopyWithImpl<$Res>
    implements $TinderTestState$CompletedCopyWith<$Res> {
  _$TinderTestState$CompletedCopyWithImpl(this._self, this._then);

  final TinderTestState$Completed _self;
  final $Res Function(TinderTestState$Completed) _then;

/// Create a copy of TinderTestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? session = null,}) {
  return _then(TinderTestState$Completed(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as TestSession,
  ));
}

/// Create a copy of TinderTestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestSessionCopyWith<$Res> get session {
  
  return $TestSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

/// @nodoc


class TinderTestState$Error extends TinderTestState {
  const TinderTestState$Error({required this.message}): super._();
  

 final  String message;

/// Create a copy of TinderTestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TinderTestState$ErrorCopyWith<TinderTestState$Error> get copyWith => _$TinderTestState$ErrorCopyWithImpl<TinderTestState$Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TinderTestState$Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TinderTestState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TinderTestState$ErrorCopyWith<$Res> implements $TinderTestStateCopyWith<$Res> {
  factory $TinderTestState$ErrorCopyWith(TinderTestState$Error value, $Res Function(TinderTestState$Error) _then) = _$TinderTestState$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TinderTestState$ErrorCopyWithImpl<$Res>
    implements $TinderTestState$ErrorCopyWith<$Res> {
  _$TinderTestState$ErrorCopyWithImpl(this._self, this._then);

  final TinderTestState$Error _self;
  final $Res Function(TinderTestState$Error) _then;

/// Create a copy of TinderTestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TinderTestState$Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
