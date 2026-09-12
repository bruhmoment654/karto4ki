// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_test_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActiveTestSession {

/// Прогресс прохождения и карточки.
 TestSession get session;/// Параметры, с которыми тест был запущен.
 ActiveSessionLaunchParams get params;/// Название теста — для отображения в карточке «Продолжить».
 String get testTitle;/// Момент последнего сохранения.
 DateTime get updatedAt;
/// Create a copy of ActiveTestSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveTestSessionCopyWith<ActiveTestSession> get copyWith => _$ActiveTestSessionCopyWithImpl<ActiveTestSession>(this as ActiveTestSession, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveTestSession&&(identical(other.session, session) || other.session == session)&&(identical(other.params, params) || other.params == params)&&(identical(other.testTitle, testTitle) || other.testTitle == testTitle)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,session,params,testTitle,updatedAt);

@override
String toString() {
  return 'ActiveTestSession(session: $session, params: $params, testTitle: $testTitle, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ActiveTestSessionCopyWith<$Res>  {
  factory $ActiveTestSessionCopyWith(ActiveTestSession value, $Res Function(ActiveTestSession) _then) = _$ActiveTestSessionCopyWithImpl;
@useResult
$Res call({
 TestSession session, ActiveSessionLaunchParams params, String testTitle, DateTime updatedAt
});


$TestSessionCopyWith<$Res> get session;$ActiveSessionLaunchParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$ActiveTestSessionCopyWithImpl<$Res>
    implements $ActiveTestSessionCopyWith<$Res> {
  _$ActiveTestSessionCopyWithImpl(this._self, this._then);

  final ActiveTestSession _self;
  final $Res Function(ActiveTestSession) _then;

/// Create a copy of ActiveTestSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? session = null,Object? params = null,Object? testTitle = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as TestSession,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as ActiveSessionLaunchParams,testTitle: null == testTitle ? _self.testTitle : testTitle // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of ActiveTestSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestSessionCopyWith<$Res> get session {
  
  return $TestSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of ActiveTestSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveSessionLaunchParamsCopyWith<$Res> get params {
  
  return $ActiveSessionLaunchParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}


/// Adds pattern-matching-related methods to [ActiveTestSession].
extension ActiveTestSessionPatterns on ActiveTestSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActiveTestSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActiveTestSession() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActiveTestSession value)  $default,){
final _that = this;
switch (_that) {
case _ActiveTestSession():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActiveTestSession value)?  $default,){
final _that = this;
switch (_that) {
case _ActiveTestSession() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TestSession session,  ActiveSessionLaunchParams params,  String testTitle,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActiveTestSession() when $default != null:
return $default(_that.session,_that.params,_that.testTitle,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TestSession session,  ActiveSessionLaunchParams params,  String testTitle,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ActiveTestSession():
return $default(_that.session,_that.params,_that.testTitle,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TestSession session,  ActiveSessionLaunchParams params,  String testTitle,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ActiveTestSession() when $default != null:
return $default(_that.session,_that.params,_that.testTitle,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _ActiveTestSession implements ActiveTestSession {
  const _ActiveTestSession({required this.session, required this.params, required this.testTitle, required this.updatedAt});
  

/// Прогресс прохождения и карточки.
@override final  TestSession session;
/// Параметры, с которыми тест был запущен.
@override final  ActiveSessionLaunchParams params;
/// Название теста — для отображения в карточке «Продолжить».
@override final  String testTitle;
/// Момент последнего сохранения.
@override final  DateTime updatedAt;

/// Create a copy of ActiveTestSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveTestSessionCopyWith<_ActiveTestSession> get copyWith => __$ActiveTestSessionCopyWithImpl<_ActiveTestSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActiveTestSession&&(identical(other.session, session) || other.session == session)&&(identical(other.params, params) || other.params == params)&&(identical(other.testTitle, testTitle) || other.testTitle == testTitle)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,session,params,testTitle,updatedAt);

@override
String toString() {
  return 'ActiveTestSession(session: $session, params: $params, testTitle: $testTitle, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ActiveTestSessionCopyWith<$Res> implements $ActiveTestSessionCopyWith<$Res> {
  factory _$ActiveTestSessionCopyWith(_ActiveTestSession value, $Res Function(_ActiveTestSession) _then) = __$ActiveTestSessionCopyWithImpl;
@override @useResult
$Res call({
 TestSession session, ActiveSessionLaunchParams params, String testTitle, DateTime updatedAt
});


@override $TestSessionCopyWith<$Res> get session;@override $ActiveSessionLaunchParamsCopyWith<$Res> get params;

}
/// @nodoc
class __$ActiveTestSessionCopyWithImpl<$Res>
    implements _$ActiveTestSessionCopyWith<$Res> {
  __$ActiveTestSessionCopyWithImpl(this._self, this._then);

  final _ActiveTestSession _self;
  final $Res Function(_ActiveTestSession) _then;

/// Create a copy of ActiveTestSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? session = null,Object? params = null,Object? testTitle = null,Object? updatedAt = null,}) {
  return _then(_ActiveTestSession(
session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as TestSession,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as ActiveSessionLaunchParams,testTitle: null == testTitle ? _self.testTitle : testTitle // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of ActiveTestSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TestSessionCopyWith<$Res> get session {
  
  return $TestSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of ActiveTestSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActiveSessionLaunchParamsCopyWith<$Res> get params {
  
  return $ActiveSessionLaunchParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}

// dart format on
