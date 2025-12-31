// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BudgetSummary {

/// Total balance across all accounts (excluding credit cards)
 double get totalBalance;/// Total credit card debt
 double get totalDebt;/// Total available credit
 double get totalAvailableCredit;/// Total income this month
 double get monthlyIncome;/// Total expenses this month
 double get monthlyExpenses;/// Net savings this month (income - expenses)
 double get monthlySavings;/// Total monthly installment payments
 double get monthlyInstallments;/// Number of accounts over budget threshold
 int get accountsOverThreshold;/// Number of credit cards over threshold
 int get creditCardsOverThreshold;
/// Create a copy of BudgetSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BudgetSummaryCopyWith<BudgetSummary> get copyWith => _$BudgetSummaryCopyWithImpl<BudgetSummary>(this as BudgetSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BudgetSummary&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&(identical(other.totalDebt, totalDebt) || other.totalDebt == totalDebt)&&(identical(other.totalAvailableCredit, totalAvailableCredit) || other.totalAvailableCredit == totalAvailableCredit)&&(identical(other.monthlyIncome, monthlyIncome) || other.monthlyIncome == monthlyIncome)&&(identical(other.monthlyExpenses, monthlyExpenses) || other.monthlyExpenses == monthlyExpenses)&&(identical(other.monthlySavings, monthlySavings) || other.monthlySavings == monthlySavings)&&(identical(other.monthlyInstallments, monthlyInstallments) || other.monthlyInstallments == monthlyInstallments)&&(identical(other.accountsOverThreshold, accountsOverThreshold) || other.accountsOverThreshold == accountsOverThreshold)&&(identical(other.creditCardsOverThreshold, creditCardsOverThreshold) || other.creditCardsOverThreshold == creditCardsOverThreshold));
}


@override
int get hashCode => Object.hash(runtimeType,totalBalance,totalDebt,totalAvailableCredit,monthlyIncome,monthlyExpenses,monthlySavings,monthlyInstallments,accountsOverThreshold,creditCardsOverThreshold);

@override
String toString() {
  return 'BudgetSummary(totalBalance: $totalBalance, totalDebt: $totalDebt, totalAvailableCredit: $totalAvailableCredit, monthlyIncome: $monthlyIncome, monthlyExpenses: $monthlyExpenses, monthlySavings: $monthlySavings, monthlyInstallments: $monthlyInstallments, accountsOverThreshold: $accountsOverThreshold, creditCardsOverThreshold: $creditCardsOverThreshold)';
}


}

