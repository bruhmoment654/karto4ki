// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_summary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileSummaryEntity {

/// Всего ответов: сумма верных и неверных по всем карточкам.
 int get answersTotal;/// Всего верных ответов.
 int get correctTotal;/// Точность в процентах (0..100), 0 если ответов не было.
 int get accuracyPercent;/// Всего карточек со статистикой.
 int get totalCards;/// Карточек со streak >= [kMasteredThreshold].
 int get masteredCount;/// Доля изученных карточек в процентах (0..100).
 int get masteredPercent;/// Карточек без единой ошибки (`totalIncorrect == 0 && totalShown > 0`).
 int get flawlessCount;/// Доля безошибочных карточек в процентах (0..100).
 int get flawlessPercent;/// Слабых карточек: streak < [kWeakThreshold].
 int get weakCardsCount;/// Текущая серия активных дней подряд.
 int get currentStreak;/// Лучшая (рекордная) серия активных дней подряд.
 int get bestStreak;/// Всего дней активности.
 int get activeDaysCount;/// Среднее число ответов в день активности (0 если дней нет).
 double get avgAnswersPerDay;/// Активность по дням текущей недели: 7 значений Пн..Вс.
 List<bool> get weekActivity;/// Количество групп — для карточки-идентичности.
 int get groupsCount;/// Количество тестов — для карточки-идентичности.
 int get testsCount;
/// Create a copy of ProfileSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSummaryEntityCopyWith<ProfileSummaryEntity> get copyWith => _$ProfileSummaryEntityCopyWithImpl<ProfileSummaryEntity>(this as ProfileSummaryEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSummaryEntity&&(identical(other.answersTotal, answersTotal) || other.answersTotal == answersTotal)&&(identical(other.correctTotal, correctTotal) || other.correctTotal == correctTotal)&&(identical(other.accuracyPercent, accuracyPercent) || other.accuracyPercent == accuracyPercent)&&(identical(other.totalCards, totalCards) || other.totalCards == totalCards)&&(identical(other.masteredCount, masteredCount) || other.masteredCount == masteredCount)&&(identical(other.masteredPercent, masteredPercent) || other.masteredPercent == masteredPercent)&&(identical(other.flawlessCount, flawlessCount) || other.flawlessCount == flawlessCount)&&(identical(other.flawlessPercent, flawlessPercent) || other.flawlessPercent == flawlessPercent)&&(identical(other.weakCardsCount, weakCardsCount) || other.weakCardsCount == weakCardsCount)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.activeDaysCount, activeDaysCount) || other.activeDaysCount == activeDaysCount)&&(identical(other.avgAnswersPerDay, avgAnswersPerDay) || other.avgAnswersPerDay == avgAnswersPerDay)&&const DeepCollectionEquality().equals(other.weekActivity, weekActivity)&&(identical(other.groupsCount, groupsCount) || other.groupsCount == groupsCount)&&(identical(other.testsCount, testsCount) || other.testsCount == testsCount));
}


@override
int get hashCode => Object.hash(runtimeType,answersTotal,correctTotal,accuracyPercent,totalCards,masteredCount,masteredPercent,flawlessCount,flawlessPercent,weakCardsCount,currentStreak,bestStreak,activeDaysCount,avgAnswersPerDay,const DeepCollectionEquality().hash(weekActivity),groupsCount,testsCount);

@override
String toString() {
  return 'ProfileSummaryEntity(answersTotal: $answersTotal, correctTotal: $correctTotal, accuracyPercent: $accuracyPercent, totalCards: $totalCards, masteredCount: $masteredCount, masteredPercent: $masteredPercent, flawlessCount: $flawlessCount, flawlessPercent: $flawlessPercent, weakCardsCount: $weakCardsCount, currentStreak: $currentStreak, bestStreak: $bestStreak, activeDaysCount: $activeDaysCount, avgAnswersPerDay: $avgAnswersPerDay, weekActivity: $weekActivity, groupsCount: $groupsCount, testsCount: $testsCount)';
}


}

