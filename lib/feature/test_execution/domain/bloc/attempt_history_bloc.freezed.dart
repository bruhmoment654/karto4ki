// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attempt_history_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttemptHistoryEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttemptHistoryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttemptHistoryEvent()';
}


}

/// @nodoc
class $AttemptHistoryEventCopyWith<$Res>  {
$AttemptHistoryEventCopyWith(AttemptHistoryEvent _, $Res Function(AttemptHistoryEvent) __);
}


/// Adds pattern-matching-related methods to [AttemptHistoryEvent].
extension AttemptHistoryEventPatterns on AttemptHistoryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _AttemptHistoryEvent$Started value)?  started,TResult Function( _AttemptHistoryEvent$ClearRequested value)?  clearRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttemptHistoryEvent$Started() when started != null:
return started(_that);case _AttemptHistoryEvent$ClearRequested() when clearRequested != null:
return clearRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _AttemptHistoryEvent$Started value)  started,required TResult Function( _AttemptHistoryEvent$ClearRequested value)  clearRequested,}){
final _that = this;
switch (_that) {
case _AttemptHistoryEvent$Started():
return started(_that);case _AttemptHistoryEvent$ClearRequested():
return clearRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _AttemptHistoryEvent$Started value)?  started,TResult? Function( _AttemptHistoryEvent$ClearRequested value)?  clearRequested,}){
final _that = this;
switch (_that) {
case _AttemptHistoryEvent$Started() when started != null:
return started(_that);case _AttemptHistoryEvent$ClearRequested() when clearRequested != null:
return clearRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  clearRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttemptHistoryEvent$Started() when started != null:
return started();case _AttemptHistoryEvent$ClearRequested() when clearRequested != null:
return clearRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  clearRequested,}) {final _that = this;
switch (_that) {
case _AttemptHistoryEvent$Started():
return started();case _AttemptHistoryEvent$ClearRequested():
return clearRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  clearRequested,}) {final _that = this;
switch (_that) {
case _AttemptHistoryEvent$Started() when started != null:
return started();case _AttemptHistoryEvent$ClearRequested() when clearRequested != null:
return clearRequested();case _:
  return null;

}
}

}

/// @nodoc


class _AttemptHistoryEvent$Started implements AttemptHistoryEvent {
  const _AttemptHistoryEvent$Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttemptHistoryEvent$Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttemptHistoryEvent.started()';
}


}




/// @nodoc


class _AttemptHistoryEvent$ClearRequested implements AttemptHistoryEvent {
  const _AttemptHistoryEvent$ClearRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttemptHistoryEvent$ClearRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttemptHistoryEvent.clearRequested()';
}


}




/// @nodoc
mixin _$AttemptHistoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttemptHistoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttemptHistoryState()';
}


}

/// @nodoc
class $AttemptHistoryStateCopyWith<$Res>  {
$AttemptHistoryStateCopyWith(AttemptHistoryState _, $Res Function(AttemptHistoryState) __);
}


/// Adds pattern-matching-related methods to [AttemptHistoryState].
extension AttemptHistoryStatePatterns on AttemptHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AttemptHistoryState$Loading value)?  loading,TResult Function( AttemptHistoryState$Loaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AttemptHistoryState$Loading() when loading != null:
return loading(_that);case AttemptHistoryState$Loaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AttemptHistoryState$Loading value)  loading,required TResult Function( AttemptHistoryState$Loaded value)  loaded,}){
final _that = this;
switch (_that) {
case AttemptHistoryState$Loading():
return loading(_that);case AttemptHistoryState$Loaded():
return loaded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AttemptHistoryState$Loading value)?  loading,TResult? Function( AttemptHistoryState$Loaded value)?  loaded,}){
final _that = this;
switch (_that) {
case AttemptHistoryState$Loading() when loading != null:
return loading(_that);case AttemptHistoryState$Loaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( AttemptHistoryUsage? usage,  bool isClearing,  SideEffectValue<AttemptHistoryClearResult>? clearResult)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AttemptHistoryState$Loading() when loading != null:
return loading();case AttemptHistoryState$Loaded() when loaded != null:
return loaded(_that.usage,_that.isClearing,_that.clearResult);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( AttemptHistoryUsage? usage,  bool isClearing,  SideEffectValue<AttemptHistoryClearResult>? clearResult)  loaded,}) {final _that = this;
switch (_that) {
case AttemptHistoryState$Loading():
return loading();case AttemptHistoryState$Loaded():
return loaded(_that.usage,_that.isClearing,_that.clearResult);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( AttemptHistoryUsage? usage,  bool isClearing,  SideEffectValue<AttemptHistoryClearResult>? clearResult)?  loaded,}) {final _that = this;
switch (_that) {
case AttemptHistoryState$Loading() when loading != null:
return loading();case AttemptHistoryState$Loaded() when loaded != null:
return loaded(_that.usage,_that.isClearing,_that.clearResult);case _:
  return null;

}
}

}

