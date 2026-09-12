// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debug_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DebugEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DebugEvent()';
}


}

/// @nodoc
class $DebugEventCopyWith<$Res>  {
$DebugEventCopyWith(DebugEvent _, $Res Function(DebugEvent) __);
}


/// Adds pattern-matching-related methods to [DebugEvent].
extension DebugEventPatterns on DebugEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _DebugEvent$ProxyApplied value)?  proxyApplied,TResult Function( _DebugEvent$ProxyCleared value)?  proxyCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebugEvent$ProxyApplied() when proxyApplied != null:
return proxyApplied(_that);case _DebugEvent$ProxyCleared() when proxyCleared != null:
return proxyCleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _DebugEvent$ProxyApplied value)  proxyApplied,required TResult Function( _DebugEvent$ProxyCleared value)  proxyCleared,}){
final _that = this;
switch (_that) {
case _DebugEvent$ProxyApplied():
return proxyApplied(_that);case _DebugEvent$ProxyCleared():
return proxyCleared(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _DebugEvent$ProxyApplied value)?  proxyApplied,TResult? Function( _DebugEvent$ProxyCleared value)?  proxyCleared,}){
final _that = this;
switch (_that) {
case _DebugEvent$ProxyApplied() when proxyApplied != null:
return proxyApplied(_that);case _DebugEvent$ProxyCleared() when proxyCleared != null:
return proxyCleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? proxyUrl)?  proxyApplied,TResult Function()?  proxyCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebugEvent$ProxyApplied() when proxyApplied != null:
return proxyApplied(_that.proxyUrl);case _DebugEvent$ProxyCleared() when proxyCleared != null:
return proxyCleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? proxyUrl)  proxyApplied,required TResult Function()  proxyCleared,}) {final _that = this;
switch (_that) {
case _DebugEvent$ProxyApplied():
return proxyApplied(_that.proxyUrl);case _DebugEvent$ProxyCleared():
return proxyCleared();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? proxyUrl)?  proxyApplied,TResult? Function()?  proxyCleared,}) {final _that = this;
switch (_that) {
case _DebugEvent$ProxyApplied() when proxyApplied != null:
return proxyApplied(_that.proxyUrl);case _DebugEvent$ProxyCleared() when proxyCleared != null:
return proxyCleared();case _:
  return null;

}
}

}

/// @nodoc


class _DebugEvent$ProxyApplied implements DebugEvent {
  const _DebugEvent$ProxyApplied({required this.proxyUrl});
  

 final  String? proxyUrl;

/// Create a copy of DebugEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebugEvent$ProxyAppliedCopyWith<_DebugEvent$ProxyApplied> get copyWith => __$DebugEvent$ProxyAppliedCopyWithImpl<_DebugEvent$ProxyApplied>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebugEvent$ProxyApplied&&(identical(other.proxyUrl, proxyUrl) || other.proxyUrl == proxyUrl));
}


@override
int get hashCode => Object.hash(runtimeType,proxyUrl);

@override
String toString() {
  return 'DebugEvent.proxyApplied(proxyUrl: $proxyUrl)';
}


}