/// @nodoc
abstract mixin class $BudgetSummaryCopyWith<$Res>  {
  factory $BudgetSummaryCopyWith(BudgetSummary value, $Res Function(BudgetSummary) _then) = _$BudgetSummaryCopyWithImpl;
@useResult
$Res call({
 double totalBalance, double totalDebt, double totalAvailableCredit, double monthlyIncome, double monthlyExpenses, double monthlySavings, double monthlyInstallments, int accountsOverThreshold, int creditCardsOverThreshold
});




}
/// @nodoc
class _$BudgetSummaryCopyWithImpl<$Res>
    implements $BudgetSummaryCopyWith<$Res> {
  _$BudgetSummaryCopyWithImpl(this._self, this._then);

  final BudgetSummary _self;
  final $Res Function(BudgetSummary) _then;

/// Create a copy of BudgetSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalBalance = null,Object? totalDebt = null,Object? totalAvailableCredit = null,Object? monthlyIncome = null,Object? monthlyExpenses = null,Object? monthlySavings = null,Object? monthlyInstallments = null,Object? accountsOverThreshold = null,Object? creditCardsOverThreshold = null,}) {
  return _then(_self.copyWith(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,totalDebt: null == totalDebt ? _self.totalDebt : totalDebt // ignore: cast_nullable_to_non_nullable
as double,totalAvailableCredit: null == totalAvailableCredit ? _self.totalAvailableCredit : totalAvailableCredit // ignore: cast_nullable_to_non_nullable
as double,monthlyIncome: null == monthlyIncome ? _self.monthlyIncome : monthlyIncome // ignore: cast_nullable_to_non_nullable
as double,monthlyExpenses: null == monthlyExpenses ? _self.monthlyExpenses : monthlyExpenses // ignore: cast_nullable_to_non_nullable
as double,monthlySavings: null == monthlySavings ? _self.monthlySavings : monthlySavings // ignore: cast_nullable_to_non_nullable
as double,monthlyInstallments: null == monthlyInstallments ? _self.monthlyInstallments : monthlyInstallments // ignore: cast_nullable_to_non_nullable
as double,accountsOverThreshold: null == accountsOverThreshold ? _self.accountsOverThreshold : accountsOverThreshold // ignore: cast_nullable_to_non_nullable
as int,creditCardsOverThreshold: null == creditCardsOverThreshold ? _self.creditCardsOverThreshold : creditCardsOverThreshold // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BudgetSummary].
extension BudgetSummaryPatterns on BudgetSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BudgetSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BudgetSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BudgetSummary value)  $default,){
final _that = this;
switch (_that) {
case _BudgetSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BudgetSummary value)?  $default,){
final _that = this;
switch (_that) {
case _BudgetSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalBalance,  double totalDebt,  double totalAvailableCredit,  double monthlyIncome,  double monthlyExpenses,  double monthlySavings,  double monthlyInstallments,  int accountsOverThreshold,  int creditCardsOverThreshold)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BudgetSummary() when $default != null:
return $default(_that.totalBalance,_that.totalDebt,_that.totalAvailableCredit,_that.monthlyIncome,_that.monthlyExpenses,_that.monthlySavings,_that.monthlyInstallments,_that.accountsOverThreshold,_that.creditCardsOverThreshold);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalBalance,  double totalDebt,  double totalAvailableCredit,  double monthlyIncome,  double monthlyExpenses,  double monthlySavings,  double monthlyInstallments,  int accountsOverThreshold,  int creditCardsOverThreshold)  $default,) {final _that = this;
switch (_that) {
case _BudgetSummary():
return $default(_that.totalBalance,_that.totalDebt,_that.totalAvailableCredit,_that.monthlyIncome,_that.monthlyExpenses,_that.monthlySavings,_that.monthlyInstallments,_that.accountsOverThreshold,_that.creditCardsOverThreshold);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalBalance,  double totalDebt,  double totalAvailableCredit,  double monthlyIncome,  double monthlyExpenses,  double monthlySavings,  double monthlyInstallments,  int accountsOverThreshold,  int creditCardsOverThreshold)?  $default,) {final _that = this;
switch (_that) {
case _BudgetSummary() when $default != null:
return $default(_that.totalBalance,_that.totalDebt,_that.totalAvailableCredit,_that.monthlyIncome,_that.monthlyExpenses,_that.monthlySavings,_that.monthlyInstallments,_that.accountsOverThreshold,_that.creditCardsOverThreshold);case _:
  return null;

}
}

}

/// @nodoc


class _BudgetSummary extends BudgetSummary {
  const _BudgetSummary({this.totalBalance = 0, this.totalDebt = 0, this.totalAvailableCredit = 0, this.monthlyIncome = 0, this.monthlyExpenses = 0, this.monthlySavings = 0, this.monthlyInstallments = 0, this.accountsOverThreshold = 0, this.creditCardsOverThreshold = 0}): super._();
  

/// Total balance across all accounts (excluding credit cards)
@override@JsonKey() final  double totalBalance;
/// Total credit card debt
@override@JsonKey() final  double totalDebt;
/// Total available credit
@override@JsonKey() final  double totalAvailableCredit;
/// Total income this month
@override@JsonKey() final  double monthlyIncome;
/// Total expenses this month
@override@JsonKey() final  double monthlyExpenses;
/// Net savings this month (income - expenses)
@override@JsonKey() final  double monthlySavings;
/// Total monthly installment payments
@override@JsonKey() final  double monthlyInstallments;
/// Number of accounts over budget threshold
@override@JsonKey() final  int accountsOverThreshold;
/// Number of credit cards over threshold
@override@JsonKey() final  int creditCardsOverThreshold;

/// Create a copy of BudgetSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BudgetSummaryCopyWith<_BudgetSummary> get copyWith => __$BudgetSummaryCopyWithImpl<_BudgetSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BudgetSummary&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&(identical(other.totalDebt, totalDebt) || other.totalDebt == totalDebt)&&(identical(other.totalAvailableCredit, totalAvailableCredit) || other.totalAvailableCredit == totalAvailableCredit)&&(identical(other.monthlyIncome, monthlyIncome) || other.monthlyIncome == monthlyIncome)&&(identical(other.monthlyExpenses, monthlyExpenses) || other.monthlyExpenses == monthlyExpenses)&&(identical(other.monthlySavings, monthlySavings) || other.monthlySavings == monthlySavings)&&(identical(other.monthlyInstallments, monthlyInstallments) || other.monthlyInstallments == monthlyInstallments)&&(identical(other.accountsOverThreshold, accountsOverThreshold) || other.accountsOverThreshold == accountsOverThreshold)&&(identical(other.creditCardsOverThreshold, creditCardsOverThreshold) || other.creditCardsOverThreshold == creditCardsOverThreshold));
}


