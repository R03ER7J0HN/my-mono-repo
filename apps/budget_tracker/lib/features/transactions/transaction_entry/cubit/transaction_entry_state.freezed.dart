// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_entry_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionEntryState {

 TransactionType get type; double get amount; String get description; String? get categoryId; String? get accountId; String? get toAccountId; DateTime? get date; List<AccountEntity> get accounts; List<CategoryEntity> get categories; bool get isSaving; bool get isValid; String? get error; TransactionEntity? get existingTransaction;
/// Create a copy of TransactionEntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionEntryStateCopyWith<TransactionEntryState> get copyWith => _$TransactionEntryStateCopyWithImpl<TransactionEntryState>(this as TransactionEntryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionEntryState&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.error, error) || other.error == error)&&(identical(other.existingTransaction, existingTransaction) || other.existingTransaction == existingTransaction));
}


@override
int get hashCode => Object.hash(runtimeType,type,amount,description,categoryId,accountId,toAccountId,date,const DeepCollectionEquality().hash(accounts),const DeepCollectionEquality().hash(categories),isSaving,isValid,error,existingTransaction);

@override
String toString() {
  return 'TransactionEntryState(type: $type, amount: $amount, description: $description, categoryId: $categoryId, accountId: $accountId, toAccountId: $toAccountId, date: $date, accounts: $accounts, categories: $categories, isSaving: $isSaving, isValid: $isValid, error: $error, existingTransaction: $existingTransaction)';
}


}

/// @nodoc
abstract mixin class $TransactionEntryStateCopyWith<$Res>  {
  factory $TransactionEntryStateCopyWith(TransactionEntryState value, $Res Function(TransactionEntryState) _then) = _$TransactionEntryStateCopyWithImpl;
@useResult
$Res call({
 TransactionType type, double amount, String description, String? categoryId, String? accountId, String? toAccountId, DateTime? date, List<AccountEntity> accounts, List<CategoryEntity> categories, bool isSaving, bool isValid, String? error, TransactionEntity? existingTransaction
});


$TransactionEntityCopyWith<$Res>? get existingTransaction;

}
/// @nodoc
class _$TransactionEntryStateCopyWithImpl<$Res>
    implements $TransactionEntryStateCopyWith<$Res> {
  _$TransactionEntryStateCopyWithImpl(this._self, this._then);

  final TransactionEntryState _self;
  final $Res Function(TransactionEntryState) _then;

/// Create a copy of TransactionEntryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? amount = null,Object? description = null,Object? categoryId = freezed,Object? accountId = freezed,Object? toAccountId = freezed,Object? date = freezed,Object? accounts = null,Object? categories = null,Object? isSaving = null,Object? isValid = null,Object? error = freezed,Object? existingTransaction = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountEntity>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,existingTransaction: freezed == existingTransaction ? _self.existingTransaction : existingTransaction // ignore: cast_nullable_to_non_nullable
as TransactionEntity?,
  ));
}
/// Create a copy of TransactionEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionEntityCopyWith<$Res>? get existingTransaction {
    if (_self.existingTransaction == null) {
    return null;
  }

  return $TransactionEntityCopyWith<$Res>(_self.existingTransaction!, (value) {
    return _then(_self.copyWith(existingTransaction: value));
  });
}
}


