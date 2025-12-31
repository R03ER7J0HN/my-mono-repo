// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'installment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InstallmentEntity {

 String get id;/// Associated credit card account ID
 String get accountId;/// Description of the purchase
 String get description;/// Total amount of the purchase
 double get totalAmount;/// Total number of installments
 int get totalInstallments;/// Start date of the installment plan
 DateTime get startDate;/// Number of installments already paid
 int get paidInstallments;/// Payment frequency
 InstallmentFrequency get frequency;/// Optional merchant/store name
 String? get merchantName;/// Optional notes
 String? get notes;/// Creation timestamp
 DateTime? get createdAt;
/// Create a copy of InstallmentEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstallmentEntityCopyWith<InstallmentEntity> get copyWith => _$InstallmentEntityCopyWithImpl<InstallmentEntity>(this as InstallmentEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstallmentEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.description, description) || other.description == description)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalInstallments, totalInstallments) || other.totalInstallments == totalInstallments)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.paidInstallments, paidInstallments) || other.paidInstallments == paidInstallments)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,accountId,description,totalAmount,totalInstallments,startDate,paidInstallments,frequency,merchantName,notes,createdAt);

@override
String toString() {
  return 'InstallmentEntity(id: $id, accountId: $accountId, description: $description, totalAmount: $totalAmount, totalInstallments: $totalInstallments, startDate: $startDate, paidInstallments: $paidInstallments, frequency: $frequency, merchantName: $merchantName, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $InstallmentEntityCopyWith<$Res>  {
  factory $InstallmentEntityCopyWith(InstallmentEntity value, $Res Function(InstallmentEntity) _then) = _$InstallmentEntityCopyWithImpl;
@useResult
$Res call({
 String id, String accountId, String description, double totalAmount, int totalInstallments, DateTime startDate, int paidInstallments, InstallmentFrequency frequency, String? merchantName, String? notes, DateTime? createdAt
});




}
/// @nodoc
class _$InstallmentEntityCopyWithImpl<$Res>
    implements $InstallmentEntityCopyWith<$Res> {
  _$InstallmentEntityCopyWithImpl(this._self, this._then);

  final InstallmentEntity _self;
  final $Res Function(InstallmentEntity) _then;

/// Create a copy of InstallmentEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountId = null,Object? description = null,Object? totalAmount = null,Object? totalInstallments = null,Object? startDate = null,Object? paidInstallments = null,Object? frequency = null,Object? merchantName = freezed,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,totalInstallments: null == totalInstallments ? _self.totalInstallments : totalInstallments // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,paidInstallments: null == paidInstallments ? _self.paidInstallments : paidInstallments // ignore: cast_nullable_to_non_nullable
as int,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as InstallmentFrequency,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [InstallmentEntity].
extension InstallmentEntityPatterns on InstallmentEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstallmentEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstallmentEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstallmentEntity value)  $default,){
final _that = this;
switch (_that) {
case _InstallmentEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstallmentEntity value)?  $default,){
final _that = this;
switch (_that) {
case _InstallmentEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String accountId,  String description,  double totalAmount,  int totalInstallments,  DateTime startDate,  int paidInstallments,  InstallmentFrequency frequency,  String? merchantName,  String? notes,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstallmentEntity() when $default != null:
return $default(_that.id,_that.accountId,_that.description,_that.totalAmount,_that.totalInstallments,_that.startDate,_that.paidInstallments,_that.frequency,_that.merchantName,_that.notes,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String accountId,  String description,  double totalAmount,  int totalInstallments,  DateTime startDate,  int paidInstallments,  InstallmentFrequency frequency,  String? merchantName,  String? notes,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _InstallmentEntity():
return $default(_that.id,_that.accountId,_that.description,_that.totalAmount,_that.totalInstallments,_that.startDate,_that.paidInstallments,_that.frequency,_that.merchantName,_that.notes,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String accountId,  String description,  double totalAmount,  int totalInstallments,  DateTime startDate,  int paidInstallments,  InstallmentFrequency frequency,  String? merchantName,  String? notes,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _InstallmentEntity() when $default != null:
return $default(_that.id,_that.accountId,_that.description,_that.totalAmount,_that.totalInstallments,_that.startDate,_that.paidInstallments,_that.frequency,_that.merchantName,_that.notes,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _InstallmentEntity extends InstallmentEntity {
  const _InstallmentEntity({required this.id, required this.accountId, required this.description, required this.totalAmount, required this.totalInstallments, required this.startDate, this.paidInstallments = 0, this.frequency = InstallmentFrequency.monthly, this.merchantName, this.notes, this.createdAt}): super._();
  

@override final  String id;
/// Associated credit card account ID
@override final  String accountId;
/// Description of the purchase
@override final  String description;
/// Total amount of the purchase
@override final  double totalAmount;
/// Total number of installments
@override final  int totalInstallments;
/// Start date of the installment plan
@override final  DateTime startDate;
/// Number of installments already paid
@override@JsonKey() final  int paidInstallments;
/// Payment frequency
@override@JsonKey() final  InstallmentFrequency frequency;
/// Optional merchant/store name
@override final  String? merchantName;
/// Optional notes
@override final  String? notes;
/// Creation timestamp
@override final  DateTime? createdAt;

/// Create a copy of InstallmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstallmentEntityCopyWith<_InstallmentEntity> get copyWith => __$InstallmentEntityCopyWithImpl<_InstallmentEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstallmentEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.description, description) || other.description == description)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalInstallments, totalInstallments) || other.totalInstallments == totalInstallments)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.paidInstallments, paidInstallments) || other.paidInstallments == paidInstallments)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,accountId,description,totalAmount,totalInstallments,startDate,paidInstallments,frequency,merchantName,notes,createdAt);

@override
String toString() {
  return 'InstallmentEntity(id: $id, accountId: $accountId, description: $description, totalAmount: $totalAmount, totalInstallments: $totalInstallments, startDate: $startDate, paidInstallments: $paidInstallments, frequency: $frequency, merchantName: $merchantName, notes: $notes, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InstallmentEntityCopyWith<$Res> implements $InstallmentEntityCopyWith<$Res> {
  factory _$InstallmentEntityCopyWith(_InstallmentEntity value, $Res Function(_InstallmentEntity) _then) = __$InstallmentEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String accountId, String description, double totalAmount, int totalInstallments, DateTime startDate, int paidInstallments, InstallmentFrequency frequency, String? merchantName, String? notes, DateTime? createdAt
});




}
/// @nodoc
class __$InstallmentEntityCopyWithImpl<$Res>
    implements _$InstallmentEntityCopyWith<$Res> {
  __$InstallmentEntityCopyWithImpl(this._self, this._then);

  final _InstallmentEntity _self;
  final $Res Function(_InstallmentEntity) _then;

/// Create a copy of InstallmentEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = null,Object? description = null,Object? totalAmount = null,Object? totalInstallments = null,Object? startDate = null,Object? paidInstallments = null,Object? frequency = null,Object? merchantName = freezed,Object? notes = freezed,Object? createdAt = freezed,}) {
  return _then(_InstallmentEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,totalInstallments: null == totalInstallments ? _self.totalInstallments : totalInstallments // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,paidInstallments: null == paidInstallments ? _self.paidInstallments : paidInstallments // ignore: cast_nullable_to_non_nullable
as int,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as InstallmentFrequency,merchantName: freezed == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