@override
int get hashCode => Object.hash(runtimeType,totalBalance,totalDebt,totalAvailableCredit,monthlyIncome,monthlyExpenses,monthlySavings,monthlyInstallments,accountsOverThreshold,creditCardsOverThreshold);

@override
String toString() {
  return 'BudgetSummary(totalBalance: $totalBalance, totalDebt: $totalDebt, totalAvailableCredit: $totalAvailableCredit, monthlyIncome: $monthlyIncome, monthlyExpenses: $monthlyExpenses, monthlySavings: $monthlySavings, monthlyInstallments: $monthlyInstallments, accountsOverThreshold: $accountsOverThreshold, creditCardsOverThreshold: $creditCardsOverThreshold)';
}


}

/// @nodoc
abstract mixin class _$BudgetSummaryCopyWith<$Res> implements $BudgetSummaryCopyWith<$Res> {
  factory _$BudgetSummaryCopyWith(_BudgetSummary value, $Res Function(_BudgetSummary) _then) = __$BudgetSummaryCopyWithImpl;
@override @useResult
$Res call({
 double totalBalance, double totalDebt, double totalAvailableCredit, double monthlyIncome, double monthlyExpenses, double monthlySavings, double monthlyInstallments, int accountsOverThreshold, int creditCardsOverThreshold
});




}
/// @nodoc
class __$BudgetSummaryCopyWithImpl<$Res>
    implements _$BudgetSummaryCopyWith<$Res> {
  __$BudgetSummaryCopyWithImpl(this._self, this._then);

  final _BudgetSummary _self;
  final $Res Function(_BudgetSummary) _then;

/// Create a copy of BudgetSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalBalance = null,Object? totalDebt = null,Object? totalAvailableCredit = null,Object? monthlyIncome = null,Object? monthlyExpenses = null,Object? monthlySavings = null,Object? monthlyInstallments = null,Object? accountsOverThreshold = null,Object? creditCardsOverThreshold = null,}) {
  return _then(_BudgetSummary(
totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,totalDebt: null == totalDebt ? _self.totalDebt : totalDebt // ignore: cast_nullable_to_non_nullable
as double,totalAvailableCredit: null == totalAvailableCredit ? _self.totalAvailableCredit : totalAvailableCredit // ignore: cast_nullable_to_non_nullable
as double,monthlyIncome: null == monthlyIncome ? _self.monthlyIncome : monthlyIncome // ignore: cast_nullable_to_non_nullable
as double,monthlyExpenses: null == monthlyExpenses ? _self.monthlyExpenses : monthlyExpenses // ignore: cast_nullable_to_non_nullable
as double,monthlySavings: null == monthlySavings ? _self.monthlySavings : monthlySavings // ignore: cast_nullable_to_non_nullable
as double,monthlyInstallments: null == monthlyInstallments ? _self.monthlyInstallments : monthlyInstallments // ignore: cast_nullable_to_non_nullable
as double,accountsOverThreshold: null == accountsOverThreshold ? _self.accountsOverThreshold : accountsOverThreshold // ignore: cast_nullable_to_non_nullable
as int,creditCardsOverThreshold: null == creditCardsOverThreshold ? _self.creditCardsOverThreshold : creditCardsOverThreshold // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