/// @nodoc


class AttemptHistoryState$Loading implements AttemptHistoryState {
  const AttemptHistoryState$Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttemptHistoryState$Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttemptHistoryState.loading()';
}


}




/// @nodoc


class AttemptHistoryState$Loaded implements AttemptHistoryState {
  const AttemptHistoryState$Loaded({this.usage, this.isClearing = false, this.clearResult});
  

/// `null` — размер посчитать не удалось; очистка всё равно доступна.
 final  AttemptHistoryUsage? usage;
/// Идёт очистка: кнопка показывает прогресс и не нажимается.
@JsonKey() final  bool isClearing;
/// Одноразовый результат очистки — показывается снеком.
 final  SideEffectValue<AttemptHistoryClearResult>? clearResult;

/// Create a copy of AttemptHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttemptHistoryState$LoadedCopyWith<AttemptHistoryState$Loaded> get copyWith => _$AttemptHistoryState$LoadedCopyWithImpl<AttemptHistoryState$Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttemptHistoryState$Loaded&&(identical(other.usage, usage) || other.usage == usage)&&(identical(other.isClearing, isClearing) || other.isClearing == isClearing)&&(identical(other.clearResult, clearResult) || other.clearResult == clearResult));
}


@override
int get hashCode => Object.hash(runtimeType,usage,isClearing,clearResult);

@override
String toString() {
  return 'AttemptHistoryState.loaded(usage: $usage, isClearing: $isClearing, clearResult: $clearResult)';
}


}

/// @nodoc
abstract mixin class $AttemptHistoryState$LoadedCopyWith<$Res> implements $AttemptHistoryStateCopyWith<$Res> {
  factory $AttemptHistoryState$LoadedCopyWith(AttemptHistoryState$Loaded value, $Res Function(AttemptHistoryState$Loaded) _then) = _$AttemptHistoryState$LoadedCopyWithImpl;
@useResult
$Res call({
 AttemptHistoryUsage? usage, bool isClearing, SideEffectValue<AttemptHistoryClearResult>? clearResult
});


$AttemptHistoryUsageCopyWith<$Res>? get usage;

}
/// @nodoc
class _$AttemptHistoryState$LoadedCopyWithImpl<$Res>
    implements $AttemptHistoryState$LoadedCopyWith<$Res> {
  _$AttemptHistoryState$LoadedCopyWithImpl(this._self, this._then);

  final AttemptHistoryState$Loaded _self;
  final $Res Function(AttemptHistoryState$Loaded) _then;

/// Create a copy of AttemptHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? usage = freezed,Object? isClearing = null,Object? clearResult = freezed,}) {
  return _then(AttemptHistoryState$Loaded(
usage: freezed == usage ? _self.usage : usage // ignore: cast_nullable_to_non_nullable
as AttemptHistoryUsage?,isClearing: null == isClearing ? _self.isClearing : isClearing // ignore: cast_nullable_to_non_nullable
as bool,clearResult: freezed == clearResult ? _self.clearResult : clearResult // ignore: cast_nullable_to_non_nullable
as SideEffectValue<AttemptHistoryClearResult>?,
  ));
}

/// Create a copy of AttemptHistoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttemptHistoryUsageCopyWith<$Res>? get usage {
    if (_self.usage == null) {
    return null;
  }

  return $AttemptHistoryUsageCopyWith<$Res>(_self.usage!, (value) {
    return _then(_self.copyWith(usage: value));
  });
}
}

// dart format on
