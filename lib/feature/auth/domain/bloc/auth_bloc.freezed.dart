// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _AuthEvent$Started value)?  started,TResult Function( _AuthEvent$SignInRequested value)?  signInRequested,TResult Function( _AuthEvent$SignOutRequested value)?  signOutRequested,TResult Function( _AuthEvent$StatusChanged value)?  statusChanged,TResult Function( _AuthEvent$UserRefreshed value)?  userRefreshed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthEvent$Started() when started != null:
return started(_that);case _AuthEvent$SignInRequested() when signInRequested != null:
return signInRequested(_that);case _AuthEvent$SignOutRequested() when signOutRequested != null:
return signOutRequested(_that);case _AuthEvent$StatusChanged() when statusChanged != null:
return statusChanged(_that);case _AuthEvent$UserRefreshed() when userRefreshed != null:
return userRefreshed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _AuthEvent$Started value)  started,required TResult Function( _AuthEvent$SignInRequested value)  signInRequested,required TResult Function( _AuthEvent$SignOutRequested value)  signOutRequested,required TResult Function( _AuthEvent$StatusChanged value)  statusChanged,required TResult Function( _AuthEvent$UserRefreshed value)  userRefreshed,}){
final _that = this;
switch (_that) {
case _AuthEvent$Started():
return started(_that);case _AuthEvent$SignInRequested():
return signInRequested(_that);case _AuthEvent$SignOutRequested():
return signOutRequested(_that);case _AuthEvent$StatusChanged():
return statusChanged(_that);case _AuthEvent$UserRefreshed():
return userRefreshed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _AuthEvent$Started value)?  started,TResult? Function( _AuthEvent$SignInRequested value)?  signInRequested,TResult? Function( _AuthEvent$SignOutRequested value)?  signOutRequested,TResult? Function( _AuthEvent$StatusChanged value)?  statusChanged,TResult? Function( _AuthEvent$UserRefreshed value)?  userRefreshed,}){
final _that = this;
switch (_that) {
case _AuthEvent$Started() when started != null:
return started(_that);case _AuthEvent$SignInRequested() when signInRequested != null:
return signInRequested(_that);case _AuthEvent$SignOutRequested() when signOutRequested != null:
return signOutRequested(_that);case _AuthEvent$StatusChanged() when statusChanged != null:
return statusChanged(_that);case _AuthEvent$UserRefreshed() when userRefreshed != null:
return userRefreshed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  signInRequested,TResult Function()?  signOutRequested,TResult Function( AuthStatus status)?  statusChanged,TResult Function()?  userRefreshed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthEvent$Started() when started != null:
return started();case _AuthEvent$SignInRequested() when signInRequested != null:
return signInRequested();case _AuthEvent$SignOutRequested() when signOutRequested != null:
return signOutRequested();case _AuthEvent$StatusChanged() when statusChanged != null:
return statusChanged(_that.status);case _AuthEvent$UserRefreshed() when userRefreshed != null:
return userRefreshed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  signInRequested,required TResult Function()  signOutRequested,required TResult Function( AuthStatus status)  statusChanged,required TResult Function()  userRefreshed,}) {final _that = this;
switch (_that) {
case _AuthEvent$Started():
return started();case _AuthEvent$SignInRequested():
return signInRequested();case _AuthEvent$SignOutRequested():
return signOutRequested();case _AuthEvent$StatusChanged():
return statusChanged(_that.status);case _AuthEvent$UserRefreshed():
return userRefreshed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  signInRequested,TResult? Function()?  signOutRequested,TResult? Function( AuthStatus status)?  statusChanged,TResult? Function()?  userRefreshed,}) {final _that = this;
switch (_that) {
case _AuthEvent$Started() when started != null:
return started();case _AuthEvent$SignInRequested() when signInRequested != null:
return signInRequested();case _AuthEvent$SignOutRequested() when signOutRequested != null:
return signOutRequested();case _AuthEvent$StatusChanged() when statusChanged != null:
return statusChanged(_that.status);case _AuthEvent$UserRefreshed() when userRefreshed != null:
return userRefreshed();case _:
  return null;

}
}

}

/// @nodoc


class _AuthEvent$Started implements AuthEvent {
  const _AuthEvent$Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthEvent$Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.started()';
}


}




/// @nodoc


class _AuthEvent$SignInRequested implements AuthEvent {
  const _AuthEvent$SignInRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthEvent$SignInRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.signInRequested()';
}


}




/// @nodoc


