// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monthly_budget_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MonthlyBudgetEntity {

 String get id;/// Year for this budget (e.g., 2025)
 int get year;/// Month for this budget (1-12)
 int get month;/// Total budget amount for the month
 double get totalBudget;/// Amount spent so far this month
 double get spentAmount;/// Daily budget allocation (totalBudget / days in month)
 double? get dailyBudget;/// Optional notes about this budget
 String? get notes;/// Creation timestamp
 DateTime? get createdAt;/// Last updated timestamp
 DateTime? get updatedAt;
/// Create a copy of MonthlyBudgetEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyBudgetEntityCopyWith<MonthlyBudgetEntity> get copyWith => _$MonthlyBudgetEntityCopyWithImpl<MonthlyBudgetEntity>(this as MonthlyBudgetEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyBudgetEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.totalBudget, totalBudget) || other.totalBudget == totalBudget)&&(identical(other.spentAmount, spentAmount) || other.spentAmount == spentAmount)&&(identical(other.dailyBudget, dailyBudget) || other.dailyBudget == dailyBudget)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,year,month,totalBudget,spentAmount,dailyBudget,notes,createdAt,updatedAt);

@override
String toString() {
  return 'MonthlyBudgetEntity(id: $id, year: $year, month: $month, totalBudget: $totalBudget, spentAmount: $spentAmount, dailyBudget: $dailyBudget, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MonthlyBudgetEntityCopyWith<$Res>  {
  factory $MonthlyBudgetEntityCopyWith(MonthlyBudgetEntity value, $Res Function(MonthlyBudgetEntity) _then) = _$MonthlyBudgetEntityCopyWithImpl;
@useResult
$Res call({
 String id, int year, int month, double totalBudget, double spentAmount, double? dailyBudget, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$MonthlyBudgetEntityCopyWithImpl<$Res>
    implements $MonthlyBudgetEntityCopyWith<$Res> {
  _$MonthlyBudgetEntityCopyWithImpl(this._self, this._then);

  final MonthlyBudgetEntity _self;
  final $Res Function(MonthlyBudgetEntity) _then;

/// Create a copy of MonthlyBudgetEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? year = null,Object? month = null,Object? totalBudget = null,Object? spentAmount = null,Object? dailyBudget = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,totalBudget: null == totalBudget ? _self.totalBudget : totalBudget // ignore: cast_nullable_to_non_nullable
as double,spentAmount: null == spentAmount ? _self.spentAmount : spentAmount // ignore: cast_nullable_to_non_nullable
as double,dailyBudget: freezed == dailyBudget ? _self.dailyBudget : dailyBudget // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlyBudgetEntity].
extension MonthlyBudgetEntityPatterns on MonthlyBudgetEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyBudgetEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyBudgetEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyBudgetEntity value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyBudgetEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyBudgetEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyBudgetEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int year,  int month,  double totalBudget,  double spentAmount,  double? dailyBudget,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyBudgetEntity() when $default != null:
return $default(_that.id,_that.year,_that.month,_that.totalBudget,_that.spentAmount,_that.dailyBudget,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int year,  int month,  double totalBudget,  double spentAmount,  double? dailyBudget,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MonthlyBudgetEntity():
return $default(_that.id,_that.year,_that.month,_that.totalBudget,_that.spentAmount,_that.dailyBudget,_that.notes,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int year,  int month,  double totalBudget,  double spentAmount,  double? dailyBudget,  String? notes,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyBudgetEntity() when $default != null:
return $default(_that.id,_that.year,_that.month,_that.totalBudget,_that.spentAmount,_that.dailyBudget,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _MonthlyBudgetEntity extends MonthlyBudgetEntity {
  const _MonthlyBudgetEntity({required this.id, required this.year, required this.month, required this.totalBudget, this.spentAmount = 0, this.dailyBudget, this.notes, this.createdAt, this.updatedAt}): super._();
  

@override final  String id;
/// Year for this budget (e.g., 2025)
@override final  int year;
/// Month for this budget (1-12)
@override final  int month;
/// Total budget amount for the month
@override final  double totalBudget;
/// Amount spent so far this month
@override@JsonKey() final  double spentAmount;
/// Daily budget allocation (totalBudget / days in month)
@override final  double? dailyBudget;
/// Optional notes about this budget
@override final  String? notes;
/// Creation timestamp
@override final  DateTime? createdAt;
/// Last updated timestamp
@override final  DateTime? updatedAt;

/// Create a copy of MonthlyBudgetEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyBudgetEntityCopyWith<_MonthlyBudgetEntity> get copyWith => __$MonthlyBudgetEntityCopyWithImpl<_MonthlyBudgetEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyBudgetEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.totalBudget, totalBudget) || other.totalBudget == totalBudget)&&(identical(other.spentAmount, spentAmount) || other.spentAmount == spentAmount)&&(identical(other.dailyBudget, dailyBudget) || other.dailyBudget == dailyBudget)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,year,month,totalBudget,spentAmount,dailyBudget,notes,createdAt,updatedAt);

@override
String toString() {
  return 'MonthlyBudgetEntity(id: $id, year: $year, month: $month, totalBudget: $totalBudget, spentAmount: $spentAmount, dailyBudget: $dailyBudget, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MonthlyBudgetEntityCopyWith<$Res> implements $MonthlyBudgetEntityCopyWith<$Res> {
  factory _$MonthlyBudgetEntityCopyWith(_MonthlyBudgetEntity value, $Res Function(_MonthlyBudgetEntity) _then) = __$MonthlyBudgetEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, int year, int month, double totalBudget, double spentAmount, double? dailyBudget, String? notes, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$MonthlyBudgetEntityCopyWithImpl<$Res>
    implements _$MonthlyBudgetEntityCopyWith<$Res> {
  __$MonthlyBudgetEntityCopyWithImpl(this._self, this._then);

  final _MonthlyBudgetEntity _self;
  final $Res Function(_MonthlyBudgetEntity) _then;

/// Create a copy of MonthlyBudgetEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? year = null,Object? month = null,Object? totalBudget = null,Object? spentAmount = null,Object? dailyBudget = freezed,Object? notes = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_MonthlyBudgetEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,totalBudget: null == totalBudget ? _self.totalBudget : totalBudget // ignore: cast_nullable_to_non_nullable
as double,spentAmount: null == spentAmount ? _self.spentAmount : spentAmount // ignore: cast_nullable_to_non_nullable
as double,dailyBudget: freezed == dailyBudget ? _self.dailyBudget : dailyBudget // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
