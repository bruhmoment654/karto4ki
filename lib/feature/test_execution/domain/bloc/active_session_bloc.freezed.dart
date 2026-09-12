// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_session_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActiveSessionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveSessionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActiveSessionEvent()';
}


}

/// @nodoc
class $ActiveSessionEventCopyWith<$Res>  {
$ActiveSessionEventCopyWith(ActiveSessionEvent _, $Res Function(ActiveSessionEvent) __);
}


/// Adds pattern-matching-related methods to [ActiveSessionEvent].
extension ActiveSessionEventPatterns on ActiveSessionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _ActiveSessionEvent$Started value)?  started,TResult Function( _ActiveSessionEvent$Updated value)?  updated,TResult Function( _ActiveSessionEvent$Cleared value)?  cleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveSessionEvent$Started() when started != null:
return started(_that);case _ActiveSessionEvent$Updated() when updated != null:
return updated(_that);case _ActiveSessionEvent$Cleared() when cleared != null:
return cleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _ActiveSessionEvent$Started value)  started,required TResult Function( _ActiveSessionEvent$Updated value)  updated,required TResult Function( _ActiveSessionEvent$Cleared value)  cleared,}){
final _that = this;
switch (_that) {
case _ActiveSessionEvent$Started():
return started(_that);case _ActiveSessionEvent$Updated():
return updated(_that);case _ActiveSessionEvent$Cleared():
return cleared(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _ActiveSessionEvent$Started value)?  started,TResult? Function( _ActiveSessionEvent$Updated value)?  updated,TResult? Function( _ActiveSessionEvent$Cleared value)?  cleared,}){
final _that = this;
switch (_that) {
case _ActiveSessionEvent$Started() when started != null:
return started(_that);case _ActiveSessionEvent$Updated() when updated != null:
return updated(_that);case _ActiveSessionEvent$Cleared() when cleared != null:
return cleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( ActiveTestSession? session)?  updated,TResult Function()?  cleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveSessionEvent$Started() when started != null:
return started();case _ActiveSessionEvent$Updated() when updated != null:
return updated(_that.session);case _ActiveSessionEvent$Cleared() when cleared != null:
return cleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( ActiveTestSession? session)  updated,required TResult Function()  cleared,}) {final _that = this;
switch (_that) {
case _ActiveSessionEvent$Started():
return started();case _ActiveSessionEvent$Updated():
return updated(_that.session);case _ActiveSessionEvent$Cleared():
return cleared();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( ActiveTestSession? session)?  updated,TResult? Function()?  cleared,}) {final _that = this;
switch (_that) {
case _ActiveSessionEvent$Started() when started != null:
return started();case _ActiveSessionEvent$Updated() when updated != null:
return updated(_that.session);case _ActiveSessionEvent$Cleared() when cleared != null:
return cleared();case _:
  return null;

}
}

}

/// @nodoc


class _ActiveSessionEvent$Started implements ActiveSessionEvent {
  const _ActiveSessionEvent$Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveSessionEvent$Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActiveSessionEvent.started()';
}


}




/// @nodoc


class _ActiveSessionEvent$Updated implements ActiveSessionEvent {
  const _ActiveSessionEvent$Updated({this.session});
  

 final  ActiveTestSession? session;

/// Create a copy of ActiveSessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveSessionEvent$UpdatedCopyWith<_ActiveSessionEvent$Updated> get copyWith => __$ActiveSessionEvent$UpdatedCopyWithImpl<_ActiveSessionEvent$Updated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveSessionEvent$Updated&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode => Object.hash(runtimeType,session);

@override
String toString() {
  return 'ActiveSessionEvent.updated(session: $session)';
}


}

/// @nodoc
abstract mixin class _$ActiveSessionEvent$UpdatedCopyWith<$Res> implements $ActiveSessionEventCopyWith<$Res> {
  factory _$ActiveSessionEvent$UpdatedCopyWith(_ActiveSessionEvent$Updated value, $Res Function(_ActiveSessionEvent$Updated) _then) = __$ActiveSessionEvent$UpdatedCopyWithImpl;
@useResult
$Res call({
 ActiveTestSession? session
});


$ActiveTestSessionCopyWith<$Res>? get session;

}
/// @nodoc
class __$ActiveSessionEvent$UpdatedCopyWithImpl<$Res>
    implements _$ActiveSessionEvent$UpdatedCopyWith<$Res> {
  __$ActiveSessionEvent$UpdatedCopyWithImpl(this._self, this._then);

  final _ActiveSessionEvent$Updated _self;
  final $Res Function(_ActiveSessionEvent$Updated) _then;

/// Create a copy of ActiveSessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? session = freezed,}) {
  return _then(_ActiveSessionEvent$Updated(
session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as ActiveTestSession?,
  ));
}

