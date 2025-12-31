// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardState {

 bool get isLoading; List<AccountEntity> get accounts; List<TransactionEntity> get recentTransactions; List<TransactionEntity> get monthlyTransactions; List<CategoryEntity> get categories; List<InstallmentEntity> get activeInstallments; BudgetSummary get summary; String? get errorMessage;
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStateCopyWith<DashboardState> get copyWith => _$DashboardStateCopyWithImpl<DashboardState>(this as DashboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&const DeepCollectionEquality().equals(other.recentTransactions, recentTransactions)&&const DeepCollectionEquality().equals(other.monthlyTransactions, monthlyTransactions)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.activeInstallments, activeInstallments)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(accounts),const DeepCollectionEquality().hash(recentTransactions),const DeepCollectionEquality().hash(monthlyTransactions),const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(activeInstallments),summary,errorMessage);

@override
String toString() {
  return 'DashboardState(isLoading: $isLoading, accounts: $accounts, recentTransactions: $recentTransactions, monthlyTransactions: $monthlyTransactions, categories: $categories, activeInstallments: $activeInstallments, summary: $summary, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $DashboardStateCopyWith<$Res>  {
  factory $DashboardStateCopyWith(DashboardState value, $Res Function(DashboardState) _then) = _$DashboardStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<AccountEntity> accounts, List<TransactionEntity> recentTransactions, List<TransactionEntity> monthlyTransactions, List<CategoryEntity> categories, List<InstallmentEntity> activeInstallments, BudgetSummary summary, String? errorMessage
});


$BudgetSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$DashboardStateCopyWithImpl<$Res>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._self, this._then);

  final DashboardState _self;
  final $Res Function(DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? accounts = null,Object? recentTransactions = null,Object? monthlyTransactions = null,Object? categories = null,Object? activeInstallments = null,Object? summary = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountEntity>,recentTransactions: null == recentTransactions ? _self.recentTransactions : recentTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,monthlyTransactions: null == monthlyTransactions ? _self.monthlyTransactions : monthlyTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,activeInstallments: null == activeInstallments ? _self.activeInstallments : activeInstallments // ignore: cast_nullable_to_non_nullable
as List<InstallmentEntity>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as BudgetSummary,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetSummaryCopyWith<$Res> get summary {
  
  return $BudgetSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardState value)  $default,){
final _that = this;
switch (_that) {
case _DashboardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardState value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<AccountEntity> accounts,  List<TransactionEntity> recentTransactions,  List<TransactionEntity> monthlyTransactions,  List<CategoryEntity> categories,  List<InstallmentEntity> activeInstallments,  BudgetSummary summary,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.isLoading,_that.accounts,_that.recentTransactions,_that.monthlyTransactions,_that.categories,_that.activeInstallments,_that.summary,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<AccountEntity> accounts,  List<TransactionEntity> recentTransactions,  List<TransactionEntity> monthlyTransactions,  List<CategoryEntity> categories,  List<InstallmentEntity> activeInstallments,  BudgetSummary summary,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _DashboardState():
return $default(_that.isLoading,_that.accounts,_that.recentTransactions,_that.monthlyTransactions,_that.categories,_that.activeInstallments,_that.summary,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<AccountEntity> accounts,  List<TransactionEntity> recentTransactions,  List<TransactionEntity> monthlyTransactions,  List<CategoryEntity> categories,  List<InstallmentEntity> activeInstallments,  BudgetSummary summary,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.isLoading,_that.accounts,_that.recentTransactions,_that.monthlyTransactions,_that.categories,_that.activeInstallments,_that.summary,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardState implements DashboardState {
  const _DashboardState({this.isLoading = true, final  List<AccountEntity> accounts = const [], final  List<TransactionEntity> recentTransactions = const [], final  List<TransactionEntity> monthlyTransactions = const [], final  List<CategoryEntity> categories = const [], final  List<InstallmentEntity> activeInstallments = const [], this.summary = const BudgetSummary(), this.errorMessage}): _accounts = accounts,_recentTransactions = recentTransactions,_monthlyTransactions = monthlyTransactions,_categories = categories,_activeInstallments = activeInstallments;
  

@override@JsonKey() final  bool isLoading;
 final  List<AccountEntity> _accounts;
@override@JsonKey() List<AccountEntity> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

 final  List<TransactionEntity> _recentTransactions;
@override@JsonKey() List<TransactionEntity> get recentTransactions {
  if (_recentTransactions is EqualUnmodifiableListView) return _recentTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentTransactions);
}

 final  List<TransactionEntity> _monthlyTransactions;
@override@JsonKey() List<TransactionEntity> get monthlyTransactions {
  if (_monthlyTransactions is EqualUnmodifiableListView) return _monthlyTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthlyTransactions);
}

 final  List<CategoryEntity> _categories;
@override@JsonKey() List<CategoryEntity> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<InstallmentEntity> _activeInstallments;
@override@JsonKey() List<InstallmentEntity> get activeInstallments {
  if (_activeInstallments is EqualUnmodifiableListView) return _activeInstallments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeInstallments);
}

@override@JsonKey() final  BudgetSummary summary;
@override final  String? errorMessage;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStateCopyWith<_DashboardState> get copyWith => __$DashboardStateCopyWithImpl<_DashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&const DeepCollectionEquality().equals(other._recentTransactions, _recentTransactions)&&const DeepCollectionEquality().equals(other._monthlyTransactions, _monthlyTransactions)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._activeInstallments, _activeInstallments)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_recentTransactions),const DeepCollectionEquality().hash(_monthlyTransactions),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_activeInstallments),summary,errorMessage);

@override
String toString() {
  return 'DashboardState(isLoading: $isLoading, accounts: $accounts, recentTransactions: $recentTransactions, monthlyTransactions: $monthlyTransactions, categories: $categories, activeInstallments: $activeInstallments, summary: $summary, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$DashboardStateCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardStateCopyWith(_DashboardState value, $Res Function(_DashboardState) _then) = __$DashboardStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<AccountEntity> accounts, List<TransactionEntity> recentTransactions, List<TransactionEntity> monthlyTransactions, List<CategoryEntity> categories, List<InstallmentEntity> activeInstallments, BudgetSummary summary, String? errorMessage
});


@override $BudgetSummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$DashboardStateCopyWithImpl<$Res>
    implements _$DashboardStateCopyWith<$Res> {
  __$DashboardStateCopyWithImpl(this._self, this._then);

  final _DashboardState _self;
  final $Res Function(_DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? accounts = null,Object? recentTransactions = null,Object? monthlyTransactions = null,Object? categories = null,Object? activeInstallments = null,Object? summary = null,Object? errorMessage = freezed,}) {
  return _then(_DashboardState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountEntity>,recentTransactions: null == recentTransactions ? _self._recentTransactions : recentTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,monthlyTransactions: null == monthlyTransactions ? _self._monthlyTransactions : monthlyTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,activeInstallments: null == activeInstallments ? _self._activeInstallments : activeInstallments // ignore: cast_nullable_to_non_nullable
as List<InstallmentEntity>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as BudgetSummary,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BudgetSummaryCopyWith<$Res> get summary {
  
  return $BudgetSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

// dart format on
