// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attempt_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuestionResult {

 CardEntity get card; bool get isCorrect;/// Ответы на вопрос в прохождениях теста, от старых к новым; последний —
/// текущий. Не длиннее [AttemptSummary.historyLength].
 List<bool> get history;/// `null` — в прошлых прохождениях теста вопроса не было.
 QuestionTrend? get trend;
/// Create a copy of QuestionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionResultCopyWith<QuestionResult> get copyWith => _$QuestionResultCopyWithImpl<QuestionResult>(this as QuestionResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionResult&&(identical(other.card, card) || other.card == card)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.trend, trend) || other.trend == trend));
}


@override
int get hashCode => Object.hash(runtimeType,card,isCorrect,const DeepCollectionEquality().hash(history),trend);

@override
String toString() {
  return 'QuestionResult(card: $card, isCorrect: $isCorrect, history: $history, trend: $trend)';
}


}

/// @nodoc
abstract mixin class $QuestionResultCopyWith<$Res>  {
  factory $QuestionResultCopyWith(QuestionResult value, $Res Function(QuestionResult) _then) = _$QuestionResultCopyWithImpl;
@useResult
$Res call({
 CardEntity card, bool isCorrect, List<bool> history, QuestionTrend? trend
});


$CardEntityCopyWith<$Res> get card;

}
/// @nodoc
class _$QuestionResultCopyWithImpl<$Res>
    implements $QuestionResultCopyWith<$Res> {
  _$QuestionResultCopyWithImpl(this._self, this._then);

  final QuestionResult _self;
  final $Res Function(QuestionResult) _then;

/// Create a copy of QuestionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? card = null,Object? isCorrect = null,Object? history = null,Object? trend = freezed,}) {
  return _then(_self.copyWith(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as CardEntity,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<bool>,trend: freezed == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as QuestionTrend?,
  ));
}
/// Create a copy of QuestionResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardEntityCopyWith<$Res> get card {
  
  return $CardEntityCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuestionResult].
extension QuestionResultPatterns on QuestionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionResult value)  $default,){
final _that = this;
switch (_that) {
case _QuestionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionResult value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CardEntity card,  bool isCorrect,  List<bool> history,  QuestionTrend? trend)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionResult() when $default != null:
return $default(_that.card,_that.isCorrect,_that.history,_that.trend);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CardEntity card,  bool isCorrect,  List<bool> history,  QuestionTrend? trend)  $default,) {final _that = this;
switch (_that) {
case _QuestionResult():
return $default(_that.card,_that.isCorrect,_that.history,_that.trend);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CardEntity card,  bool isCorrect,  List<bool> history,  QuestionTrend? trend)?  $default,) {final _that = this;
switch (_that) {
case _QuestionResult() when $default != null:
return $default(_that.card,_that.isCorrect,_that.history,_that.trend);case _:
  return null;

}
}

}

/// @nodoc


class _QuestionResult implements QuestionResult {
  const _QuestionResult({required this.card, required this.isCorrect, required final  List<bool> history, this.trend}): _history = history;
  

@override final  CardEntity card;
@override final  bool isCorrect;
/// Ответы на вопрос в прохождениях теста, от старых к новым; последний —
/// текущий. Не длиннее [AttemptSummary.historyLength].
 final  List<bool> _history;
/// Ответы на вопрос в прохождениях теста, от старых к новым; последний —
/// текущий. Не длиннее [AttemptSummary.historyLength].
@override List<bool> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

/// `null` — в прошлых прохождениях теста вопроса не было.
@override final  QuestionTrend? trend;

/// Create a copy of QuestionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionResultCopyWith<_QuestionResult> get copyWith => __$QuestionResultCopyWithImpl<_QuestionResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionResult&&(identical(other.card, card) || other.card == card)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.trend, trend) || other.trend == trend));
}


@override
int get hashCode => Object.hash(runtimeType,card,isCorrect,const DeepCollectionEquality().hash(_history),trend);

@override
String toString() {
  return 'QuestionResult(card: $card, isCorrect: $isCorrect, history: $history, trend: $trend)';
}


}

/// @nodoc
abstract mixin class _$QuestionResultCopyWith<$Res> implements $QuestionResultCopyWith<$Res> {
  factory _$QuestionResultCopyWith(_QuestionResult value, $Res Function(_QuestionResult) _then) = __$QuestionResultCopyWithImpl;
@override @useResult
$Res call({
 CardEntity card, bool isCorrect, List<bool> history, QuestionTrend? trend
});


@override $CardEntityCopyWith<$Res> get card;

}
/// @nodoc
class __$QuestionResultCopyWithImpl<$Res>
    implements _$QuestionResultCopyWith<$Res> {
  __$QuestionResultCopyWithImpl(this._self, this._then);

  final _QuestionResult _self;
  final $Res Function(_QuestionResult) _then;

/// Create a copy of QuestionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? card = null,Object? isCorrect = null,Object? history = null,Object? trend = freezed,}) {
  return _then(_QuestionResult(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as CardEntity,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<bool>,trend: freezed == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as QuestionTrend?,
  ));
}

