// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csv_import_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CsvImportEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CsvImportEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CsvImportEvent()';
}


}

/// @nodoc
class $CsvImportEventCopyWith<$Res>  {
$CsvImportEventCopyWith(CsvImportEvent _, $Res Function(CsvImportEvent) __);
}


/// Adds pattern-matching-related methods to [CsvImportEvent].
extension CsvImportEventPatterns on CsvImportEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CsvImportEvent$Reset value)?  reset,TResult Function( _CsvImportEvent$FilesPickRequested value)?  filesPickRequested,TResult Function( _CsvImportEvent$FileRemoved value)?  fileRemoved,TResult Function( _CsvImportEvent$DelimiterChanged value)?  delimiterChanged,TResult Function( _CsvImportEvent$ImportRequested value)?  importRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CsvImportEvent$Reset() when reset != null:
return reset(_that);case _CsvImportEvent$FilesPickRequested() when filesPickRequested != null:
return filesPickRequested(_that);case _CsvImportEvent$FileRemoved() when fileRemoved != null:
return fileRemoved(_that);case _CsvImportEvent$DelimiterChanged() when delimiterChanged != null:
return delimiterChanged(_that);case _CsvImportEvent$ImportRequested() when importRequested != null:
return importRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CsvImportEvent$Reset value)  reset,required TResult Function( _CsvImportEvent$FilesPickRequested value)  filesPickRequested,required TResult Function( _CsvImportEvent$FileRemoved value)  fileRemoved,required TResult Function( _CsvImportEvent$DelimiterChanged value)  delimiterChanged,required TResult Function( _CsvImportEvent$ImportRequested value)  importRequested,}){
final _that = this;
switch (_that) {
case _CsvImportEvent$Reset():
return reset(_that);case _CsvImportEvent$FilesPickRequested():
return filesPickRequested(_that);case _CsvImportEvent$FileRemoved():
return fileRemoved(_that);case _CsvImportEvent$DelimiterChanged():
return delimiterChanged(_that);case _CsvImportEvent$ImportRequested():
return importRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CsvImportEvent$Reset value)?  reset,TResult? Function( _CsvImportEvent$FilesPickRequested value)?  filesPickRequested,TResult? Function( _CsvImportEvent$FileRemoved value)?  fileRemoved,TResult? Function( _CsvImportEvent$DelimiterChanged value)?  delimiterChanged,TResult? Function( _CsvImportEvent$ImportRequested value)?  importRequested,}){
final _that = this;
switch (_that) {
case _CsvImportEvent$Reset() when reset != null:
return reset(_that);case _CsvImportEvent$FilesPickRequested() when filesPickRequested != null:
return filesPickRequested(_that);case _CsvImportEvent$FileRemoved() when fileRemoved != null:
return fileRemoved(_that);case _CsvImportEvent$DelimiterChanged() when delimiterChanged != null:
return delimiterChanged(_that);case _CsvImportEvent$ImportRequested() when importRequested != null:
return importRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  reset,TResult Function()?  filesPickRequested,TResult Function( int index)?  fileRemoved,TResult Function( String delimiter)?  delimiterChanged,TResult Function()?  importRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CsvImportEvent$Reset() when reset != null:
return reset();case _CsvImportEvent$FilesPickRequested() when filesPickRequested != null:
return filesPickRequested();case _CsvImportEvent$FileRemoved() when fileRemoved != null:
return fileRemoved(_that.index);case _CsvImportEvent$DelimiterChanged() when delimiterChanged != null:
return delimiterChanged(_that.delimiter);case _CsvImportEvent$ImportRequested() when importRequested != null:
return importRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  reset,required TResult Function()  filesPickRequested,required TResult Function( int index)  fileRemoved,required TResult Function( String delimiter)  delimiterChanged,required TResult Function()  importRequested,}) {final _that = this;
switch (_that) {
case _CsvImportEvent$Reset():
return reset();case _CsvImportEvent$FilesPickRequested():
return filesPickRequested();case _CsvImportEvent$FileRemoved():
return fileRemoved(_that.index);case _CsvImportEvent$DelimiterChanged():
return delimiterChanged(_that.delimiter);case _CsvImportEvent$ImportRequested():
return importRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  reset,TResult? Function()?  filesPickRequested,TResult? Function( int index)?  fileRemoved,TResult? Function( String delimiter)?  delimiterChanged,TResult? Function()?  importRequested,}) {final _that = this;
switch (_that) {
case _CsvImportEvent$Reset() when reset != null:
return reset();case _CsvImportEvent$FilesPickRequested() when filesPickRequested != null:
return filesPickRequested();case _CsvImportEvent$FileRemoved() when fileRemoved != null:
return fileRemoved(_that.index);case _CsvImportEvent$DelimiterChanged() when delimiterChanged != null:
return delimiterChanged(_that.delimiter);case _CsvImportEvent$ImportRequested() when importRequested != null:
return importRequested();case _:
  return null;

}
}

}

/// @nodoc


class _CsvImportEvent$Reset implements CsvImportEvent {
  const _CsvImportEvent$Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CsvImportEvent$Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CsvImportEvent.reset()';
}


}




