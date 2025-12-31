// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'installments_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InstallmentsState {

 List<InstallmentEntity> get installments; List<AccountEntity> get accounts; bool get isLoading; String? get error; String? get filterAccountId;
/// Create a copy of InstallmentsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InstallmentsStateCopyWith<InstallmentsState> get copyWith => _$InstallmentsStateCopyWithImpl<InstallmentsState>(this as InstallmentsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InstallmentsState&&const DeepCollectionEquality().equals(other.installments, installments)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.filterAccountId, filterAccountId) || other.filterAccountId == filterAccountId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(installments),const DeepCollectionEquality().hash(accounts),isLoading,error,filterAccountId);

@override
String toString() {
  return 'InstallmentsState(installments: $installments, accounts: $accounts, isLoading: $isLoading, error: $error, filterAccountId: $filterAccountId)';
}


}

/// @nodoc
abstract mixin class $InstallmentsStateCopyWith<$Res>  {
  factory $InstallmentsStateCopyWith(InstallmentsState value, $Res Function(InstallmentsState) _then) = _$InstallmentsStateCopyWithImpl;
@useResult
$Res call({
 List<InstallmentEntity> installments, List<AccountEntity> accounts, bool isLoading, String? error, String? filterAccountId
});




}
/// @nodoc
class _$InstallmentsStateCopyWithImpl<$Res>
    implements $InstallmentsStateCopyWith<$Res> {
  _$InstallmentsStateCopyWithImpl(this._self, this._then);

  final InstallmentsState _self;
  final $Res Function(InstallmentsState) _then;

/// Create a copy of InstallmentsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? installments = null,Object? accounts = null,Object? isLoading = null,Object? error = freezed,Object? filterAccountId = freezed,}) {
  return _then(_self.copyWith(
installments: null == installments ? _self.installments : installments // ignore: cast_nullable_to_non_nullable
as List<InstallmentEntity>,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,filterAccountId: freezed == filterAccountId ? _self.filterAccountId : filterAccountId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InstallmentsState].
extension InstallmentsStatePatterns on InstallmentsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InstallmentsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InstallmentsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InstallmentsState value)  $default,){
final _that = this;
switch (_that) {
case _InstallmentsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InstallmentsState value)?  $default,){
final _that = this;
switch (_that) {
case _InstallmentsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<InstallmentEntity> installments,  List<AccountEntity> accounts,  bool isLoading,  String? error,  String? filterAccountId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InstallmentsState() when $default != null:
return $default(_that.installments,_that.accounts,_that.isLoading,_that.error,_that.filterAccountId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<InstallmentEntity> installments,  List<AccountEntity> accounts,  bool isLoading,  String? error,  String? filterAccountId)  $default,) {final _that = this;
switch (_that) {
case _InstallmentsState():
return $default(_that.installments,_that.accounts,_that.isLoading,_that.error,_that.filterAccountId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<InstallmentEntity> installments,  List<AccountEntity> accounts,  bool isLoading,  String? error,  String? filterAccountId)?  $default,) {final _that = this;
switch (_that) {
case _InstallmentsState() when $default != null:
return $default(_that.installments,_that.accounts,_that.isLoading,_that.error,_that.filterAccountId);case _:
  return null;

}
}

}

/// @nodoc


class _InstallmentsState extends InstallmentsState {
  const _InstallmentsState({final  List<InstallmentEntity> installments = const [], final  List<AccountEntity> accounts = const [], this.isLoading = true, this.error, this.filterAccountId}): _installments = installments,_accounts = accounts,super._();
  

 final  List<InstallmentEntity> _installments;
@override@JsonKey() List<InstallmentEntity> get installments {
  if (_installments is EqualUnmodifiableListView) return _installments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_installments);
}

 final  List<AccountEntity> _accounts;
@override@JsonKey() List<AccountEntity> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;
@override final  String? filterAccountId;

/// Create a copy of InstallmentsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InstallmentsStateCopyWith<_InstallmentsState> get copyWith => __$InstallmentsStateCopyWithImpl<_InstallmentsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InstallmentsState&&const DeepCollectionEquality().equals(other._installments, _installments)&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error)&&(identical(other.filterAccountId, filterAccountId) || other.filterAccountId == filterAccountId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_installments),const DeepCollectionEquality().hash(_accounts),isLoading,error,filterAccountId);

@override
String toString() {
  return 'InstallmentsState(installments: $installments, accounts: $accounts, isLoading: $isLoading, error: $error, filterAccountId: $filterAccountId)';
}


}

/// @nodoc
abstract mixin class _$InstallmentsStateCopyWith<$Res> implements $InstallmentsStateCopyWith<$Res> {
  factory _$InstallmentsStateCopyWith(_InstallmentsState value, $Res Function(_InstallmentsState) _then) = __$InstallmentsStateCopyWithImpl;
@override @useResult
$Res call({
 List<InstallmentEntity> installments, List<AccountEntity> accounts, bool isLoading, String? error, String? filterAccountId
});




}
/// @nodoc
class __$InstallmentsStateCopyWithImpl<$Res>
    implements _$InstallmentsStateCopyWith<$Res> {
  __$InstallmentsStateCopyWithImpl(this._self, this._then);

  final _InstallmentsState _self;
  final $Res Function(_InstallmentsState) _then;

/// Create a copy of InstallmentsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? installments = null,Object? accounts = null,Object? isLoading = null,Object? error = freezed,Object? filterAccountId = freezed,}) {
  return _then(_InstallmentsState(
installments: null == installments ? _self._installments : installments // ignore: cast_nullable_to_non_nullable
as List<InstallmentEntity>,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountEntity>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,filterAccountId: freezed == filterAccountId ? _self.filterAccountId : filterAccountId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