/// Create a copy of QuestionResult
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
mixin _$AttemptSummary {

/// Последние прохождения теста от старых к новым; последнее — текущее.
/// Пусто, если историю получить не удалось.
 List<TestAttemptEntity> get recentAttempts;/// Сколько всего раз тест пройден, включая текущий.
 int get totalAttempts; List<QuestionResult> get questions;
/// Create a copy of AttemptSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttemptSummaryCopyWith<AttemptSummary> get copyWith => _$AttemptSummaryCopyWithImpl<AttemptSummary>(this as AttemptSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttemptSummary&&const DeepCollectionEquality().equals(other.recentAttempts, recentAttempts)&&(identical(other.totalAttempts, totalAttempts) || other.totalAttempts == totalAttempts)&&const DeepCollectionEquality().equals(other.questions, questions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(recentAttempts),totalAttempts,const DeepCollectionEquality().hash(questions));

@override
String toString() {
  return 'AttemptSummary(recentAttempts: $recentAttempts, totalAttempts: $totalAttempts, questions: $questions)';
}


}

/// @nodoc
abstract mixin class $AttemptSummaryCopyWith<$Res>  {
  factory $AttemptSummaryCopyWith(AttemptSummary value, $Res Function(AttemptSummary) _then) = _$AttemptSummaryCopyWithImpl;
@useResult
$Res call({
 List<TestAttemptEntity> recentAttempts, int totalAttempts, List<QuestionResult> questions
});




}
/// @nodoc
class _$AttemptSummaryCopyWithImpl<$Res>
    implements $AttemptSummaryCopyWith<$Res> {
  _$AttemptSummaryCopyWithImpl(this._self, this._then);

  final AttemptSummary _self;
  final $Res Function(AttemptSummary) _then;

/// Create a copy of AttemptSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recentAttempts = null,Object? totalAttempts = null,Object? questions = null,}) {
  return _then(_self.copyWith(
recentAttempts: null == recentAttempts ? _self.recentAttempts : recentAttempts // ignore: cast_nullable_to_non_nullable
as List<TestAttemptEntity>,totalAttempts: null == totalAttempts ? _self.totalAttempts : totalAttempts // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<QuestionResult>,
  ));
}

}


/// Adds pattern-matching-related methods to [AttemptSummary].
extension AttemptSummaryPatterns on AttemptSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttemptSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttemptSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttemptSummary value)  $default,){
final _that = this;
switch (_that) {
case _AttemptSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttemptSummary value)?  $default,){
final _that = this;
switch (_that) {
case _AttemptSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TestAttemptEntity> recentAttempts,  int totalAttempts,  List<QuestionResult> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttemptSummary() when $default != null:
return $default(_that.recentAttempts,_that.totalAttempts,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TestAttemptEntity> recentAttempts,  int totalAttempts,  List<QuestionResult> questions)  $default,) {final _that = this;
switch (_that) {
case _AttemptSummary():
return $default(_that.recentAttempts,_that.totalAttempts,_that.questions);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TestAttemptEntity> recentAttempts,  int totalAttempts,  List<QuestionResult> questions)?  $default,) {final _that = this;
switch (_that) {
case _AttemptSummary() when $default != null:
return $default(_that.recentAttempts,_that.totalAttempts,_that.questions);case _:
  return null;

}
}

}

/// @nodoc


class _AttemptSummary extends AttemptSummary {
  const _AttemptSummary({required final  List<TestAttemptEntity> recentAttempts, required this.totalAttempts, required final  List<QuestionResult> questions}): _recentAttempts = recentAttempts,_questions = questions,super._();
  

/// Последние прохождения теста от старых к новым; последнее — текущее.
/// Пусто, если историю получить не удалось.
 final  List<TestAttemptEntity> _recentAttempts;
/// Последние прохождения теста от старых к новым; последнее — текущее.
/// Пусто, если историю получить не удалось.
@override List<TestAttemptEntity> get recentAttempts {
  if (_recentAttempts is EqualUnmodifiableListView) return _recentAttempts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentAttempts);
}

/// Сколько всего раз тест пройден, включая текущий.
@override final  int totalAttempts;
 final  List<QuestionResult> _questions;
@override List<QuestionResult> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of AttemptSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttemptSummaryCopyWith<_AttemptSummary> get copyWith => __$AttemptSummaryCopyWithImpl<_AttemptSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttemptSummary&&const DeepCollectionEquality().equals(other._recentAttempts, _recentAttempts)&&(identical(other.totalAttempts, totalAttempts) || other.totalAttempts == totalAttempts)&&const DeepCollectionEquality().equals(other._questions, _questions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_recentAttempts),totalAttempts,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'AttemptSummary(recentAttempts: $recentAttempts, totalAttempts: $totalAttempts, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$AttemptSummaryCopyWith<$Res> implements $AttemptSummaryCopyWith<$Res> {
  factory _$AttemptSummaryCopyWith(_AttemptSummary value, $Res Function(_AttemptSummary) _then) = __$AttemptSummaryCopyWithImpl;
@override @useResult
$Res call({
 List<TestAttemptEntity> recentAttempts, int totalAttempts, List<QuestionResult> questions
});




}
/// @nodoc
class __$AttemptSummaryCopyWithImpl<$Res>
    implements _$AttemptSummaryCopyWith<$Res> {
  __$AttemptSummaryCopyWithImpl(this._self, this._then);

  final _AttemptSummary _self;
  final $Res Function(_AttemptSummary) _then;

/// Create a copy of AttemptSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recentAttempts = null,Object? totalAttempts = null,Object? questions = null,}) {
  return _then(_AttemptSummary(
recentAttempts: null == recentAttempts ? _self._recentAttempts : recentAttempts // ignore: cast_nullable_to_non_nullable
as List<TestAttemptEntity>,totalAttempts: null == totalAttempts ? _self.totalAttempts : totalAttempts // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<QuestionResult>,
  ));
}


}

// dart format on