/// @nodoc


class _CsvImportEvent$FilesPickRequested implements CsvImportEvent {
  const _CsvImportEvent$FilesPickRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CsvImportEvent$FilesPickRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CsvImportEvent.filesPickRequested()';
}


}




/// @nodoc


class _CsvImportEvent$FileRemoved implements CsvImportEvent {
  const _CsvImportEvent$FileRemoved({required this.index});
  

 final  int index;

/// Create a copy of CsvImportEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CsvImportEvent$FileRemovedCopyWith<_CsvImportEvent$FileRemoved> get copyWith => __$CsvImportEvent$FileRemovedCopyWithImpl<_CsvImportEvent$FileRemoved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CsvImportEvent$FileRemoved&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'CsvImportEvent.fileRemoved(index: $index)';
}


}

/// @nodoc
abstract mixin class _$CsvImportEvent$FileRemovedCopyWith<$Res> implements $CsvImportEventCopyWith<$Res> {
  factory _$CsvImportEvent$FileRemovedCopyWith(_CsvImportEvent$FileRemoved value, $Res Function(_CsvImportEvent$FileRemoved) _then) = __$CsvImportEvent$FileRemovedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class __$CsvImportEvent$FileRemovedCopyWithImpl<$Res>
    implements _$CsvImportEvent$FileRemovedCopyWith<$Res> {
  __$CsvImportEvent$FileRemovedCopyWithImpl(this._self, this._then);

  final _CsvImportEvent$FileRemoved _self;
  final $Res Function(_CsvImportEvent$FileRemoved) _then;

/// Create a copy of CsvImportEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(_CsvImportEvent$FileRemoved(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _CsvImportEvent$DelimiterChanged implements CsvImportEvent {
  const _CsvImportEvent$DelimiterChanged({required this.delimiter});
  

 final  String delimiter;

/// Create a copy of CsvImportEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CsvImportEvent$DelimiterChangedCopyWith<_CsvImportEvent$DelimiterChanged> get copyWith => __$CsvImportEvent$DelimiterChangedCopyWithImpl<_CsvImportEvent$DelimiterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CsvImportEvent$DelimiterChanged&&(identical(other.delimiter, delimiter) || other.delimiter == delimiter));
}


@override
int get hashCode => Object.hash(runtimeType,delimiter);

@override
String toString() {
  return 'CsvImportEvent.delimiterChanged(delimiter: $delimiter)';
}


}

/// @nodoc
abstract mixin class _$CsvImportEvent$DelimiterChangedCopyWith<$Res> implements $CsvImportEventCopyWith<$Res> {
  factory _$CsvImportEvent$DelimiterChangedCopyWith(_CsvImportEvent$DelimiterChanged value, $Res Function(_CsvImportEvent$DelimiterChanged) _then) = __$CsvImportEvent$DelimiterChangedCopyWithImpl;
@useResult
$Res call({
 String delimiter
});




}
/// @nodoc
class __$CsvImportEvent$DelimiterChangedCopyWithImpl<$Res>
    implements _$CsvImportEvent$DelimiterChangedCopyWith<$Res> {
  __$CsvImportEvent$DelimiterChangedCopyWithImpl(this._self, this._then);

  final _CsvImportEvent$DelimiterChanged _self;
  final $Res Function(_CsvImportEvent$DelimiterChanged) _then;

/// Create a copy of CsvImportEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? delimiter = null,}) {
  return _then(_CsvImportEvent$DelimiterChanged(
delimiter: null == delimiter ? _self.delimiter : delimiter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CsvImportEvent$ImportRequested implements CsvImportEvent {
  const _CsvImportEvent$ImportRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CsvImportEvent$ImportRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CsvImportEvent.importRequested()';
}


}




/// @nodoc
mixin _$CsvImportState {

/// Выбранные пути к файлам.
 List<String> get files;/// Разделитель колонок.
 String get delimiter;/// Идёт разбор файлов.
 bool get isParsing;/// Сколько файлов участвовало в последнем разборе — нужно для сообщения.
 int get fileCount;/// Одноразовый результат разбора.
 SideEffectValue<CsvImportResult>? get result;
/// Create a copy of CsvImportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CsvImportStateCopyWith<CsvImportState> get copyWith => _$CsvImportStateCopyWithImpl<CsvImportState>(this as CsvImportState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CsvImportState&&const DeepCollectionEquality().equals(other.files, files)&&(identical(other.delimiter, delimiter) || other.delimiter == delimiter)&&(identical(other.isParsing, isParsing) || other.isParsing == isParsing)&&(identical(other.fileCount, fileCount) || other.fileCount == fileCount)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(files),delimiter,isParsing,fileCount,result);

@override
String toString() {
  return 'CsvImportState(files: $files, delimiter: $delimiter, isParsing: $isParsing, fileCount: $fileCount, result: $result)';
}


}

/// @nodoc
abstract mixin class $CsvImportStateCopyWith<$Res>  {
  factory $CsvImportStateCopyWith(CsvImportState value, $Res Function(CsvImportState) _then) = _$CsvImportStateCopyWithImpl;
@useResult
$Res call({
 List<String> files, String delimiter, bool isParsing, int fileCount, SideEffectValue<CsvImportResult>? result
});




}
/// @nodoc
class _$CsvImportStateCopyWithImpl<$Res>
    implements $CsvImportStateCopyWith<$Res> {
  _$CsvImportStateCopyWithImpl(this._self, this._then);

  final CsvImportState _self;
  final $Res Function(CsvImportState) _then;

/// Create a copy of CsvImportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? files = null,Object? delimiter = null,Object? isParsing = null,Object? fileCount = null,Object? result = freezed,}) {
  return _then(_self.copyWith(
files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as List<String>,delimiter: null == delimiter ? _self.delimiter : delimiter // ignore: cast_nullable_to_non_nullable
as String,isParsing: null == isParsing ? _self.isParsing : isParsing // ignore: cast_nullable_to_non_nullable
as bool,fileCount: null == fileCount ? _self.fileCount : fileCount // ignore: cast_nullable_to_non_nullable
as int,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as SideEffectValue<CsvImportResult>?,
  ));
}

}


/// Adds pattern-matching-related methods to [CsvImportState].
extension CsvImportStatePatterns on CsvImportState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CsvImportState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CsvImportState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CsvImportState value)  $default,){
final _that = this;
switch (_that) {
case _CsvImportState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CsvImportState value)?  $default,){
final _that = this;
switch (_that) {
case _CsvImportState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> files,  String delimiter,  bool isParsing,  int fileCount,  SideEffectValue<CsvImportResult>? result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CsvImportState() when $default != null:
return $default(_that.files,_that.delimiter,_that.isParsing,_that.fileCount,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> files,  String delimiter,  bool isParsing,  int fileCount,  SideEffectValue<CsvImportResult>? result)  $default,) {final _that = this;
switch (_that) {
case _CsvImportState():
return $default(_that.files,_that.delimiter,_that.isParsing,_that.fileCount,_that.result);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> files,  String delimiter,  bool isParsing,  int fileCount,  SideEffectValue<CsvImportResult>? result)?  $default,) {final _that = this;
switch (_that) {
case _CsvImportState() when $default != null:
return $default(_that.files,_that.delimiter,_that.isParsing,_that.fileCount,_that.result);case _:
  return null;

}
}

}