/// @nodoc
abstract mixin class $ProfileSummaryEntityCopyWith<$Res>  {
  factory $ProfileSummaryEntityCopyWith(ProfileSummaryEntity value, $Res Function(ProfileSummaryEntity) _then) = _$ProfileSummaryEntityCopyWithImpl;
@useResult
$Res call({
 int answersTotal, int correctTotal, int accuracyPercent, int totalCards, int masteredCount, int masteredPercent, int flawlessCount, int flawlessPercent, int weakCardsCount, int currentStreak, int bestStreak, int activeDaysCount, double avgAnswersPerDay, List<bool> weekActivity, int groupsCount, int testsCount
});




}
/// @nodoc
class _$ProfileSummaryEntityCopyWithImpl<$Res>
    implements $ProfileSummaryEntityCopyWith<$Res> {
  _$ProfileSummaryEntityCopyWithImpl(this._self, this._then);

  final ProfileSummaryEntity _self;
  final $Res Function(ProfileSummaryEntity) _then;

/// Create a copy of ProfileSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? answersTotal = null,Object? correctTotal = null,Object? accuracyPercent = null,Object? totalCards = null,Object? masteredCount = null,Object? masteredPercent = null,Object? flawlessCount = null,Object? flawlessPercent = null,Object? weakCardsCount = null,Object? currentStreak = null,Object? bestStreak = null,Object? activeDaysCount = null,Object? avgAnswersPerDay = null,Object? weekActivity = null,Object? groupsCount = null,Object? testsCount = null,}) {
  return _then(_self.copyWith(
answersTotal: null == answersTotal ? _self.answersTotal : answersTotal // ignore: cast_nullable_to_non_nullable
as int,correctTotal: null == correctTotal ? _self.correctTotal : correctTotal // ignore: cast_nullable_to_non_nullable
as int,accuracyPercent: null == accuracyPercent ? _self.accuracyPercent : accuracyPercent // ignore: cast_nullable_to_non_nullable
as int,totalCards: null == totalCards ? _self.totalCards : totalCards // ignore: cast_nullable_to_non_nullable
as int,masteredCount: null == masteredCount ? _self.masteredCount : masteredCount // ignore: cast_nullable_to_non_nullable
as int,masteredPercent: null == masteredPercent ? _self.masteredPercent : masteredPercent // ignore: cast_nullable_to_non_nullable
as int,flawlessCount: null == flawlessCount ? _self.flawlessCount : flawlessCount // ignore: cast_nullable_to_non_nullable
as int,flawlessPercent: null == flawlessPercent ? _self.flawlessPercent : flawlessPercent // ignore: cast_nullable_to_non_nullable
as int,weakCardsCount: null == weakCardsCount ? _self.weakCardsCount : weakCardsCount // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,activeDaysCount: null == activeDaysCount ? _self.activeDaysCount : activeDaysCount // ignore: cast_nullable_to_non_nullable
as int,avgAnswersPerDay: null == avgAnswersPerDay ? _self.avgAnswersPerDay : avgAnswersPerDay // ignore: cast_nullable_to_non_nullable
as double,weekActivity: null == weekActivity ? _self.weekActivity : weekActivity // ignore: cast_nullable_to_non_nullable
as List<bool>,groupsCount: null == groupsCount ? _self.groupsCount : groupsCount // ignore: cast_nullable_to_non_nullable
as int,testsCount: null == testsCount ? _self.testsCount : testsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileSummaryEntity].
extension ProfileSummaryEntityPatterns on ProfileSummaryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileSummaryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileSummaryEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProfileSummaryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileSummaryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int answersTotal,  int correctTotal,  int accuracyPercent,  int totalCards,  int masteredCount,  int masteredPercent,  int flawlessCount,  int flawlessPercent,  int weakCardsCount,  int currentStreak,  int bestStreak,  int activeDaysCount,  double avgAnswersPerDay,  List<bool> weekActivity,  int groupsCount,  int testsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileSummaryEntity() when $default != null:
return $default(_that.answersTotal,_that.correctTotal,_that.accuracyPercent,_that.totalCards,_that.masteredCount,_that.masteredPercent,_that.flawlessCount,_that.flawlessPercent,_that.weakCardsCount,_that.currentStreak,_that.bestStreak,_that.activeDaysCount,_that.avgAnswersPerDay,_that.weekActivity,_that.groupsCount,_that.testsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int answersTotal,  int correctTotal,  int accuracyPercent,  int totalCards,  int masteredCount,  int masteredPercent,  int flawlessCount,  int flawlessPercent,  int weakCardsCount,  int currentStreak,  int bestStreak,  int activeDaysCount,  double avgAnswersPerDay,  List<bool> weekActivity,  int groupsCount,  int testsCount)  $default,) {final _that = this;
switch (_that) {
case _ProfileSummaryEntity():
return $default(_that.answersTotal,_that.correctTotal,_that.accuracyPercent,_that.totalCards,_that.masteredCount,_that.masteredPercent,_that.flawlessCount,_that.flawlessPercent,_that.weakCardsCount,_that.currentStreak,_that.bestStreak,_that.activeDaysCount,_that.avgAnswersPerDay,_that.weekActivity,_that.groupsCount,_that.testsCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int answersTotal,  int correctTotal,  int accuracyPercent,  int totalCards,  int masteredCount,  int masteredPercent,  int flawlessCount,  int flawlessPercent,  int weakCardsCount,  int currentStreak,  int bestStreak,  int activeDaysCount,  double avgAnswersPerDay,  List<bool> weekActivity,  int groupsCount,  int testsCount)?  $default,) {final _that = this;
switch (_that) {
case _ProfileSummaryEntity() when $default != null:
return $default(_that.answersTotal,_that.correctTotal,_that.accuracyPercent,_that.totalCards,_that.masteredCount,_that.masteredPercent,_that.flawlessCount,_that.flawlessPercent,_that.weakCardsCount,_that.currentStreak,_that.bestStreak,_that.activeDaysCount,_that.avgAnswersPerDay,_that.weekActivity,_that.groupsCount,_that.testsCount);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileSummaryEntity implements ProfileSummaryEntity {
  const _ProfileSummaryEntity({required this.answersTotal, required this.correctTotal, required this.accuracyPercent, required this.totalCards, required this.masteredCount, required this.masteredPercent, required this.flawlessCount, required this.flawlessPercent, required this.weakCardsCount, required this.currentStreak, required this.bestStreak, required this.activeDaysCount, required this.avgAnswersPerDay, required final  List<bool> weekActivity, required this.groupsCount, required this.testsCount}): _weekActivity = weekActivity;
  

/// Всего ответов: сумма верных и неверных по всем карточкам.
@override final  int answersTotal;
/// Всего верных ответов.
@override final  int correctTotal;
/// Точность в процентах (0..100), 0 если ответов не было.
@override final  int accuracyPercent;
/// Всего карточек со статистикой.
@override final  int totalCards;
/// Карточек со streak >= [kMasteredThreshold].
@override final  int masteredCount;
/// Доля изученных карточек в процентах (0..100).
@override final  int masteredPercent;
/// Карточек без единой ошибки (`totalIncorrect == 0 && totalShown > 0`).
@override final  int flawlessCount;
/// Доля безошибочных карточек в процентах (0..100).
@override final  int flawlessPercent;
/// Слабых карточек: streak < [kWeakThreshold].
@override final  int weakCardsCount;
/// Текущая серия активных дней подряд.
@override final  int currentStreak;
/// Лучшая (рекордная) серия активных дней подряд.
@override final  int bestStreak;
/// Всего дней активности.
@override final  int activeDaysCount;
/// Среднее число ответов в день активности (0 если дней нет).
@override final  double avgAnswersPerDay;
/// Активность по дням текущей недели: 7 значений Пн..Вс.
 final  List<bool> _weekActivity;
/// Активность по дням текущей недели: 7 значений Пн..Вс.
@override List<bool> get weekActivity {
  if (_weekActivity is EqualUnmodifiableListView) return _weekActivity;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weekActivity);
}

/// Количество групп — для карточки-идентичности.
@override final  int groupsCount;
/// Количество тестов — для карточки-идентичности.
@override final  int testsCount;

/// Create a copy of ProfileSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileSummaryEntityCopyWith<_ProfileSummaryEntity> get copyWith => __$ProfileSummaryEntityCopyWithImpl<_ProfileSummaryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileSummaryEntity&&(identical(other.answersTotal, answersTotal) || other.answersTotal == answersTotal)&&(identical(other.correctTotal, correctTotal) || other.correctTotal == correctTotal)&&(identical(other.accuracyPercent, accuracyPercent) || other.accuracyPercent == accuracyPercent)&&(identical(other.totalCards, totalCards) || other.totalCards == totalCards)&&(identical(other.masteredCount, masteredCount) || other.masteredCount == masteredCount)&&(identical(other.masteredPercent, masteredPercent) || other.masteredPercent == masteredPercent)&&(identical(other.flawlessCount, flawlessCount) || other.flawlessCount == flawlessCount)&&(identical(other.flawlessPercent, flawlessPercent) || other.flawlessPercent == flawlessPercent)&&(identical(other.weakCardsCount, weakCardsCount) || other.weakCardsCount == weakCardsCount)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.activeDaysCount, activeDaysCount) || other.activeDaysCount == activeDaysCount)&&(identical(other.avgAnswersPerDay, avgAnswersPerDay) || other.avgAnswersPerDay == avgAnswersPerDay)&&const DeepCollectionEquality().equals(other._weekActivity, _weekActivity)&&(identical(other.groupsCount, groupsCount) || other.groupsCount == groupsCount)&&(identical(other.testsCount, testsCount) || other.testsCount == testsCount));
}


@override
int get hashCode => Object.hash(runtimeType,answersTotal,correctTotal,accuracyPercent,totalCards,masteredCount,masteredPercent,flawlessCount,flawlessPercent,weakCardsCount,currentStreak,bestStreak,activeDaysCount,avgAnswersPerDay,const DeepCollectionEquality().hash(_weekActivity),groupsCount,testsCount);

@override
String toString() {
  return 'ProfileSummaryEntity(answersTotal: $answersTotal, correctTotal: $correctTotal, accuracyPercent: $accuracyPercent, totalCards: $totalCards, masteredCount: $masteredCount, masteredPercent: $masteredPercent, flawlessCount: $flawlessCount, flawlessPercent: $flawlessPercent, weakCardsCount: $weakCardsCount, currentStreak: $currentStreak, bestStreak: $bestStreak, activeDaysCount: $activeDaysCount, avgAnswersPerDay: $avgAnswersPerDay, weekActivity: $weekActivity, groupsCount: $groupsCount, testsCount: $testsCount)';
}


}

/// @nodoc
abstract mixin class _$ProfileSummaryEntityCopyWith<$Res> implements $ProfileSummaryEntityCopyWith<$Res> {
  factory _$ProfileSummaryEntityCopyWith(_ProfileSummaryEntity value, $Res Function(_ProfileSummaryEntity) _then) = __$ProfileSummaryEntityCopyWithImpl;
@override @useResult
$Res call({
 int answersTotal, int correctTotal, int accuracyPercent, int totalCards, int masteredCount, int masteredPercent, int flawlessCount, int flawlessPercent, int weakCardsCount, int currentStreak, int bestStreak, int activeDaysCount, double avgAnswersPerDay, List<bool> weekActivity, int groupsCount, int testsCount
});




}
/// @nodoc
class __$ProfileSummaryEntityCopyWithImpl<$Res>
    implements _$ProfileSummaryEntityCopyWith<$Res> {
  __$ProfileSummaryEntityCopyWithImpl(this._self, this._then);

  final _ProfileSummaryEntity _self;
  final $Res Function(_ProfileSummaryEntity) _then;

/// Create a copy of ProfileSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? answersTotal = null,Object? correctTotal = null,Object? accuracyPercent = null,Object? totalCards = null,Object? masteredCount = null,Object? masteredPercent = null,Object? flawlessCount = null,Object? flawlessPercent = null,Object? weakCardsCount = null,Object? currentStreak = null,Object? bestStreak = null,Object? activeDaysCount = null,Object? avgAnswersPerDay = null,Object? weekActivity = null,Object? groupsCount = null,Object? testsCount = null,}) {
  return _then(_ProfileSummaryEntity(
answersTotal: null == answersTotal ? _self.answersTotal : answersTotal // ignore: cast_nullable_to_non_nullable
as int,correctTotal: null == correctTotal ? _self.correctTotal : correctTotal // ignore: cast_nullable_to_non_nullable
as int,accuracyPercent: null == accuracyPercent ? _self.accuracyPercent : accuracyPercent // ignore: cast_nullable_to_non_nullable
as int,totalCards: null == totalCards ? _self.totalCards : totalCards // ignore: cast_nullable_to_non_nullable
as int,masteredCount: null == masteredCount ? _self.masteredCount : masteredCount // ignore: cast_nullable_to_non_nullable
as int,masteredPercent: null == masteredPercent ? _self.masteredPercent : masteredPercent // ignore: cast_nullable_to_non_nullable
as int,flawlessCount: null == flawlessCount ? _self.flawlessCount : flawlessCount // ignore: cast_nullable_to_non_nullable
as int,flawlessPercent: null == flawlessPercent ? _self.flawlessPercent : flawlessPercent // ignore: cast_nullable_to_non_nullable
as int,weakCardsCount: null == weakCardsCount ? _self.weakCardsCount : weakCardsCount // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,activeDaysCount: null == activeDaysCount ? _self.activeDaysCount : activeDaysCount // ignore: cast_nullable_to_non_nullable
as int,avgAnswersPerDay: null == avgAnswersPerDay ? _self.avgAnswersPerDay : avgAnswersPerDay // ignore: cast_nullable_to_non_nullable
as double,weekActivity: null == weekActivity ? _self._weekActivity : weekActivity // ignore: cast_nullable_to_non_nullable
as List<bool>,groupsCount: null == groupsCount ? _self.groupsCount : groupsCount // ignore: cast_nullable_to_non_nullable
as int,testsCount: null == testsCount ? _self.testsCount : testsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
