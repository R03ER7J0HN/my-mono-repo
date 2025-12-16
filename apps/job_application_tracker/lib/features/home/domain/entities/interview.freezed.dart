// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interview.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Interview {

 String get companyName; String get role; DateTime get dateTime; String? get meetingUrl;
/// Create a copy of Interview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterviewCopyWith<Interview> get copyWith => _$InterviewCopyWithImpl<Interview>(this as Interview, _$identity);

  /// Serializes this Interview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Interview&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.role, role) || other.role == role)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.meetingUrl, meetingUrl) || other.meetingUrl == meetingUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,companyName,role,dateTime,meetingUrl);

@override
String toString() {
  return 'Interview(companyName: $companyName, role: $role, dateTime: $dateTime, meetingUrl: $meetingUrl)';
}


}

/// @nodoc
abstract mixin class $InterviewCopyWith<$Res>  {
  factory $InterviewCopyWith(Interview value, $Res Function(Interview) _then) = _$InterviewCopyWithImpl;
@useResult
$Res call({
 String companyName, String role, DateTime dateTime, String? meetingUrl
});




}
/// @nodoc
class _$InterviewCopyWithImpl<$Res>
    implements $InterviewCopyWith<$Res> {
  _$InterviewCopyWithImpl(this._self, this._then);

  final Interview _self;
  final $Res Function(Interview) _then;

/// Create a copy of Interview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? companyName = null,Object? role = null,Object? dateTime = null,Object? meetingUrl = freezed,}) {
  return _then(_self.copyWith(
companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,meetingUrl: freezed == meetingUrl ? _self.meetingUrl : meetingUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Interview].
extension InterviewPatterns on Interview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Interview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Interview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Interview value)  $default,){
final _that = this;
switch (_that) {
case _Interview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Interview value)?  $default,){
final _that = this;
switch (_that) {
case _Interview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String companyName,  String role,  DateTime dateTime,  String? meetingUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Interview() when $default != null:
return $default(_that.companyName,_that.role,_that.dateTime,_that.meetingUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String companyName,  String role,  DateTime dateTime,  String? meetingUrl)  $default,) {final _that = this;
switch (_that) {
case _Interview():
return $default(_that.companyName,_that.role,_that.dateTime,_that.meetingUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String companyName,  String role,  DateTime dateTime,  String? meetingUrl)?  $default,) {final _that = this;
switch (_that) {
case _Interview() when $default != null:
return $default(_that.companyName,_that.role,_that.dateTime,_that.meetingUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Interview implements Interview {
  const _Interview({required this.companyName, required this.role, required this.dateTime, this.meetingUrl});
  factory _Interview.fromJson(Map<String, dynamic> json) => _$InterviewFromJson(json);

@override final  String companyName;
@override final  String role;
@override final  DateTime dateTime;
@override final  String? meetingUrl;

/// Create a copy of Interview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterviewCopyWith<_Interview> get copyWith => __$InterviewCopyWithImpl<_Interview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Interview&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.role, role) || other.role == role)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.meetingUrl, meetingUrl) || other.meetingUrl == meetingUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,companyName,role,dateTime,meetingUrl);

@override
String toString() {
  return 'Interview(companyName: $companyName, role: $role, dateTime: $dateTime, meetingUrl: $meetingUrl)';
}


}

/// @nodoc
abstract mixin class _$InterviewCopyWith<$Res> implements $InterviewCopyWith<$Res> {
  factory _$InterviewCopyWith(_Interview value, $Res Function(_Interview) _then) = __$InterviewCopyWithImpl;
@override @useResult
$Res call({
 String companyName, String role, DateTime dateTime, String? meetingUrl
});




}
/// @nodoc
class __$InterviewCopyWithImpl<$Res>
    implements _$InterviewCopyWith<$Res> {
  __$InterviewCopyWithImpl(this._self, this._then);

  final _Interview _self;
  final $Res Function(_Interview) _then;

/// Create a copy of Interview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? companyName = null,Object? role = null,Object? dateTime = null,Object? meetingUrl = freezed,}) {
  return _then(_Interview(
companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,meetingUrl: freezed == meetingUrl ? _self.meetingUrl : meetingUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
