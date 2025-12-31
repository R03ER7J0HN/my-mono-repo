// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'installment_entry_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InstallmentEntryState {

 String get description; double get totalAmount; int get totalInstallments; int get paidInstallments; InstallmentFrequency get frequency; DateTime? get startDate; String? get accountId; List<AccountEntity> get creditCardAccounts; bool get isSaving; bool get isValid; String? get error; InstallmentEntity? get existingInstallment;
/// Create a copy of InstallmentEntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstallmentEntryStateCopyWith<InstallmentEntryState> get copyWith => _$InstallmentEntryStateCopyWithImpl<InstallmentEntryState>(this as InstallmentEntryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstallmentEntryState&&(identical(other.description, description) || other.description == description)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalInstallments, totalInstallments) || other.totalInstallments == totalInstallments)&&(identical(other.paidInstallments, paidInstallments) || other.paidInstallments == paidInstallments)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&const DeepCollectionEquality().equals(other.creditCardAccounts, creditCardAccounts)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.error, error) || other.error == error)&&(identical(other.existingInstallment, existingInstallment) || other.existingInstallment == existingInstallment));
}


@override
int get hashCode => Object.hash(runtimeType,description,totalAmount,totalInstallments,paidInstallments,frequency,startDate,accountId,const DeepCollectionEquality().hash(creditCardAccounts),isSaving,isValid,error,existingInstallment);

@override
String toString() {
  return 'InstallmentEntryState(description: $description, totalAmount: $totalAmount, totalInstallments: $totalInstallments, paidInstallments: $paidInstallments, frequency: $frequency, startDate: $startDate, accountId: $accountId, creditCardAccounts: $creditCardAccounts, isSaving: $isSaving, isValid: $isValid, error: $error, existingInstallment: $existingInstallment)';
}


}

/// @nodoc
abstract mixin class $InstallmentEntryStateCopyWith<$Res>  {
  factory $InstallmentEntryStateCopyWith(InstallmentEntryState value, $Res Function(InstallmentEntryState) _then) = _$InstallmentEntryStateCopyWithImpl;
@useResult
$Res call({
 String description, double totalAmount, int totalInstallments, int paidInstallments, InstallmentFrequency frequency, DateTime? startDate, String? accountId, List<AccountEntity> creditCardAccounts, bool isSaving, bool isValid, String? error, InstallmentEntity? existingInstallment
});


$InstallmentEntityCopyWith<$Res>? get existingInstallment;

}
/// @nodoc
class _$InstallmentEntryStateCopyWithImpl<$Res>
    implements $InstallmentEntryStateCopyWith<$Res> {
  _$InstallmentEntryStateCopyWithImpl(this._self, this._then);

  final InstallmentEntryState _self;
  final $Res Function(InstallmentEntryState) _then;

/// Create a copy of InstallmentEntryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = null,Object? totalAmount = null,Object? totalInstallments = null,Object? paidInstallments = null,Object? frequency = null,Object? startDate = freezed,Object? accountId = freezed,Object? creditCardAccounts = null,Object? isSaving = null,Object? isValid = null,Object? error = freezed,Object? existingInstallment = freezed,}) {
  return _then(_self.copyWith(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,totalInstallments: null == totalInstallments ? _self.totalInstallments : totalInstallments // ignore: cast_nullable_to_non_nullable
as int,paidInstallments: null == paidInstallments ? _self.paidInstallments : paidInstallments // ignore: cast_nullable_to_non_nullable
as int,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as InstallmentFrequency,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,creditCardAccounts: null == creditCardAccounts ? _self.creditCardAccounts : creditCardAccounts // ignore: cast_nullable_to_non_nullable
as List<AccountEntity>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,existingInstallment: freezed == existingInstallment ? _self.existingInstallment : existingInstallment // ignore: cast_nullable_to_non_nullable
as InstallmentEntity?,
  ));
}
/// Create a copy of InstallmentEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InstallmentEntityCopyWith<$Res>? get existingInstallment {
    if (_self.existingInstallment == null) {
    return null;
  }

  return $InstallmentEntityCopyWith<$Res>(_self.existingInstallment!, (value) {
    return _then(_self.copyWith(existingInstallment: value));
  });
}
}


/// Adds pattern-matching-related methods to [InstallmentEntryState].
extension InstallmentEntryStatePatterns on InstallmentEntryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstallmentEntryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstallmentEntryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstallmentEntryState value)  $default,){
final _that = this;
switch (_that) {
case _InstallmentEntryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstallmentEntryState value)?  $default,){
final _that = this;
switch (_that) {
case _InstallmentEntryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String description,  double totalAmount,  int totalInstallments,  int paidInstallments,  InstallmentFrequency frequency,  DateTime? startDate,  String? accountId,  List<AccountEntity> creditCardAccounts,  bool isSaving,  bool isValid,  String? error,  InstallmentEntity? existingInstallment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstallmentEntryState() when $default != null:
return $default(_that.description,_that.totalAmount,_that.totalInstallments,_that.paidInstallments,_that.frequency,_that.startDate,_that.accountId,_that.creditCardAccounts,_that.isSaving,_that.isValid,_that.error,_that.existingInstallment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String description,  double totalAmount,  int totalInstallments,  int paidInstallments,  InstallmentFrequency frequency,  DateTime? startDate,  String? accountId,  List<AccountEntity> creditCardAccounts,  bool isSaving,  bool isValid,  String? error,  InstallmentEntity? existingInstallment)  $default,) {final _that = this;
switch (_that) {
case _InstallmentEntryState():
return $default(_that.description,_that.totalAmount,_that.totalInstallments,_that.paidInstallments,_that.frequency,_that.startDate,_that.accountId,_that.creditCardAccounts,_that.isSaving,_that.isValid,_that.error,_that.existingInstallment);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String description,  double totalAmount,  int totalInstallments,  int paidInstallments,  InstallmentFrequency frequency,  DateTime? startDate,  String? accountId,  List<AccountEntity> creditCardAccounts,  bool isSaving,  bool isValid,  String? error,  InstallmentEntity? existingInstallment)?  $default,) {final _that = this;
switch (_that) {
case _InstallmentEntryState() when $default != null:
return $default(_that.description,_that.totalAmount,_that.totalInstallments,_that.paidInstallments,_that.frequency,_that.startDate,_that.accountId,_that.creditCardAccounts,_that.isSaving,_that.isValid,_that.error,_that.existingInstallment);case _:
  return null;

}
}

}

