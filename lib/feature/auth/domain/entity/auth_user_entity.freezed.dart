// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthUserEntity {

 String get id; String get email;/// Тариф: `free` | `pro`.
 String get plan;/// Имя из OAuth-профиля. Может отсутствовать.
 String? get displayName;/// Аватар из OAuth-профиля.
///
/// Навсегда nullable: у аккаунта без фото Google ничего не отдаст,
/// а сами URL'ы периодически меняются и отдают 404. Инициалы —
/// постоянный фолбэк, а не временная заглушка.
 String? get avatarUrl;
/// Create a copy of AuthUserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthUserEntityCopyWith<AuthUserEntity> get copyWith => _$AuthUserEntityCopyWithImpl<AuthUserEntity>(this as AuthUserEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUserEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,email,plan,displayName,avatarUrl);

@override
String toString() {
  return 'AuthUserEntity(id: $id, email: $email, plan: $plan, displayName: $displayName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $AuthUserEntityCopyWith<$Res>  {
  factory $AuthUserEntityCopyWith(AuthUserEntity value, $Res Function(AuthUserEntity) _then) = _$AuthUserEntityCopyWithImpl;
@useResult
$Res call({
 String id, String email, String plan, String? displayName, String? avatarUrl
});




}
/// @nodoc
class _$AuthUserEntityCopyWithImpl<$Res>
    implements $AuthUserEntityCopyWith<$Res> {
  _$AuthUserEntityCopyWithImpl(this._self, this._then);

  final AuthUserEntity _self;
  final $Res Function(AuthUserEntity) _then;

/// Create a copy of AuthUserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? plan = null,Object? displayName = freezed,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthUserEntity].
extension AuthUserEntityPatterns on AuthUserEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthUserEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthUserEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthUserEntity value)  $default,){
final _that = this;
switch (_that) {
case _AuthUserEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthUserEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AuthUserEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String plan,  String? displayName,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthUserEntity() when $default != null:
return $default(_that.id,_that.email,_that.plan,_that.displayName,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String plan,  String? displayName,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _AuthUserEntity():
return $default(_that.id,_that.email,_that.plan,_that.displayName,_that.avatarUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String plan,  String? displayName,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _AuthUserEntity() when $default != null:
return $default(_that.id,_that.email,_that.plan,_that.displayName,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc


class _AuthUserEntity extends AuthUserEntity {
  const _AuthUserEntity({required this.id, required this.email, required this.plan, this.displayName, this.avatarUrl}): super._();
  

@override final  String id;
@override final  String email;
/// Тариф: `free` | `pro`.
@override final  String plan;
/// Имя из OAuth-профиля. Может отсутствовать.
@override final  String? displayName;
/// Аватар из OAuth-профиля.
///
/// Навсегда nullable: у аккаунта без фото Google ничего не отдаст,
/// а сами URL'ы периодически меняются и отдают 404. Инициалы —
/// постоянный фолбэк, а не временная заглушка.
@override final  String? avatarUrl;

/// Create a copy of AuthUserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthUserEntityCopyWith<_AuthUserEntity> get copyWith => __$AuthUserEntityCopyWithImpl<_AuthUserEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthUserEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,email,plan,displayName,avatarUrl);

@override
String toString() {
  return 'AuthUserEntity(id: $id, email: $email, plan: $plan, displayName: $displayName, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$AuthUserEntityCopyWith<$Res> implements $AuthUserEntityCopyWith<$Res> {
  factory _$AuthUserEntityCopyWith(_AuthUserEntity value, $Res Function(_AuthUserEntity) _then) = __$AuthUserEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String plan, String? displayName, String? avatarUrl
});




}
/// @nodoc
class __$AuthUserEntityCopyWithImpl<$Res>
    implements _$AuthUserEntityCopyWith<$Res> {
  __$AuthUserEntityCopyWithImpl(this._self, this._then);

  final _AuthUserEntity _self;
  final $Res Function(_AuthUserEntity) _then;

/// Create a copy of AuthUserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? plan = null,Object? displayName = freezed,Object? avatarUrl = freezed,}) {
  return _then(_AuthUserEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