/// @nodoc
abstract mixin class _$DebugEvent$ProxyAppliedCopyWith<$Res> implements $DebugEventCopyWith<$Res> {
  factory _$DebugEvent$ProxyAppliedCopyWith(_DebugEvent$ProxyApplied value, $Res Function(_DebugEvent$ProxyApplied) _then) = __$DebugEvent$ProxyAppliedCopyWithImpl;
@useResult
$Res call({
 String? proxyUrl
});




}
/// @nodoc
class __$DebugEvent$ProxyAppliedCopyWithImpl<$Res>
    implements _$DebugEvent$ProxyAppliedCopyWith<$Res> {
  __$DebugEvent$ProxyAppliedCopyWithImpl(this._self, this._then);

  final _DebugEvent$ProxyApplied _self;
  final $Res Function(_DebugEvent$ProxyApplied) _then;

/// Create a copy of DebugEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? proxyUrl = freezed,}) {
  return _then(_DebugEvent$ProxyApplied(
proxyUrl: freezed == proxyUrl ? _self.proxyUrl : proxyUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _DebugEvent$ProxyCleared implements DebugEvent {
  const _DebugEvent$ProxyCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebugEvent$ProxyCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DebugEvent.proxyCleared()';
}


}




/// @nodoc
mixin _$DebugState {

/// Base URL текущего окружения.
 String get baseUrl;/// Сохранённый адрес прокси или `null`, если прокси выключен.
 String? get proxyUrl;/// Одноразовый результат сохранения — показывается снеком.
 SideEffectValue<DebugProxyOutcome>? get outcome;/// Текст ошибки последнего сохранения.
 String? get errorMessage;
/// Create a copy of DebugState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebugStateCopyWith<DebugState> get copyWith => _$DebugStateCopyWithImpl<DebugState>(this as DebugState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugState&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.proxyUrl, proxyUrl) || other.proxyUrl == proxyUrl)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,baseUrl,proxyUrl,outcome,errorMessage);

@override
String toString() {
  return 'DebugState(baseUrl: $baseUrl, proxyUrl: $proxyUrl, outcome: $outcome, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $DebugStateCopyWith<$Res>  {
  factory $DebugStateCopyWith(DebugState value, $Res Function(DebugState) _then) = _$DebugStateCopyWithImpl;
@useResult
$Res call({
 String baseUrl, String? proxyUrl, SideEffectValue<DebugProxyOutcome>? outcome, String? errorMessage
});




}
/// @nodoc
class _$DebugStateCopyWithImpl<$Res>
    implements $DebugStateCopyWith<$Res> {
  _$DebugStateCopyWithImpl(this._self, this._then);

  final DebugState _self;
  final $Res Function(DebugState) _then;

/// Create a copy of DebugState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseUrl = null,Object? proxyUrl = freezed,Object? outcome = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,proxyUrl: freezed == proxyUrl ? _self.proxyUrl : proxyUrl // ignore: cast_nullable_to_non_nullable
as String?,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as SideEffectValue<DebugProxyOutcome>?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DebugState].
extension DebugStatePatterns on DebugState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebugState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebugState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebugState value)  $default,){
final _that = this;
switch (_that) {
case _DebugState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebugState value)?  $default,){
final _that = this;
switch (_that) {
case _DebugState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String baseUrl,  String? proxyUrl,  SideEffectValue<DebugProxyOutcome>? outcome,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebugState() when $default != null:
return $default(_that.baseUrl,_that.proxyUrl,_that.outcome,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String baseUrl,  String? proxyUrl,  SideEffectValue<DebugProxyOutcome>? outcome,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _DebugState():
return $default(_that.baseUrl,_that.proxyUrl,_that.outcome,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String baseUrl,  String? proxyUrl,  SideEffectValue<DebugProxyOutcome>? outcome,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _DebugState() when $default != null:
return $default(_that.baseUrl,_that.proxyUrl,_that.outcome,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _DebugState implements DebugState {
  const _DebugState({required this.baseUrl, this.proxyUrl, this.outcome, this.errorMessage});
  

/// Base URL текущего окружения.
@override final  String baseUrl;
/// Сохранённый адрес прокси или `null`, если прокси выключен.
@override final  String? proxyUrl;
/// Одноразовый результат сохранения — показывается снеком.
@override final  SideEffectValue<DebugProxyOutcome>? outcome;
/// Текст ошибки последнего сохранения.
@override final  String? errorMessage;

/// Create a copy of DebugState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebugStateCopyWith<_DebugState> get copyWith => __$DebugStateCopyWithImpl<_DebugState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebugState&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.proxyUrl, proxyUrl) || other.proxyUrl == proxyUrl)&&(identical(other.outcome, outcome) || other.outcome == outcome)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,baseUrl,proxyUrl,outcome,errorMessage);

@override
String toString() {
  return 'DebugState(baseUrl: $baseUrl, proxyUrl: $proxyUrl, outcome: $outcome, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$DebugStateCopyWith<$Res> implements $DebugStateCopyWith<$Res> {
  factory _$DebugStateCopyWith(_DebugState value, $Res Function(_DebugState) _then) = __$DebugStateCopyWithImpl;
@override @useResult
$Res call({
 String baseUrl, String? proxyUrl, SideEffectValue<DebugProxyOutcome>? outcome, String? errorMessage
});




}
/// @nodoc
class __$DebugStateCopyWithImpl<$Res>
    implements _$DebugStateCopyWith<$Res> {
  __$DebugStateCopyWithImpl(this._self, this._then);

  final _DebugState _self;
  final $Res Function(_DebugState) _then;

/// Create a copy of DebugState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,Object? proxyUrl = freezed,Object? outcome = freezed,Object? errorMessage = freezed,}) {
  return _then(_DebugState(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,proxyUrl: freezed == proxyUrl ? _self.proxyUrl : proxyUrl // ignore: cast_nullable_to_non_nullable
as String?,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as SideEffectValue<DebugProxyOutcome>?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
