// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApplicationStats {

 int get totalApplications; int get activeApplications; int get interviewsScheduled; int get offersReceived; int get advancedApplications;
/// Create a copy of ApplicationStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationStatsCopyWith<ApplicationStats> get copyWith => _$ApplicationStatsCopyWithImpl<ApplicationStats>(this as ApplicationStats, _$identity);

  /// Serializes this ApplicationStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationStats&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&(identical(other.activeApplications, activeApplications) || other.activeApplications == activeApplications)&&(identical(other.interviewsScheduled, interviewsScheduled) || other.interviewsScheduled == interviewsScheduled)&&(identical(other.offersReceived, offersReceived) || other.offersReceived == offersReceived)&&(identical(other.advancedApplications, advancedApplications) || other.advancedApplications == advancedApplications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalApplications,activeApplications,interviewsScheduled,offersReceived,advancedApplications);

@override
String toString() {
  return 'ApplicationStats(totalApplications: $totalApplications, activeApplications: $activeApplications, interviewsScheduled: $interviewsScheduled, offersReceived: $offersReceived, advancedApplications: $advancedApplications)';
}


}

/// @nodoc
abstract mixin class $ApplicationStatsCopyWith<$Res>  {
  factory $ApplicationStatsCopyWith(ApplicationStats value, $Res Function(ApplicationStats) _then) = _$ApplicationStatsCopyWithImpl;
@useResult
$Res call({
 int totalApplications, int activeApplications, int interviewsScheduled, int offersReceived, int advancedApplications
});




}
/// @nodoc
class _$ApplicationStatsCopyWithImpl<$Res>
    implements $ApplicationStatsCopyWith<$Res> {
  _$ApplicationStatsCopyWithImpl(this._self, this._then);

  final ApplicationStats _self;
  final $Res Function(ApplicationStats) _then;

/// Create a copy of ApplicationStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalApplications = null,Object? activeApplications = null,Object? interviewsScheduled = null,Object? offersReceived = null,Object? advancedApplications = null,}) {
  return _then(_self.copyWith(
totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,activeApplications: null == activeApplications ? _self.activeApplications : activeApplications // ignore: cast_nullable_to_non_nullable
as int,interviewsScheduled: null == interviewsScheduled ? _self.interviewsScheduled : interviewsScheduled // ignore: cast_nullable_to_non_nullable
as int,offersReceived: null == offersReceived ? _self.offersReceived : offersReceived // ignore: cast_nullable_to_non_nullable
as int,advancedApplications: null == advancedApplications ? _self.advancedApplications : advancedApplications // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplicationStats].
extension ApplicationStatsPatterns on ApplicationStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplicationStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplicationStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplicationStats value)  $default,){
final _that = this;
switch (_that) {
case _ApplicationStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplicationStats value)?  $default,){
final _that = this;
switch (_that) {
case _ApplicationStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalApplications,  int activeApplications,  int interviewsScheduled,  int offersReceived,  int advancedApplications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplicationStats() when $default != null:
return $default(_that.totalApplications,_that.activeApplications,_that.interviewsScheduled,_that.offersReceived,_that.advancedApplications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalApplications,  int activeApplications,  int interviewsScheduled,  int offersReceived,  int advancedApplications)  $default,) {final _that = this;
switch (_that) {
case _ApplicationStats():
return $default(_that.totalApplications,_that.activeApplications,_that.interviewsScheduled,_that.offersReceived,_that.advancedApplications);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalApplications,  int activeApplications,  int interviewsScheduled,  int offersReceived,  int advancedApplications)?  $default,) {final _that = this;
switch (_that) {
case _ApplicationStats() when $default != null:
return $default(_that.totalApplications,_that.activeApplications,_that.interviewsScheduled,_that.offersReceived,_that.advancedApplications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplicationStats extends ApplicationStats {
  const _ApplicationStats({required this.totalApplications, required this.activeApplications, required this.interviewsScheduled, required this.offersReceived, required this.advancedApplications}): super._();
  factory _ApplicationStats.fromJson(Map<String, dynamic> json) => _$ApplicationStatsFromJson(json);

@override final  int totalApplications;
@override final  int activeApplications;
@override final  int interviewsScheduled;
@override final  int offersReceived;
@override final  int advancedApplications;

/// Create a copy of ApplicationStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationStatsCopyWith<_ApplicationStats> get copyWith => __$ApplicationStatsCopyWithImpl<_ApplicationStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplicationStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationStats&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&(identical(other.activeApplications, activeApplications) || other.activeApplications == activeApplications)&&(identical(other.interviewsScheduled, interviewsScheduled) || other.interviewsScheduled == interviewsScheduled)&&(identical(other.offersReceived, offersReceived) || other.offersReceived == offersReceived)&&(identical(other.advancedApplications, advancedApplications) || other.advancedApplications == advancedApplications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalApplications,activeApplications,interviewsScheduled,offersReceived,advancedApplications);

@override
String toString() {
  return 'ApplicationStats(totalApplications: $totalApplications, activeApplications: $activeApplications, interviewsScheduled: $interviewsScheduled, offersReceived: $offersReceived, advancedApplications: $advancedApplications)';
}


}

/// @nodoc
abstract mixin class _$ApplicationStatsCopyWith<$Res> implements $ApplicationStatsCopyWith<$Res> {
  factory _$ApplicationStatsCopyWith(_ApplicationStats value, $Res Function(_ApplicationStats) _then) = __$ApplicationStatsCopyWithImpl;
@override @useResult
$Res call({
 int totalApplications, int activeApplications, int interviewsScheduled, int offersReceived, int advancedApplications
});




}
/// @nodoc
class __$ApplicationStatsCopyWithImpl<$Res>
    implements _$ApplicationStatsCopyWith<$Res> {
  __$ApplicationStatsCopyWithImpl(this._self, this._then);

  final _ApplicationStats _self;
  final $Res Function(_ApplicationStats) _then;

/// Create a copy of ApplicationStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalApplications = null,Object? activeApplications = null,Object? interviewsScheduled = null,Object? offersReceived = null,Object? advancedApplications = null,}) {
  return _then(_ApplicationStats(
totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,activeApplications: null == activeApplications ? _self.activeApplications : activeApplications // ignore: cast_nullable_to_non_nullable
as int,interviewsScheduled: null == interviewsScheduled ? _self.interviewsScheduled : interviewsScheduled // ignore: cast_nullable_to_non_nullable
as int,offersReceived: null == offersReceived ? _self.offersReceived : offersReceived // ignore: cast_nullable_to_non_nullable
as int,advancedApplications: null == advancedApplications ? _self.advancedApplications : advancedApplications // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