/// Create a copy of ActiveSessionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveTestSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $ActiveTestSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

/// @nodoc


class _ActiveSessionEvent$Cleared implements ActiveSessionEvent {
  const _ActiveSessionEvent$Cleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveSessionEvent$Cleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActiveSessionEvent.cleared()';
}


}




/// @nodoc
mixin _$ActiveSessionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveSessionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActiveSessionState()';
}


}

/// @nodoc
class $ActiveSessionStateCopyWith<$Res>  {
$ActiveSessionStateCopyWith(ActiveSessionState _, $Res Function(ActiveSessionState) __);
}


/// Adds pattern-matching-related methods to [ActiveSessionState].
extension ActiveSessionStatePatterns on ActiveSessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ActiveSessionState$None value)?  none,TResult Function( ActiveSessionState$Available value)?  available,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ActiveSessionState$None() when none != null:
return none(_that);case ActiveSessionState$Available() when available != null:
return available(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ActiveSessionState$None value)  none,required TResult Function( ActiveSessionState$Available value)  available,}){
final _that = this;
switch (_that) {
case ActiveSessionState$None():
return none(_that);case ActiveSessionState$Available():
return available(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ActiveSessionState$None value)?  none,TResult? Function( ActiveSessionState$Available value)?  available,}){
final _that = this;
switch (_that) {
case ActiveSessionState$None() when none != null:
return none(_that);case ActiveSessionState$Available() when available != null:
return available(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  none,TResult Function( ActiveTestSession session)?  available,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ActiveSessionState$None() when none != null:
return none();case ActiveSessionState$Available() when available != null:
return available(_that.session);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  none,required TResult Function( ActiveTestSession session)  available,}) {final _that = this;
switch (_that) {
case ActiveSessionState$None():
return none();case ActiveSessionState$Available():
return available(_that.session);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  none,TResult? Function( ActiveTestSession session)?  available,}) {final _that = this;
switch (_that) {
case ActiveSessionState$None() when none != null:
return none();case ActiveSessionState$Available() when available != null:
return available(_that.session);case _:
  return null;

}
}

}

/// @nodoc


class ActiveSessionState$None implements ActiveSessionState {
  const ActiveSessionState$None();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveSessionState$None);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ActiveSessionState.none()';
}


}




/// @nodoc


class ActiveSessionState$Available implements ActiveSessionState {
  const ActiveSessionState$Available({required this.session});
  

 final  ActiveTestSession session;

/// Create a copy of ActiveSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveSessionState$AvailableCopyWith<ActiveSessionState$Available> get copyWith => _$ActiveSessionState$AvailableCopyWithImpl<ActiveSessionState$Available>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveSessionState$Available&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode => Object.hash(runtimeType,session);

@override
String toString() {
  return 'ActiveSessionState.available(session: $session)';
}


}

/// @nodoc
abstract mixin class $ActiveSessionState$AvailableCopyWith<$Res> implements $ActiveSessionStateCopyWith<$Res> {
  factory $ActiveSessionState$AvailableCopyWith(ActiveSessionState$Available value, $Res Function(ActiveSessionState$Available) _then) = _$ActiveSessionState$AvailableCopyWithImpl;
@useResult
$Res call({
 ActiveTestSession session
});


$ActiveTestSessionCopyWith<$Res> get session;

}
/// @nodoc
class _$ActiveSessionState$AvailableCopyWithImpl<$Res>
    implements $ActiveSessionState$AvailableCopyWith<$Res> {
  _$ActiveSessionState$AvailableCopyWithImpl(this._self, this._then);

  final ActiveSessionState$Available _self;
  final $Res Function(ActiveSessionState$Available) _then;

/// Create a copy of ActiveSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? session = null,}) {
  return _then(ActiveSessionState$Available(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as ActiveTestSession,
  ));
}

/// Create a copy of ActiveSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveTestSessionCopyWith<$Res> get session {
  
  return $ActiveTestSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