/// @nodoc


class _InstallmentEntryState extends InstallmentEntryState {
  const _InstallmentEntryState({this.description = '', this.totalAmount = 0, this.totalInstallments = 12, this.paidInstallments = 0, this.frequency = InstallmentFrequency.monthly, this.startDate, this.accountId, final  List<AccountEntity> creditCardAccounts = const [], this.isSaving = false, this.isValid = false, this.error, this.existingInstallment}): _creditCardAccounts = creditCardAccounts,super._();
  

@override@JsonKey() final  String description;
@override@JsonKey() final  double totalAmount;
@override@JsonKey() final  int totalInstallments;
@override@JsonKey() final  int paidInstallments;
@override@JsonKey() final  InstallmentFrequency frequency;
@override final  DateTime? startDate;
@override final  String? accountId;
 final  List<AccountEntity> _creditCardAccounts;
@override@JsonKey() List<AccountEntity> get creditCardAccounts {
  if (_creditCardAccounts is EqualUnmodifiableListView) return _creditCardAccounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_creditCardAccounts);
}

@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isValid;
@override final  String? error;
@override final  InstallmentEntity? existingInstallment;

/// Create a copy of InstallmentEntryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstallmentEntryStateCopyWith<_InstallmentEntryState> get copyWith => __$InstallmentEntryStateCopyWithImpl<_InstallmentEntryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstallmentEntryState&&(identical(other.description, description) || other.description == description)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.totalInstallments, totalInstallments) || other.totalInstallments == totalInstallments)&&(identical(other.paidInstallments, paidInstallments) || other.paidInstallments == paidInstallments)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&const DeepCollectionEquality().equals(other._creditCardAccounts, _creditCardAccounts)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.error, error) || other.error == error)&&(identical(other.existingInstallment, existingInstallment) || other.existingInstallment == existingInstallment));
}


@override
int get hashCode => Object.hash(runtimeType,description,totalAmount,totalInstallments,paidInstallments,frequency,startDate,accountId,const DeepCollectionEquality().hash(_creditCardAccounts),isSaving,isValid,error,existingInstallment);

@override
String toString() {
  return 'InstallmentEntryState(description: $description, totalAmount: $totalAmount, totalInstallments: $totalInstallments, paidInstallments: $paidInstallments, frequency: $frequency, startDate: $startDate, accountId: $accountId, creditCardAccounts: $creditCardAccounts, isSaving: $isSaving, isValid: $isValid, error: $error, existingInstallment: $existingInstallment)';
}


}

/// @nodoc
abstract mixin class _$InstallmentEntryStateCopyWith<$Res> implements $InstallmentEntryStateCopyWith<$Res> {
  factory _$InstallmentEntryStateCopyWith(_InstallmentEntryState value, $Res Function(_InstallmentEntryState) _then) = __$InstallmentEntryStateCopyWithImpl;
@override @useResult
$Res call({
 String description, double totalAmount, int totalInstallments, int paidInstallments, InstallmentFrequency frequency, DateTime? startDate, String? accountId, List<AccountEntity> creditCardAccounts, bool isSaving, bool isValid, String? error, InstallmentEntity? existingInstallment
});


@override $InstallmentEntityCopyWith<$Res>? get existingInstallment;

}
/// @nodoc
class __$InstallmentEntryStateCopyWithImpl<$Res>
    implements _$InstallmentEntryStateCopyWith<$Res> {
  __$InstallmentEntryStateCopyWithImpl(this._self, this._then);

  final _InstallmentEntryState _self;
  final $Res Function(_InstallmentEntryState) _then;

/// Create a copy of InstallmentEntryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = null,Object? totalAmount = null,Object? totalInstallments = null,Object? paidInstallments = null,Object? frequency = null,Object? startDate = freezed,Object? accountId = freezed,Object? creditCardAccounts = null,Object? isSaving = null,Object? isValid = null,Object? error = freezed,Object? existingInstallment = freezed,}) {
  return _then(_InstallmentEntryState(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,totalInstallments: null == totalInstallments ? _self.totalInstallments : totalInstallments // ignore: cast_nullable_to_non_nullable
as int,paidInstallments: null == paidInstallments ? _self.paidInstallments : paidInstallments // ignore: cast_nullable_to_non_nullable
as int,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as InstallmentFrequency,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,creditCardAccounts: null == creditCardAccounts ? _self._creditCardAccounts : creditCardAccounts // ignore: cast_nullable_to_non_nullable
as List<AccountEntity>,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,existingInstallment: freezed == existingInstallment ? _self.existingInstallment : existingInstallment // ignore: cast_nullable_to_non_nullable
as InstallmentEntity?,
  ));
}

/// Create a copy of InstallmentEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InstallmentEntityCopyWith<$Res>? get existingInstallment {
    if (_self.existingInstallment == null) {
    return null;
  }

  return $InstallmentEntityCopyWith<$Res>(_self.existingInstallment!, (value) {
    return _then(_self.copyWith(existingInstallment: value));
  });
}
}

// dart format on