class _AuthEvent$SignOutRequested implements AuthEvent {
  const _AuthEvent$SignOutRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthEvent$SignOutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.signOutRequested()';
}


}




/// @nodoc


class _AuthEvent$StatusChanged implements AuthEvent {
  const _AuthEvent$StatusChanged(this.status);
  

 final  AuthStatus status;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthEvent$StatusChangedCopyWith<_AuthEvent$StatusChanged> get copyWith => __$AuthEvent$StatusChangedCopyWithImpl<_AuthEvent$StatusChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthEvent$StatusChanged&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'AuthEvent.statusChanged(status: $status)';
}


}

/// @nodoc
abstract mixin class _$AuthEvent$StatusChangedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$AuthEvent$StatusChangedCopyWith(_AuthEvent$StatusChanged value, $Res Function(_AuthEvent$StatusChanged) _then) = __$AuthEvent$StatusChangedCopyWithImpl;
@useResult
$Res call({
 AuthStatus status
});




}
/// @nodoc
class __$AuthEvent$StatusChangedCopyWithImpl<$Res>
    implements _$AuthEvent$StatusChangedCopyWith<$Res> {
  __$AuthEvent$StatusChangedCopyWithImpl(this._self, this._then);

  final _AuthEvent$StatusChanged _self;
  final $Res Function(_AuthEvent$StatusChanged) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_AuthEvent$StatusChanged(
null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,
  ));
}


}

/// @nodoc


class _AuthEvent$UserRefreshed implements AuthEvent {
  const _AuthEvent$UserRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthEvent$UserRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.userRefreshed()';
}


}




/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthState$Unknown value)?  unknown,TResult Function( AuthState$Unauthorized value)?  unauthorized,TResult Function( AuthState$Authorizing value)?  authorizing,TResult Function( AuthState$Authorized value)?  authorized,TResult Function( AuthState$Expired value)?  expired,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthState$Unknown() when unknown != null:
return unknown(_that);case AuthState$Unauthorized() when unauthorized != null:
return unauthorized(_that);case AuthState$Authorizing() when authorizing != null:
return authorizing(_that);case AuthState$Authorized() when authorized != null:
return authorized(_that);case AuthState$Expired() when expired != null:
return expired(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthState$Unknown value)  unknown,required TResult Function( AuthState$Unauthorized value)  unauthorized,required TResult Function( AuthState$Authorizing value)  authorizing,required TResult Function( AuthState$Authorized value)  authorized,required TResult Function( AuthState$Expired value)  expired,}){
final _that = this;
switch (_that) {
case AuthState$Unknown():
return unknown(_that);case AuthState$Unauthorized():
return unauthorized(_that);case AuthState$Authorizing():
return authorizing(_that);case AuthState$Authorized():
return authorized(_that);case AuthState$Expired():
return expired(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthState$Unknown value)?  unknown,TResult? Function( AuthState$Unauthorized value)?  unauthorized,TResult? Function( AuthState$Authorizing value)?  authorizing,TResult? Function( AuthState$Authorized value)?  authorized,TResult? Function( AuthState$Expired value)?  expired,}){
final _that = this;
switch (_that) {
case AuthState$Unknown() when unknown != null:
return unknown(_that);case AuthState$Unauthorized() when unauthorized != null:
return unauthorized(_that);case AuthState$Authorizing() when authorizing != null:
return authorizing(_that);case AuthState$Authorized() when authorized != null:
return authorized(_that);case AuthState$Expired() when expired != null:
return expired(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  unknown,TResult Function( ApiException? error)?  unauthorized,TResult Function()?  authorizing,TResult Function( AuthUserEntity? user)?  authorized,TResult Function( AuthUserEntity? user)?  expired,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthState$Unknown() when unknown != null:
return unknown();case AuthState$Unauthorized() when unauthorized != null:
return unauthorized(_that.error);case AuthState$Authorizing() when authorizing != null:
return authorizing();case AuthState$Authorized() when authorized != null:
return authorized(_that.user);case AuthState$Expired() when expired != null:
return expired(_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  unknown,required TResult Function( ApiException? error)  unauthorized,required TResult Function()  authorizing,required TResult Function( AuthUserEntity? user)  authorized,required TResult Function( AuthUserEntity? user)  expired,}) {final _that = this;
switch (_that) {
case AuthState$Unknown():
return unknown();case AuthState$Unauthorized():
return unauthorized(_that.error);case AuthState$Authorizing():
return authorizing();case AuthState$Authorized():
return authorized(_that.user);case AuthState$Expired():
return expired(_that.user);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  unknown,TResult? Function( ApiException? error)?  unauthorized,TResult? Function()?  authorizing,TResult? Function( AuthUserEntity? user)?  authorized,TResult? Function( AuthUserEntity? user)?  expired,}) {final _that = this;
switch (_that) {
case AuthState$Unknown() when unknown != null:
return unknown();case AuthState$Unauthorized() when unauthorized != null:
return unauthorized(_that.error);case AuthState$Authorizing() when authorizing != null:
return authorizing();case AuthState$Authorized() when authorized != null:
return authorized(_that.user);case AuthState$Expired() when expired != null:
return expired(_that.user);case _:
  return null;

}
}

}

/// @nodoc


class AuthState$Unknown implements AuthState {
  const AuthState$Unknown();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState$Unknown);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.unknown()';
}


}




