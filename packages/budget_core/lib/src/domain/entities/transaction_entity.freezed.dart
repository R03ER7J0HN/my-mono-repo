// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionEntity {

 String get id;/// Source account ID
 String get accountId;/// Transaction type
 TransactionType get type;/// Transaction amount (always positive)
 double get amount;/// Transaction description
 String get description;/// Transaction date and time
 DateTime get date;/// Destination account ID (for transfers)
 String? get toAccountId;/// Optional category ID for organization
 String? get categoryId;/// Optional notes
 String? get notes;/// Whether this is recurring
 bool get isRecurring;/// Creation timestamp
 DateTime? get createdAt;
/// Create a copy of TransactionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionEntityCopyWith<TransactionEntity> get copyWith => _$TransactionEntityCopyWithImpl<TransactionEntity>(this as TransactionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,accountId,type,amount,description,date,toAccountId,categoryId,notes,isRecurring,createdAt);

@override
String toString() {
  return 'TransactionEntity(id: $id, accountId: $accountId, type: $type, amount: $amount, description: $description, date: $date, toAccountId: $toAccountId, categoryId: $categoryId, notes: $notes, isRecurring: $isRecurring, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $TransactionEntityCopyWith<$Res>  {
  factory $TransactionEntityCopyWith(TransactionEntity value, $Res Function(TransactionEntity) _then) = _$TransactionEntityCopyWithImpl;
@useResult
$Res call({
 String id, String accountId, TransactionType type, double amount, String description, DateTime date, String? toAccountId, String? categoryId, String? notes, bool isRecurring, DateTime? createdAt
});




}
/// @nodoc
class _$TransactionEntityCopyWithImpl<$Res>
    implements $TransactionEntityCopyWith<$Res> {
  _$TransactionEntityCopyWithImpl(this._self, this._then);

  final TransactionEntity _self;
  final $Res Function(TransactionEntity) _then;

/// Create a copy of TransactionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountId = null,Object? type = null,Object? amount = null,Object? description = null,Object? date = null,Object? toAccountId = freezed,Object? categoryId = freezed,Object? notes = freezed,Object? isRecurring = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionEntity].
extension TransactionEntityPatterns on TransactionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionEntity value)  $default,){
final _that = this;
switch (_that) {
case _TransactionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String accountId,  TransactionType type,  double amount,  String description,  DateTime date,  String? toAccountId,  String? categoryId,  String? notes,  bool isRecurring,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionEntity() when $default != null:
return $default(_that.id,_that.accountId,_that.type,_that.amount,_that.description,_that.date,_that.toAccountId,_that.categoryId,_that.notes,_that.isRecurring,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String accountId,  TransactionType type,  double amount,  String description,  DateTime date,  String? toAccountId,  String? categoryId,  String? notes,  bool isRecurring,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _TransactionEntity():
return $default(_that.id,_that.accountId,_that.type,_that.amount,_that.description,_that.date,_that.toAccountId,_that.categoryId,_that.notes,_that.isRecurring,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String accountId,  TransactionType type,  double amount,  String description,  DateTime date,  String? toAccountId,  String? categoryId,  String? notes,  bool isRecurring,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TransactionEntity() when $default != null:
return $default(_that.id,_that.accountId,_that.type,_that.amount,_that.description,_that.date,_that.toAccountId,_that.categoryId,_that.notes,_that.isRecurring,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionEntity extends TransactionEntity {
  const _TransactionEntity({required this.id, required this.accountId, required this.type, required this.amount, required this.description, required this.date, this.toAccountId, this.categoryId, this.notes, this.isRecurring = false, this.createdAt}): super._();
  

@override final  String id;
/// Source account ID
@override final  String accountId;
/// Transaction type
@override final  TransactionType type;
/// Transaction amount (always positive)
@override final  double amount;
/// Transaction description
@override final  String description;
/// Transaction date and time
@override final  DateTime date;
/// Destination account ID (for transfers)
@override final  String? toAccountId;
/// Optional category ID for organization
@override final  String? categoryId;
/// Optional notes
@override final  String? notes;
/// Whether this is recurring
@override@JsonKey() final  bool isRecurring;
/// Creation timestamp
@override final  DateTime? createdAt;

/// Create a copy of TransactionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionEntityCopyWith<_TransactionEntity> get copyWith => __$TransactionEntityCopyWithImpl<_TransactionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isRecurring, isRecurring) || other.isRecurring == isRecurring)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,accountId,type,amount,description,date,toAccountId,categoryId,notes,isRecurring,createdAt);

@override
String toString() {
  return 'TransactionEntity(id: $id, accountId: $accountId, type: $type, amount: $amount, description: $description, date: $date, toAccountId: $toAccountId, categoryId: $categoryId, notes: $notes, isRecurring: $isRecurring, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TransactionEntityCopyWith<$Res> implements $TransactionEntityCopyWith<$Res> {
  factory _$TransactionEntityCopyWith(_TransactionEntity value, $Res Function(_TransactionEntity) _then) = __$TransactionEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String accountId, TransactionType type, double amount, String description, DateTime date, String? toAccountId, String? categoryId, String? notes, bool isRecurring, DateTime? createdAt
});




}
/// @nodoc
class __$TransactionEntityCopyWithImpl<$Res>
    implements _$TransactionEntityCopyWith<$Res> {
  __$TransactionEntityCopyWithImpl(this._self, this._then);

  final _TransactionEntity _self;
  final $Res Function(_TransactionEntity) _then;

/// Create a copy of TransactionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = null,Object? type = null,Object? amount = null,Object? description = null,Object? date = null,Object? toAccountId = freezed,Object? categoryId = freezed,Object? notes = freezed,Object? isRecurring = null,Object? createdAt = freezed,}) {
  return _then(_TransactionEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isRecurring: null == isRecurring ? _self.isRecurring : isRecurring // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