/// Adds pattern-matching-related methods to [TransactionEntryState].
extension TransactionEntryStatePatterns on TransactionEntryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionEntryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionEntryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionEntryState value)  $default,){
final _that = this;
switch (_that) {
case _TransactionEntryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionEntryState value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionEntryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransactionType type,  double amount,  String description,  String? categoryId,  String? accountId,  String? toAccountId,  DateTime? date,  List<AccountEntity> accounts,  List<CategoryEntity> categories,  bool isSaving,  bool isValid,  String? error,  TransactionEntity? existingTransaction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionEntryState() when $default != null:
return $default(_that.type,_that.amount,_that.description,_that.categoryId,_that.accountId,_that.toAccountId,_that.date,_that.accounts,_that.categories,_that.isSaving,_that.isValid,_that.error,_that.existingTransaction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransactionType type,  double amount,  String description,  String? categoryId,  String? accountId,  String? toAccountId,  DateTime? date,  List<AccountEntity> accounts,  List<CategoryEntity> categories,  bool isSaving,  bool isValid,  String? error,  TransactionEntity? existingTransaction)  $default,) {final _that = this;
switch (_that) {
case _TransactionEntryState():
return $default(_that.type,_that.amount,_that.description,_that.categoryId,_that.accountId,_that.toAccountId,_that.date,_that.accounts,_that.categories,_that.isSaving,_that.isValid,_that.error,_that.existingTransaction);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransactionType type,  double amount,  String description,  String? categoryId,  String? accountId,  String? toAccountId,  DateTime? date,  List<AccountEntity> accounts,  List<CategoryEntity> categories,  bool isSaving,  bool isValid,  String? error,  TransactionEntity? existingTransaction)?  $default,) {final _that = this;
switch (_that) {
case _TransactionEntryState() when $default != null:
return $default(_that.type,_that.amount,_that.description,_that.categoryId,_that.accountId,_that.toAccountId,_that.date,_that.accounts,_that.categories,_that.isSaving,_that.isValid,_that.error,_that.existingTransaction);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionEntryState extends TransactionEntryState {
  const _TransactionEntryState({this.type = TransactionType.expense, this.amount = 0, this.description = '', this.categoryId, this.accountId, this.toAccountId, this.date, final  List<AccountEntity> accounts = const [], final  List<CategoryEntity> categories = const [], this.isSaving = false, this.isValid = false, this.error, this.existingTransaction}): _accounts = accounts,_categories = categories,super._();
  

@override@JsonKey() final  TransactionType type;
@override@JsonKey() final  double amount;
@override@JsonKey() final  String description;
@override final  String? categoryId;
@override final  String? accountId;
@override final  String? toAccountId;
@override final  DateTime? date;
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

@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isValid;
@override final  String? error;
@override final  TransactionEntity? existingTransaction;

/// Create a copy of TransactionEntryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionEntryStateCopyWith<_TransactionEntryState> get copyWith => __$TransactionEntryStateCopyWithImpl<_TransactionEntryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionEntryState&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.error, error) || other.error == error)&&(identical(other.existingTransaction, existingTransaction) || other.existingTransaction == existingTransaction));
}


@override
int get hashCode => Object.hash(runtimeType,type,amount,description,categoryId,accountId,toAccountId,date,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_categories),isSaving,isValid,error,existingTransaction);

@override
String toString() {
  return 'TransactionEntryState(type: $type, amount: $amount, description: $description, categoryId: $categoryId, accountId: $accountId, toAccountId: $toAccountId, date: $date, accounts: $accounts, categories: $categories, isSaving: $isSaving, isValid: $isValid, error: $error, existingTransaction: $existingTransaction)';
}


}

/// @nodoc
abstract mixin class _$TransactionEntryStateCopyWith<$Res> implements $TransactionEntryStateCopyWith<$Res> {
  factory _$TransactionEntryStateCopyWith(_TransactionEntryState value, $Res Function(_TransactionEntryState) _then) = __$TransactionEntryStateCopyWithImpl;
@override @useResult
$Res call({
 TransactionType type, double amount, String description, String? categoryId, String? accountId, String? toAccountId, DateTime? date, List<AccountEntity> accounts, List<CategoryEntity> categories, bool isSaving, bool isValid, String? error, TransactionEntity? existingTransaction
});


@override $TransactionEntityCopyWith<$Res>? get existingTransaction;

}
/// @nodoc
class __$TransactionEntryStateCopyWithImpl<$Res>
    implements _$TransactionEntryStateCopyWith<$Res> {
  __$TransactionEntryStateCopyWithImpl(this._self, this._then);

  final _TransactionEntryState _self;
  final $Res Function(_TransactionEntryState) _then;

/// Create a copy of TransactionEntryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? amount = null,Object? description = null,Object? categoryId = freezed,Object? accountId = freezed,Object? toAccountId = freezed,Object? date = freezed,Object? accounts = null,Object? categories = null,Object? isSaving = null,Object? isValid = null,Object? error = freezed,Object? existingTransaction = freezed,}) {
  return _then(_TransactionEntryState(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountEntity>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryEntity>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,existingTransaction: freezed == existingTransaction ? _self.existingTransaction : existingTransaction // ignore: cast_nullable_to_non_nullable
as TransactionEntity?,
  ));
}

/// Create a copy of TransactionEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionEntityCopyWith<$Res>? get existingTransaction {
    if (_self.existingTransaction == null) {
    return null;
  }

  return $TransactionEntityCopyWith<$Res>(_self.existingTransaction!, (value) {
    return _then(_self.copyWith(existingTransaction: value));
  });
}
}

// dart format on