/// @nodoc


class AuthState$Unauthorized implements AuthState {
  const AuthState$Unauthorized({this.error});
  

 final  ApiException? error;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthState$UnauthorizedCopyWith<AuthState$Unauthorized> get copyWith => _$AuthState$UnauthorizedCopyWithImpl<AuthState$Unauthorized>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState$Unauthorized&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'AuthState.unauthorized(error: $error)';
}


}

/// @nodoc
abstract mixin class $AuthState$UnauthorizedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthState$UnauthorizedCopyWith(AuthState$Unauthorized value, $Res Function(AuthState$Unauthorized) _then) = _$AuthState$UnauthorizedCopyWithImpl;
@useResult
$Res call({
 ApiException? error
});




}
/// @nodoc
class _$AuthState$UnauthorizedCopyWithImpl<$Res>
    implements $AuthState$UnauthorizedCopyWith<$Res> {
  _$AuthState$UnauthorizedCopyWithImpl(this._self, this._then);

  final AuthState$Unauthorized _self;
  final $Res Function(AuthState$Unauthorized) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = freezed,}) {
  return _then(AuthState$Unauthorized(
error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as ApiException?,
  ));
}


}

/// @nodoc


class AuthState$Authorizing implements AuthState {
  const AuthState$Authorizing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState$Authorizing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.authorizing()';
}


}




/// @nodoc


class AuthState$Authorized implements AuthState {
  const AuthState$Authorized({this.user});
  

 final  AuthUserEntity? user;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthState$AuthorizedCopyWith<AuthState$Authorized> get copyWith => _$AuthState$AuthorizedCopyWithImpl<AuthState$Authorized>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState$Authorized&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthState.authorized(user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthState$AuthorizedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthState$AuthorizedCopyWith(AuthState$Authorized value, $Res Function(AuthState$Authorized) _then) = _$AuthState$AuthorizedCopyWithImpl;
@useResult
$Res call({
 AuthUserEntity? user
});


$AuthUserEntityCopyWith<$Res>? get user;

}
/// @nodoc
class _$AuthState$AuthorizedCopyWithImpl<$Res>
    implements $AuthState$AuthorizedCopyWith<$Res> {
  _$AuthState$AuthorizedCopyWithImpl(this._self, this._then);

  final AuthState$Authorized _self;
  final $Res Function(AuthState$Authorized) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = freezed,}) {
  return _then(AuthState$Authorized(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUserEntity?,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserEntityCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $AuthUserEntityCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class AuthState$Expired implements AuthState {
  const AuthState$Expired({this.user});
  

 final  AuthUserEntity? user;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthState$ExpiredCopyWith<AuthState$Expired> get copyWith => _$AuthState$ExpiredCopyWithImpl<AuthState$Expired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState$Expired&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthState.expired(user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthState$ExpiredCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthState$ExpiredCopyWith(AuthState$Expired value, $Res Function(AuthState$Expired) _then) = _$AuthState$ExpiredCopyWithImpl;
@useResult
$Res call({
 AuthUserEntity? user
});


$AuthUserEntityCopyWith<$Res>? get user;

}
/// @nodoc
class _$AuthState$ExpiredCopyWithImpl<$Res>
    implements $AuthState$ExpiredCopyWith<$Res> {
  _$AuthState$ExpiredCopyWithImpl(this._self, this._then);

  final AuthState$Expired _self;
  final $Res Function(AuthState$Expired) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = freezed,}) {
  return _then(AuthState$Expired(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUserEntity?,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserEntityCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $AuthUserEntityCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
