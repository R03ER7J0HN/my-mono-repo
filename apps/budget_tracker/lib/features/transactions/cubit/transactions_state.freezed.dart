// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transactions_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionsState {

 List<TransactionEntity> get transactions; List<AccountEntity> get accounts; List<CategoryEntity> get categories; bool get isLoading; TransactionViewMode get viewMode;/// Selected account type filter. If null, shows all account types.
 AccountType? get selectedAccountType; String? get error; DateTime? get selectedDate;
/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionsStateCopyWith<TransactionsState> get copyWith => _$TransactionsStateCopyWithImpl<TransactionsState>(this as TransactionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionsState&&const DeepCollectionEquality().equals(other.transactions, transactions)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.viewMode, viewMode) || other.viewMode == viewMode)&&(identical(other.selectedAccountType, selectedAccountType) || other.selectedAccountType == selectedAccountType)&&(identical(other.error, error) || other.error == error)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(transactions),const DeepCollectionEquality().hash(accounts),const DeepCollectionEquality().hash(categories),isLoading,viewMode,selectedAccountType,error,selectedDate);

@override
String toString() {
  return 'TransactionsState(transactions: $transactions, accounts: $accounts, categories: $categories, isLoading: $isLoading, viewMode: $viewMode, selectedAccountType: $selectedAccountType, error: $error, selectedDate: $selectedDate)';
}


}

/// @nodoc
abstract mixin class $TransactionsStateCopyWith<$Res>  {
  factory $TransactionsStateCopyWith(TransactionsState value, $Res Function(TransactionsState) _then) = _$TransactionsStateCopyWithImpl;
@useResult
$Res call({
 List<TransactionEntity> transactions, List<AccountEntity> accounts, List<CategoryEntity> categories, bool isLoading, TransactionViewMode viewMode, AccountType? selectedAccountType, String? error, DateTime? selectedDate
});




}
/// @nodoc
class _$TransactionsStateCopyWithImpl<$Res>
    implements $TransactionsStateCopyWith<$Res> {
  _$TransactionsStateCopyWithImpl(this._self, this._then);

  final TransactionsState _self;
  final $Res Function(TransactionsState) _then;

/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactions = null,Object? accounts = null,Object? categories = null,Object? isLoading = null,Object? viewMode = null,Object? selectedAccountType = freezed,Object? error = freezed,Object? selectedDate = freezed,}) {
  return _then(_self.copyWith(
transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountEntity>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
as TransactionViewMode,selectedAccountType: freezed == selectedAccountType ? _self.selectedAccountType : selectedAccountType // ignore: cast_nullable_to_non_nullable
as AccountType?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionsState].
extension TransactionsStatePatterns on TransactionsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionsState value)  $default,){
final _that = this;
switch (_that) {
case _TransactionsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionsState value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TransactionEntity> transactions,  List<AccountEntity> accounts,  List<CategoryEntity> categories,  bool isLoading,  TransactionViewMode viewMode,  AccountType? selectedAccountType,  String? error,  DateTime? selectedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionsState() when $default != null:
return $default(_that.transactions,_that.accounts,_that.categories,_that.isLoading,_that.viewMode,_that.selectedAccountType,_that.error,_that.selectedDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TransactionEntity> transactions,  List<AccountEntity> accounts,  List<CategoryEntity> categories,  bool isLoading,  TransactionViewMode viewMode,  AccountType? selectedAccountType,  String? error,  DateTime? selectedDate)  $default,) {final _that = this;
switch (_that) {
case _TransactionsState():
return $default(_that.transactions,_that.accounts,_that.categories,_that.isLoading,_that.viewMode,_that.selectedAccountType,_that.error,_that.selectedDate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TransactionEntity> transactions,  List<AccountEntity> accounts,  List<CategoryEntity> categories,  bool isLoading,  TransactionViewMode viewMode,  AccountType? selectedAccountType,  String? error,  DateTime? selectedDate)?  $default,) {final _that = this;
switch (_that) {
case _TransactionsState() when $default != null:
return $default(_that.transactions,_that.accounts,_that.categories,_that.isLoading,_that.viewMode,_that.selectedAccountType,_that.error,_that.selectedDate);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionsState extends TransactionsState {
  const _TransactionsState({final  List<TransactionEntity> transactions = const [], final  List<AccountEntity> accounts = const [], final  List<CategoryEntity> categories = const [], this.isLoading = true, this.viewMode = TransactionViewMode.daily, this.selectedAccountType, this.error, this.selectedDate}): _transactions = transactions,_accounts = accounts,_categories = categories,super._();
  

 final  List<TransactionEntity> _transactions;
@override@JsonKey() List<TransactionEntity> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

 final  List<AccountEntity> _accounts;
@override@JsonKey() List<AccountEntity> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

 final  List<CategoryEntity> _categories;
@override@JsonKey() List<CategoryEntity> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  TransactionViewMode viewMode;
/// Selected account type filter. If null, shows all account types.
@override final  AccountType? selectedAccountType;
@override final  String? error;
@override final  DateTime? selectedDate;

/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionsStateCopyWith<_TransactionsState> get copyWith => __$TransactionsStateCopyWithImpl<_TransactionsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionsState&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.viewMode, viewMode) || other.viewMode == viewMode)&&(identical(other.selectedAccountType, selectedAccountType) || other.selectedAccountType == selectedAccountType)&&(identical(other.error, error) || other.error == error)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions),const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_categories),isLoading,viewMode,selectedAccountType,error,selectedDate);

@override
String toString() {
  return 'TransactionsState(transactions: $transactions, accounts: $accounts, categories: $categories, isLoading: $isLoading, viewMode: $viewMode, selectedAccountType: $selectedAccountType, error: $error, selectedDate: $selectedDate)';
}


}

/// @nodoc
abstract mixin class _$TransactionsStateCopyWith<$Res> implements $TransactionsStateCopyWith<$Res> {
  factory _$TransactionsStateCopyWith(_TransactionsState value, $Res Function(_TransactionsState) _then) = __$TransactionsStateCopyWithImpl;
@override @useResult
$Res call({
 List<TransactionEntity> transactions, List<AccountEntity> accounts, List<CategoryEntity> categories, bool isLoading, TransactionViewMode viewMode, AccountType? selectedAccountType, String? error, DateTime? selectedDate
});




}
/// @nodoc
class __$TransactionsStateCopyWithImpl<$Res>
    implements _$TransactionsStateCopyWith<$Res> {
  __$TransactionsStateCopyWithImpl(this._self, this._then);

  final _TransactionsState _self;
  final $Res Function(_TransactionsState) _then;

/// Create a copy of TransactionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactions = null,Object? accounts = null,Object? categories = null,Object? isLoading = null,Object? viewMode = null,Object? selectedAccountType = freezed,Object? error = freezed,Object? selectedDate = freezed,}) {
  return _then(_TransactionsState(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountEntity>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
as TransactionViewMode,selectedAccountType: freezed == selectedAccountType ? _self.selectedAccountType : selectedAccountType // ignore: cast_nullable_to_non_nullable
as AccountType?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
