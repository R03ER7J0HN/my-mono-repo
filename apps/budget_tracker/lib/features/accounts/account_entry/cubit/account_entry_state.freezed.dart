// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_entry_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountEntryState {

 String get name; AccountType get type; double get balance; double? get creditLimit; double? get budgetLimit; bool get isSaving; bool get isValid; String? get error; AccountEntity? get existingAccount;
/// Create a copy of AccountEntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountEntryStateCopyWith<AccountEntryState> get copyWith => _$AccountEntryStateCopyWithImpl<AccountEntryState>(this as AccountEntryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountEntryState&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.creditLimit, creditLimit) || other.creditLimit == creditLimit)&&(identical(other.budgetLimit, budgetLimit) || other.budgetLimit == budgetLimit)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.error, error) || other.error == error)&&(identical(other.existingAccount, existingAccount) || other.existingAccount == existingAccount));
}


@override
int get hashCode => Object.hash(runtimeType,name,type,balance,creditLimit,budgetLimit,isSaving,isValid,error,existingAccount);

@override
String toString() {
  return 'AccountEntryState(name: $name, type: $type, balance: $balance, creditLimit: $creditLimit, budgetLimit: $budgetLimit, isSaving: $isSaving, isValid: $isValid, error: $error, existingAccount: $existingAccount)';
}


}

