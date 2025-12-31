// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountEntity {

 String get id; String get name; AccountType get type;/// Current balance (positive for assets, can be negative for credit)
 double get balance;/// Credit limit for credit cards
 double? get creditLimit;/// Monthly budget limit for spending from this account
 double? get budgetLimit;/// Threshold percentage (0-1) for budget warning, defaults to 0.8 (80%)
 double get warningThreshold;/// Icon name for display
 String? get iconName;/// Color hex for display
 String? get colorHex;/// Whether this account is active
 bool get isActive;/// Creation timestamp
 DateTime? get createdAt;
/// Create a copy of AccountEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountEntityCopyWith<AccountEntity> get copyWith => _$AccountEntityCopyWithImpl<AccountEntity>(this as AccountEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.creditLimit, creditLimit) || other.creditLimit == creditLimit)&&(identical(other.budgetLimit, budgetLimit) || other.budgetLimit == budgetLimit)&&(identical(other.warningThreshold, warningThreshold) || other.warningThreshold == warningThreshold)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,balance,creditLimit,budgetLimit,warningThreshold,iconName,colorHex,isActive,createdAt);

@override
String toString() {
  return 'AccountEntity(id: $id, name: $name, type: $type, balance: $balance, creditLimit: $creditLimit, budgetLimit: $budgetLimit, warningThreshold: $warningThreshold, iconName: $iconName, colorHex: $colorHex, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AccountEntityCopyWith<$Res>  {
  factory $AccountEntityCopyWith(AccountEntity value, $Res Function(AccountEntity) _then) = _$AccountEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, AccountType type, double balance, double? creditLimit, double? budgetLimit, double warningThreshold, String? iconName, String? colorHex, bool isActive, DateTime? createdAt
});




}
/// @nodoc
class _$AccountEntityCopyWithImpl<$Res>
    implements $AccountEntityCopyWith<$Res> {
  _$AccountEntityCopyWithImpl(this._self, this._then);

  final AccountEntity _self;
  final $Res Function(AccountEntity) _then;

/// Create a copy of AccountEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? balance = null,Object? creditLimit = freezed,Object? budgetLimit = freezed,Object? warningThreshold = null,Object? iconName = freezed,Object? colorHex = freezed,Object? isActive = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,creditLimit: freezed == creditLimit ? _self.creditLimit : creditLimit // ignore: cast_nullable_to_non_nullable
as double?,budgetLimit: freezed == budgetLimit ? _self.budgetLimit : budgetLimit // ignore: cast_nullable_to_non_nullable
as double?,warningThreshold: null == warningThreshold ? _self.warningThreshold : warningThreshold // ignore: cast_nullable_to_non_nullable
as double,iconName: freezed == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountEntity].
extension AccountEntityPatterns on AccountEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountEntity value)  $default,){
final _that = this;
switch (_that) {
case _AccountEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AccountEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  AccountType type,  double balance,  double? creditLimit,  double? budgetLimit,  double warningThreshold,  String? iconName,  String? colorHex,  bool isActive,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountEntity() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.balance,_that.creditLimit,_that.budgetLimit,_that.warningThreshold,_that.iconName,_that.colorHex,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  AccountType type,  double balance,  double? creditLimit,  double? budgetLimit,  double warningThreshold,  String? iconName,  String? colorHex,  bool isActive,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AccountEntity():
return $default(_that.id,_that.name,_that.type,_that.balance,_that.creditLimit,_that.budgetLimit,_that.warningThreshold,_that.iconName,_that.colorHex,_that.isActive,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  AccountType type,  double balance,  double? creditLimit,  double? budgetLimit,  double warningThreshold,  String? iconName,  String? colorHex,  bool isActive,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AccountEntity() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.balance,_that.creditLimit,_that.budgetLimit,_that.warningThreshold,_that.iconName,_that.colorHex,_that.isActive,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _AccountEntity extends AccountEntity {
  const _AccountEntity({required this.id, required this.name, required this.type, this.balance = 0, this.creditLimit, this.budgetLimit, this.warningThreshold = 0.8, this.iconName, this.colorHex, this.isActive = true, this.createdAt}): super._();
  

@override final  String id;
@override final  String name;
@override final  AccountType type;
/// Current balance (positive for assets, can be negative for credit)
@override@JsonKey() final  double balance;
/// Credit limit for credit cards
@override final  double? creditLimit;
/// Monthly budget limit for spending from this account
@override final  double? budgetLimit;
/// Threshold percentage (0-1) for budget warning, defaults to 0.8 (80%)
@override@JsonKey() final  double warningThreshold;
/// Icon name for display
@override final  String? iconName;
/// Color hex for display
@override final  String? colorHex;
/// Whether this account is active
@override@JsonKey() final  bool isActive;
/// Creation timestamp
@override final  DateTime? createdAt;

/// Create a copy of AccountEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountEntityCopyWith<_AccountEntity> get copyWith => __$AccountEntityCopyWithImpl<_AccountEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.creditLimit, creditLimit) || other.creditLimit == creditLimit)&&(identical(other.budgetLimit, budgetLimit) || other.budgetLimit == budgetLimit)&&(identical(other.warningThreshold, warningThreshold) || other.warningThreshold == warningThreshold)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,balance,creditLimit,budgetLimit,warningThreshold,iconName,colorHex,isActive,createdAt);

@override
String toString() {
  return 'AccountEntity(id: $id, name: $name, type: $type, balance: $balance, creditLimit: $creditLimit, budgetLimit: $budgetLimit, warningThreshold: $warningThreshold, iconName: $iconName, colorHex: $colorHex, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AccountEntityCopyWith<$Res> implements $AccountEntityCopyWith<$Res> {
  factory _$AccountEntityCopyWith(_AccountEntity value, $Res Function(_AccountEntity) _then) = __$AccountEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, AccountType type, double balance, double? creditLimit, double? budgetLimit, double warningThreshold, String? iconName, String? colorHex, bool isActive, DateTime? createdAt
});




}
/// @nodoc
class __$AccountEntityCopyWithImpl<$Res>
    implements _$AccountEntityCopyWith<$Res> {
  __$AccountEntityCopyWithImpl(this._self, this._then);

  final _AccountEntity _self;
  final $Res Function(_AccountEntity) _then;

/// Create a copy of AccountEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? balance = null,Object? creditLimit = freezed,Object? budgetLimit = freezed,Object? warningThreshold = null,Object? iconName = freezed,Object? colorHex = freezed,Object? isActive = null,Object? createdAt = freezed,}) {
  return _then(_AccountEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,creditLimit: freezed == creditLimit ? _self.creditLimit : creditLimit // ignore: cast_nullable_to_non_nullable
as double?,budgetLimit: freezed == budgetLimit ? _self.budgetLimit : budgetLimit // ignore: cast_nullable_to_non_nullable
as double?,warningThreshold: null == warningThreshold ? _self.warningThreshold : warningThreshold // ignore: cast_nullable_to_non_nullable
as double,iconName: freezed == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String?,colorHex: freezed == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
