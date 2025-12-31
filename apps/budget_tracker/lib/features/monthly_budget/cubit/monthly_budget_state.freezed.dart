// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monthly_budget_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MonthlyBudgetState {

 MonthlyBudgetEntity? get currentBudget; List<MonthlyBudgetEntity> get budgetHistory; List<TransactionEntity> get monthlyTransactions; bool get isLoading; bool get isSaving; String? get error;
/// Create a copy of MonthlyBudgetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyBudgetStateCopyWith<MonthlyBudgetState> get copyWith => _$MonthlyBudgetStateCopyWithImpl<MonthlyBudgetState>(this as MonthlyBudgetState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyBudgetState&&(identical(other.currentBudget, currentBudget) || other.currentBudget == currentBudget)&&const DeepCollectionEquality().equals(other.budgetHistory, budgetHistory)&&const DeepCollectionEquality().equals(other.monthlyTransactions, monthlyTransactions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,currentBudget,const DeepCollectionEquality().hash(budgetHistory),const DeepCollectionEquality().hash(monthlyTransactions),isLoading,isSaving,error);

@override
String toString() {
  return 'MonthlyBudgetState(currentBudget: $currentBudget, budgetHistory: $budgetHistory, monthlyTransactions: $monthlyTransactions, isLoading: $isLoading, isSaving: $isSaving, error: $error)';
}


}

/// @nodoc
abstract mixin class $MonthlyBudgetStateCopyWith<$Res>  {
  factory $MonthlyBudgetStateCopyWith(MonthlyBudgetState value, $Res Function(MonthlyBudgetState) _then) = _$MonthlyBudgetStateCopyWithImpl;
@useResult
$Res call({
 MonthlyBudgetEntity? currentBudget, List<MonthlyBudgetEntity> budgetHistory, List<TransactionEntity> monthlyTransactions, bool isLoading, bool isSaving, String? error
});


$MonthlyBudgetEntityCopyWith<$Res>? get currentBudget;

}
/// @nodoc
class _$MonthlyBudgetStateCopyWithImpl<$Res>
    implements $MonthlyBudgetStateCopyWith<$Res> {
  _$MonthlyBudgetStateCopyWithImpl(this._self, this._then);

  final MonthlyBudgetState _self;
  final $Res Function(MonthlyBudgetState) _then;

/// Create a copy of MonthlyBudgetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentBudget = freezed,Object? budgetHistory = null,Object? monthlyTransactions = null,Object? isLoading = null,Object? isSaving = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
currentBudget: freezed == currentBudget ? _self.currentBudget : currentBudget // ignore: cast_nullable_to_non_nullable
as MonthlyBudgetEntity?,budgetHistory: null == budgetHistory ? _self.budgetHistory : budgetHistory // ignore: cast_nullable_to_non_nullable
as List<MonthlyBudgetEntity>,monthlyTransactions: null == monthlyTransactions ? _self.monthlyTransactions : monthlyTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MonthlyBudgetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthlyBudgetEntityCopyWith<$Res>? get currentBudget {
    if (_self.currentBudget == null) {
    return null;
  }

  return $MonthlyBudgetEntityCopyWith<$Res>(_self.currentBudget!, (value) {
    return _then(_self.copyWith(currentBudget: value));
  });
}
}