/// @nodoc
abstract mixin class $AccountEntryStateCopyWith<$Res>  {
  factory $AccountEntryStateCopyWith(AccountEntryState value, $Res Function(AccountEntryState) _then) = _$AccountEntryStateCopyWithImpl;
@useResult
$Res call({
 String name, AccountType type, double balance, double? creditLimit, double? budgetLimit, bool isSaving, bool isValid, String? error, AccountEntity? existingAccount
});


$AccountEntityCopyWith<$Res>? get existingAccount;

}
/// @nodoc
class _$AccountEntryStateCopyWithImpl<$Res>
    implements $AccountEntryStateCopyWith<$Res> {
  _$AccountEntryStateCopyWithImpl(this._self, this._then);

  final AccountEntryState _self;
  final $Res Function(AccountEntryState) _then;

/// Create a copy of AccountEntryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? type = null,Object? balance = null,Object? creditLimit = freezed,Object? budgetLimit = freezed,Object? isSaving = null,Object? isValid = null,Object? error = freezed,Object? existingAccount = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,creditLimit: freezed == creditLimit ? _self.creditLimit : creditLimit // ignore: cast_nullable_to_non_nullable
as double?,budgetLimit: freezed == budgetLimit ? _self.budgetLimit : budgetLimit // ignore: cast_nullable_to_non_nullable
as double?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,existingAccount: freezed == existingAccount ? _self.existingAccount : existingAccount // ignore: cast_nullable_to_non_nullable
as AccountEntity?,
  ));
}
/// Create a copy of AccountEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountEntityCopyWith<$Res>? get existingAccount {
    if (_self.existingAccount == null) {
    return null;
  }

  return $AccountEntityCopyWith<$Res>(_self.existingAccount!, (value) {
    return _then(_self.copyWith(existingAccount: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountEntryState].
extension AccountEntryStatePatterns on AccountEntryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountEntryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountEntryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountEntryState value)  $default,){
final _that = this;
switch (_that) {
case _AccountEntryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountEntryState value)?  $default,){
final _that = this;
switch (_that) {
case _AccountEntryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  AccountType type,  double balance,  double? creditLimit,  double? budgetLimit,  bool isSaving,  bool isValid,  String? error,  AccountEntity? existingAccount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountEntryState() when $default != null:
return $default(_that.name,_that.type,_that.balance,_that.creditLimit,_that.budgetLimit,_that.isSaving,_that.isValid,_that.error,_that.existingAccount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  AccountType type,  double balance,  double? creditLimit,  double? budgetLimit,  bool isSaving,  bool isValid,  String? error,  AccountEntity? existingAccount)  $default,) {final _that = this;
switch (_that) {
case _AccountEntryState():
return $default(_that.name,_that.type,_that.balance,_that.creditLimit,_that.budgetLimit,_that.isSaving,_that.isValid,_that.error,_that.existingAccount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  AccountType type,  double balance,  double? creditLimit,  double? budgetLimit,  bool isSaving,  bool isValid,  String? error,  AccountEntity? existingAccount)?  $default,) {final _that = this;
switch (_that) {
case _AccountEntryState() when $default != null:
return $default(_that.name,_that.type,_that.balance,_that.creditLimit,_that.budgetLimit,_that.isSaving,_that.isValid,_that.error,_that.existingAccount);case _:
  return null;

}
}

}

/// @nodoc


class _AccountEntryState extends AccountEntryState {
  const _AccountEntryState({this.name = '', this.type = AccountType.cash, this.balance = 0, this.creditLimit, this.budgetLimit, this.isSaving = false, this.isValid = false, this.error, this.existingAccount}): super._();
  

@override@JsonKey() final  String name;
@override@JsonKey() final  AccountType type;
@override@JsonKey() final  double balance;
@override final  double? creditLimit;
@override final  double? budgetLimit;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isValid;
@override final  String? error;
@override final  AccountEntity? existingAccount;

/// Create a copy of AccountEntryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountEntryStateCopyWith<_AccountEntryState> get copyWith => __$AccountEntryStateCopyWithImpl<_AccountEntryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountEntryState&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.creditLimit, creditLimit) || other.creditLimit == creditLimit)&&(identical(other.budgetLimit, budgetLimit) || other.budgetLimit == budgetLimit)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.error, error) || other.error == error)&&(identical(other.existingAccount, existingAccount) || other.existingAccount == existingAccount));
}


@override
int get hashCode => Object.hash(runtimeType,name,type,balance,creditLimit,budgetLimit,isSaving,isValid,error,existingAccount);

@override
String toString() {
  return 'AccountEntryState(name: $name, type: $type, balance: $balance, creditLimit: $creditLimit, budgetLimit: $budgetLimit, isSaving: $isSaving, isValid: $isValid, error: $error, existingAccount: $existingAccount)';
}


}

/// @nodoc
abstract mixin class _$AccountEntryStateCopyWith<$Res> implements $AccountEntryStateCopyWith<$Res> {
  factory _$AccountEntryStateCopyWith(_AccountEntryState value, $Res Function(_AccountEntryState) _then) = __$AccountEntryStateCopyWithImpl;
@override @useResult
$Res call({
 String name, AccountType type, double balance, double? creditLimit, double? budgetLimit, bool isSaving, bool isValid, String? error, AccountEntity? existingAccount
});


@override $AccountEntityCopyWith<$Res>? get existingAccount;

}
/// @nodoc
class __$AccountEntryStateCopyWithImpl<$Res>
    implements _$AccountEntryStateCopyWith<$Res> {
  __$AccountEntryStateCopyWithImpl(this._self, this._then);

  final _AccountEntryState _self;
  final $Res Function(_AccountEntryState) _then;

/// Create a copy of AccountEntryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? type = null,Object? balance = null,Object? creditLimit = freezed,Object? budgetLimit = freezed,Object? isSaving = null,Object? isValid = null,Object? error = freezed,Object? existingAccount = freezed,}) {
  return _then(_AccountEntryState(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,creditLimit: freezed == creditLimit ? _self.creditLimit : creditLimit // ignore: cast_nullable_to_non_nullable
as double?,budgetLimit: freezed == budgetLimit ? _self.budgetLimit : budgetLimit // ignore: cast_nullable_to_non_nullable
as double?,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,existingAccount: freezed == existingAccount ? _self.existingAccount : existingAccount // ignore: cast_nullable_to_non_nullable
as AccountEntity?,
  ));
}

/// Create a copy of AccountEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountEntityCopyWith<$Res>? get existingAccount {
    if (_self.existingAccount == null) {
    return null;
  }

  return $AccountEntityCopyWith<$Res>(_self.existingAccount!, (value) {
    return _then(_self.copyWith(existingAccount: value));
  });
}
}

// dart format on