/// @nodoc


class _CsvImportState extends CsvImportState {
  const _CsvImportState({final  List<String> files = const <String>[], this.delimiter = ';', this.isParsing = false, this.fileCount = 0, this.result}): _files = files,super._();
  

/// Выбранные пути к файлам.
 final  List<String> _files;
/// Выбранные пути к файлам.
@override@JsonKey() List<String> get files {
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_files);
}

/// Разделитель колонок.
@override@JsonKey() final  String delimiter;
/// Идёт разбор файлов.
@override@JsonKey() final  bool isParsing;
/// Сколько файлов участвовало в последнем разборе — нужно для сообщения.
@override@JsonKey() final  int fileCount;
/// Одноразовый результат разбора.
@override final  SideEffectValue<CsvImportResult>? result;

/// Create a copy of CsvImportState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CsvImportStateCopyWith<_CsvImportState> get copyWith => __$CsvImportStateCopyWithImpl<_CsvImportState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CsvImportState&&const DeepCollectionEquality().equals(other._files, _files)&&(identical(other.delimiter, delimiter) || other.delimiter == delimiter)&&(identical(other.isParsing, isParsing) || other.isParsing == isParsing)&&(identical(other.fileCount, fileCount) || other.fileCount == fileCount)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_files),delimiter,isParsing,fileCount,result);

@override
String toString() {
  return 'CsvImportState(files: $files, delimiter: $delimiter, isParsing: $isParsing, fileCount: $fileCount, result: $result)';
}


}

/// @nodoc
abstract mixin class _$CsvImportStateCopyWith<$Res> implements $CsvImportStateCopyWith<$Res> {
  factory _$CsvImportStateCopyWith(_CsvImportState value, $Res Function(_CsvImportState) _then) = __$CsvImportStateCopyWithImpl;
@override @useResult
$Res call({
 List<String> files, String delimiter, bool isParsing, int fileCount, SideEffectValue<CsvImportResult>? result
});




}
/// @nodoc
class __$CsvImportStateCopyWithImpl<$Res>
    implements _$CsvImportStateCopyWith<$Res> {
  __$CsvImportStateCopyWithImpl(this._self, this._then);

  final _CsvImportState _self;
  final $Res Function(_CsvImportState) _then;

/// Create a copy of CsvImportState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? files = null,Object? delimiter = null,Object? isParsing = null,Object? fileCount = null,Object? result = freezed,}) {
  return _then(_CsvImportState(
files: null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<String>,delimiter: null == delimiter ? _self.delimiter : delimiter // ignore: cast_nullable_to_non_nullable
as String,isParsing: null == isParsing ? _self.isParsing : isParsing // ignore: cast_nullable_to_non_nullable
as bool,fileCount: null == fileCount ? _self.fileCount : fileCount // ignore: cast_nullable_to_non_nullable
as int,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as SideEffectValue<CsvImportResult>?,
  ));
}


}

// dart format on