/// Adds pattern-matching-related methods to [MonthlyBudgetState].
extension MonthlyBudgetStatePatterns on MonthlyBudgetState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyBudgetState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyBudgetState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyBudgetState value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyBudgetState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyBudgetState value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyBudgetState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MonthlyBudgetEntity? currentBudget,  List<MonthlyBudgetEntity> budgetHistory,  List<TransactionEntity> monthlyTransactions,  bool isLoading,  bool isSaving,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyBudgetState() when $default != null:
return $default(_that.currentBudget,_that.budgetHistory,_that.monthlyTransactions,_that.isLoading,_that.isSaving,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MonthlyBudgetEntity? currentBudget,  List<MonthlyBudgetEntity> budgetHistory,  List<TransactionEntity> monthlyTransactions,  bool isLoading,  bool isSaving,  String? error)  $default,) {final _that = this;
switch (_that) {
case _MonthlyBudgetState():
return $default(_that.currentBudget,_that.budgetHistory,_that.monthlyTransactions,_that.isLoading,_that.isSaving,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MonthlyBudgetEntity? currentBudget,  List<MonthlyBudgetEntity> budgetHistory,  List<TransactionEntity> monthlyTransactions,  bool isLoading,  bool isSaving,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyBudgetState() when $default != null:
return $default(_that.currentBudget,_that.budgetHistory,_that.monthlyTransactions,_that.isLoading,_that.isSaving,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _MonthlyBudgetState extends MonthlyBudgetState {
  const _MonthlyBudgetState({this.currentBudget, final  List<MonthlyBudgetEntity> budgetHistory = const [], final  List<TransactionEntity> monthlyTransactions = const [], this.isLoading = false, this.isSaving = false, this.error}): _budgetHistory = budgetHistory,_monthlyTransactions = monthlyTransactions,super._();
  

@override final  MonthlyBudgetEntity? currentBudget;
 final  List<MonthlyBudgetEntity> _budgetHistory;
@override@JsonKey() List<MonthlyBudgetEntity> get budgetHistory {
  if (_budgetHistory is EqualUnmodifiableListView) return _budgetHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_budgetHistory);
}

 final  List<TransactionEntity> _monthlyTransactions;
@override@JsonKey() List<TransactionEntity> get monthlyTransactions {
  if (_monthlyTransactions is EqualUnmodifiableListView) return _monthlyTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthlyTransactions);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override final  String? error;

/// Create a copy of MonthlyBudgetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyBudgetStateCopyWith<_MonthlyBudgetState> get copyWith => __$MonthlyBudgetStateCopyWithImpl<_MonthlyBudgetState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyBudgetState&&(identical(other.currentBudget, currentBudget) || other.currentBudget == currentBudget)&&const DeepCollectionEquality().equals(other._budgetHistory, _budgetHistory)&&const DeepCollectionEquality().equals(other._monthlyTransactions, _monthlyTransactions)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,currentBudget,const DeepCollectionEquality().hash(_budgetHistory),const DeepCollectionEquality().hash(_monthlyTransactions),isLoading,isSaving,error);

@override
String toString() {
  return 'MonthlyBudgetState(currentBudget: $currentBudget, budgetHistory: $budgetHistory, monthlyTransactions: $monthlyTransactions, isLoading: $isLoading, isSaving: $isSaving, error: $error)';
}


}

/// @nodoc
abstract mixin class _$MonthlyBudgetStateCopyWith<$Res> implements $MonthlyBudgetStateCopyWith<$Res> {
  factory _$MonthlyBudgetStateCopyWith(_MonthlyBudgetState value, $Res Function(_MonthlyBudgetState) _then) = __$MonthlyBudgetStateCopyWithImpl;
@override @useResult
$Res call({
 MonthlyBudgetEntity? currentBudget, List<MonthlyBudgetEntity> budgetHistory, List<TransactionEntity> monthlyTransactions, bool isLoading, bool isSaving, String? error
});


@override $MonthlyBudgetEntityCopyWith<$Res>? get currentBudget;

}
/// @nodoc
class __$MonthlyBudgetStateCopyWithImpl<$Res>
    implements _$MonthlyBudgetStateCopyWith<$Res> {
  __$MonthlyBudgetStateCopyWithImpl(this._self, this._then);

  final _MonthlyBudgetState _self;
  final $Res Function(_MonthlyBudgetState) _then;

/// Create a copy of MonthlyBudgetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentBudget = freezed,Object? budgetHistory = null,Object? monthlyTransactions = null,Object? isLoading = null,Object? isSaving = null,Object? error = freezed,}) {
  return _then(_MonthlyBudgetState(
currentBudget: freezed == currentBudget ? _self.currentBudget : currentBudget // ignore: cast_nullable_to_non_nullable
as MonthlyBudgetEntity?,budgetHistory: null == budgetHistory ? _self._budgetHistory : budgetHistory // ignore: cast_nullable_to_non_nullable
as List<MonthlyBudgetEntity>,monthlyTransactions: null == monthlyTransactions ? _self._monthlyTransactions : monthlyTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MonthlyBudgetState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MonthlyBudgetEntityCopyWith<$Res>? get currentBudget {
    if (_self.currentBudget == null) {
    return null;
  }

  return $MonthlyBudgetEntityCopyWith<$Res>(_self.currentBudget!, (value) {
    return _then(_self.copyWith(currentBudget: value));
  });
}
}

// dart format on
