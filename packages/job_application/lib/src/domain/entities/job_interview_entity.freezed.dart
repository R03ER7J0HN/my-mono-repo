// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_interview_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JobInterviewEntity {

/// Unique identifier for the interview document.
 String get id;/// The ID of the job application this interview belongs to.
 String get jobApplicationId;/// The ID of the user who owns this interview.
 String get userId;/// Title/type of the interview (e.g., "Phone Screening", "Technical Round").
 String get title;/// The scheduled start date and time of the interview.
 DateTime get startTime;/// Optional end time of the interview.
 DateTime? get endTime;/// Optional meeting URL (e.g., Zoom, Google Meet, Teams link).
 String? get meetingUrl;/// Optional physical location for in-person interviews.
 String? get location;/// Optional additional notes about the interview.
 String? get notes;/// Whether this interview has been added to the device calendar.
 bool get addedToCalendar;
/// Create a copy of JobInterviewEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobInterviewEntityCopyWith<JobInterviewEntity> get copyWith => _$JobInterviewEntityCopyWithImpl<JobInterviewEntity>(this as JobInterviewEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobInterviewEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.jobApplicationId, jobApplicationId) || other.jobApplicationId == jobApplicationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.meetingUrl, meetingUrl) || other.meetingUrl == meetingUrl)&&(identical(other.location, location) || other.location == location)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.addedToCalendar, addedToCalendar) || other.addedToCalendar == addedToCalendar));
}


@override
int get hashCode => Object.hash(runtimeType,id,jobApplicationId,userId,title,startTime,endTime,meetingUrl,location,notes,addedToCalendar);

@override
String toString() {
  return 'JobInterviewEntity(id: $id, jobApplicationId: $jobApplicationId, userId: $userId, title: $title, startTime: $startTime, endTime: $endTime, meetingUrl: $meetingUrl, location: $location, notes: $notes, addedToCalendar: $addedToCalendar)';
}


}

/// @nodoc
abstract mixin class $JobInterviewEntityCopyWith<$Res>  {
  factory $JobInterviewEntityCopyWith(JobInterviewEntity value, $Res Function(JobInterviewEntity) _then) = _$JobInterviewEntityCopyWithImpl;
@useResult
$Res call({
 String id, String jobApplicationId, String userId, String title, DateTime startTime, DateTime? endTime, String? meetingUrl, String? location, String? notes, bool addedToCalendar
});




}
/// @nodoc
class _$JobInterviewEntityCopyWithImpl<$Res>
    implements $JobInterviewEntityCopyWith<$Res> {
  _$JobInterviewEntityCopyWithImpl(this._self, this._then);

  final JobInterviewEntity _self;
  final $Res Function(JobInterviewEntity) _then;

/// Create a copy of JobInterviewEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jobApplicationId = null,Object? userId = null,Object? title = null,Object? startTime = null,Object? endTime = freezed,Object? meetingUrl = freezed,Object? location = freezed,Object? notes = freezed,Object? addedToCalendar = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobApplicationId: null == jobApplicationId ? _self.jobApplicationId : jobApplicationId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,meetingUrl: freezed == meetingUrl ? _self.meetingUrl : meetingUrl // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,addedToCalendar: null == addedToCalendar ? _self.addedToCalendar : addedToCalendar // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [JobInterviewEntity].
extension JobInterviewEntityPatterns on JobInterviewEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobInterviewEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobInterviewEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobInterviewEntity value)  $default,){
final _that = this;
switch (_that) {
case _JobInterviewEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobInterviewEntity value)?  $default,){
final _that = this;
switch (_that) {
case _JobInterviewEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String jobApplicationId,  String userId,  String title,  DateTime startTime,  DateTime? endTime,  String? meetingUrl,  String? location,  String? notes,  bool addedToCalendar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobInterviewEntity() when $default != null:
return $default(_that.id,_that.jobApplicationId,_that.userId,_that.title,_that.startTime,_that.endTime,_that.meetingUrl,_that.location,_that.notes,_that.addedToCalendar);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String jobApplicationId,  String userId,  String title,  DateTime startTime,  DateTime? endTime,  String? meetingUrl,  String? location,  String? notes,  bool addedToCalendar)  $default,) {final _that = this;
switch (_that) {
case _JobInterviewEntity():
return $default(_that.id,_that.jobApplicationId,_that.userId,_that.title,_that.startTime,_that.endTime,_that.meetingUrl,_that.location,_that.notes,_that.addedToCalendar);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String jobApplicationId,  String userId,  String title,  DateTime startTime,  DateTime? endTime,  String? meetingUrl,  String? location,  String? notes,  bool addedToCalendar)?  $default,) {final _that = this;
switch (_that) {
case _JobInterviewEntity() when $default != null:
return $default(_that.id,_that.jobApplicationId,_that.userId,_that.title,_that.startTime,_that.endTime,_that.meetingUrl,_that.location,_that.notes,_that.addedToCalendar);case _:
  return null;

}
}

}

/// @nodoc


class _JobInterviewEntity implements JobInterviewEntity {
  const _JobInterviewEntity({required this.id, required this.jobApplicationId, required this.userId, required this.title, required this.startTime, this.endTime, this.meetingUrl, this.location, this.notes, this.addedToCalendar = false});
  

/// Unique identifier for the interview document.
@override final  String id;
/// The ID of the job application this interview belongs to.
@override final  String jobApplicationId;
/// The ID of the user who owns this interview.
@override final  String userId;
/// Title/type of the interview (e.g., "Phone Screening", "Technical Round").
@override final  String title;
/// The scheduled start date and time of the interview.
@override final  DateTime startTime;
/// Optional end time of the interview.
@override final  DateTime? endTime;
/// Optional meeting URL (e.g., Zoom, Google Meet, Teams link).
@override final  String? meetingUrl;
/// Optional physical location for in-person interviews.
@override final  String? location;
/// Optional additional notes about the interview.
@override final  String? notes;
/// Whether this interview has been added to the device calendar.
@override@JsonKey() final  bool addedToCalendar;

/// Create a copy of JobInterviewEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobInterviewEntityCopyWith<_JobInterviewEntity> get copyWith => __$JobInterviewEntityCopyWithImpl<_JobInterviewEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobInterviewEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.jobApplicationId, jobApplicationId) || other.jobApplicationId == jobApplicationId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.meetingUrl, meetingUrl) || other.meetingUrl == meetingUrl)&&(identical(other.location, location) || other.location == location)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.addedToCalendar, addedToCalendar) || other.addedToCalendar == addedToCalendar));
}


@override
int get hashCode => Object.hash(runtimeType,id,jobApplicationId,userId,title,startTime,endTime,meetingUrl,location,notes,addedToCalendar);

@override
String toString() {
  return 'JobInterviewEntity(id: $id, jobApplicationId: $jobApplicationId, userId: $userId, title: $title, startTime: $startTime, endTime: $endTime, meetingUrl: $meetingUrl, location: $location, notes: $notes, addedToCalendar: $addedToCalendar)';
}


}

/// @nodoc
abstract mixin class _$JobInterviewEntityCopyWith<$Res> implements $JobInterviewEntityCopyWith<$Res> {
  factory _$JobInterviewEntityCopyWith(_JobInterviewEntity value, $Res Function(_JobInterviewEntity) _then) = __$JobInterviewEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String jobApplicationId, String userId, String title, DateTime startTime, DateTime? endTime, String? meetingUrl, String? location, String? notes, bool addedToCalendar
});




}
/// @nodoc
class __$JobInterviewEntityCopyWithImpl<$Res>
    implements _$JobInterviewEntityCopyWith<$Res> {
  __$JobInterviewEntityCopyWithImpl(this._self, this._then);

  final _JobInterviewEntity _self;
  final $Res Function(_JobInterviewEntity) _then;

/// Create a copy of JobInterviewEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jobApplicationId = null,Object? userId = null,Object? title = null,Object? startTime = null,Object? endTime = freezed,Object? meetingUrl = freezed,Object? location = freezed,Object? notes = freezed,Object? addedToCalendar = null,}) {
  return _then(_JobInterviewEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobApplicationId: null == jobApplicationId ? _self.jobApplicationId : jobApplicationId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,meetingUrl: freezed == meetingUrl ? _self.meetingUrl : meetingUrl // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,addedToCalendar: null == addedToCalendar ? _self.addedToCalendar : addedToCalendar // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
