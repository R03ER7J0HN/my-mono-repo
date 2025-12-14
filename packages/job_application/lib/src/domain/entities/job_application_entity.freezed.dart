// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_application_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JobApplicationEntity {

 String get id; String get userId; String get companyName; String get jobTitle; String get jobLink; JobPlatform get platform; WorkSetup get workSetup; EmploymentType get employmentType; DateTime get dateApplied; String? get recruiterName; JobLocationEntity? get location; int? get salaryRequested; String? get currency;// e.g. "USD", "EUR"
 String? get notes; List<DateTime> get interviewDates; List<DateTime> get deadlines; JobStatus get status;
/// Create a copy of JobApplicationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobApplicationEntityCopyWith<JobApplicationEntity> get copyWith => _$JobApplicationEntityCopyWithImpl<JobApplicationEntity>(this as JobApplicationEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobApplicationEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.jobLink, jobLink) || other.jobLink == jobLink)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.workSetup, workSetup) || other.workSetup == workSetup)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.dateApplied, dateApplied) || other.dateApplied == dateApplied)&&(identical(other.recruiterName, recruiterName) || other.recruiterName == recruiterName)&&(identical(other.location, location) || other.location == location)&&(identical(other.salaryRequested, salaryRequested) || other.salaryRequested == salaryRequested)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.interviewDates, interviewDates)&&const DeepCollectionEquality().equals(other.deadlines, deadlines)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,companyName,jobTitle,jobLink,platform,workSetup,employmentType,dateApplied,recruiterName,location,salaryRequested,currency,notes,const DeepCollectionEquality().hash(interviewDates),const DeepCollectionEquality().hash(deadlines),status);

@override
String toString() {
  return 'JobApplicationEntity(id: $id, userId: $userId, companyName: $companyName, jobTitle: $jobTitle, jobLink: $jobLink, platform: $platform, workSetup: $workSetup, employmentType: $employmentType, dateApplied: $dateApplied, recruiterName: $recruiterName, location: $location, salaryRequested: $salaryRequested, currency: $currency, notes: $notes, interviewDates: $interviewDates, deadlines: $deadlines, status: $status)';
}


}

/// @nodoc
abstract mixin class $JobApplicationEntityCopyWith<$Res>  {
  factory $JobApplicationEntityCopyWith(JobApplicationEntity value, $Res Function(JobApplicationEntity) _then) = _$JobApplicationEntityCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String companyName, String jobTitle, String jobLink, JobPlatform platform, WorkSetup workSetup, EmploymentType employmentType, DateTime dateApplied, String? recruiterName, JobLocationEntity? location, int? salaryRequested, String? currency, String? notes, List<DateTime> interviewDates, List<DateTime> deadlines, JobStatus status
});


$JobLocationEntityCopyWith<$Res>? get location;

}
/// @nodoc
class _$JobApplicationEntityCopyWithImpl<$Res>
    implements $JobApplicationEntityCopyWith<$Res> {
  _$JobApplicationEntityCopyWithImpl(this._self, this._then);

  final JobApplicationEntity _self;
  final $Res Function(JobApplicationEntity) _then;

/// Create a copy of JobApplicationEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? companyName = null,Object? jobTitle = null,Object? jobLink = null,Object? platform = null,Object? workSetup = null,Object? employmentType = null,Object? dateApplied = null,Object? recruiterName = freezed,Object? location = freezed,Object? salaryRequested = freezed,Object? currency = freezed,Object? notes = freezed,Object? interviewDates = null,Object? deadlines = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,jobLink: null == jobLink ? _self.jobLink : jobLink // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as JobPlatform,workSetup: null == workSetup ? _self.workSetup : workSetup // ignore: cast_nullable_to_non_nullable
as WorkSetup,employmentType: null == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as EmploymentType,dateApplied: null == dateApplied ? _self.dateApplied : dateApplied // ignore: cast_nullable_to_non_nullable
as DateTime,recruiterName: freezed == recruiterName ? _self.recruiterName : recruiterName // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as JobLocationEntity?,salaryRequested: freezed == salaryRequested ? _self.salaryRequested : salaryRequested // ignore: cast_nullable_to_non_nullable
as int?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,interviewDates: null == interviewDates ? _self.interviewDates : interviewDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,deadlines: null == deadlines ? _self.deadlines : deadlines // ignore: cast_nullable_to_non_nullable
as List<DateTime>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,
  ));
}
/// Create a copy of JobApplicationEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobLocationEntityCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $JobLocationEntityCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [JobApplicationEntity].
extension JobApplicationEntityPatterns on JobApplicationEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobApplicationEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobApplicationEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobApplicationEntity value)  $default,){
final _that = this;
switch (_that) {
case _JobApplicationEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobApplicationEntity value)?  $default,){
final _that = this;
switch (_that) {
case _JobApplicationEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String companyName,  String jobTitle,  String jobLink,  JobPlatform platform,  WorkSetup workSetup,  EmploymentType employmentType,  DateTime dateApplied,  String? recruiterName,  JobLocationEntity? location,  int? salaryRequested,  String? currency,  String? notes,  List<DateTime> interviewDates,  List<DateTime> deadlines,  JobStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobApplicationEntity() when $default != null:
return $default(_that.id,_that.userId,_that.companyName,_that.jobTitle,_that.jobLink,_that.platform,_that.workSetup,_that.employmentType,_that.dateApplied,_that.recruiterName,_that.location,_that.salaryRequested,_that.currency,_that.notes,_that.interviewDates,_that.deadlines,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String companyName,  String jobTitle,  String jobLink,  JobPlatform platform,  WorkSetup workSetup,  EmploymentType employmentType,  DateTime dateApplied,  String? recruiterName,  JobLocationEntity? location,  int? salaryRequested,  String? currency,  String? notes,  List<DateTime> interviewDates,  List<DateTime> deadlines,  JobStatus status)  $default,) {final _that = this;
switch (_that) {
case _JobApplicationEntity():
return $default(_that.id,_that.userId,_that.companyName,_that.jobTitle,_that.jobLink,_that.platform,_that.workSetup,_that.employmentType,_that.dateApplied,_that.recruiterName,_that.location,_that.salaryRequested,_that.currency,_that.notes,_that.interviewDates,_that.deadlines,_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String companyName,  String jobTitle,  String jobLink,  JobPlatform platform,  WorkSetup workSetup,  EmploymentType employmentType,  DateTime dateApplied,  String? recruiterName,  JobLocationEntity? location,  int? salaryRequested,  String? currency,  String? notes,  List<DateTime> interviewDates,  List<DateTime> deadlines,  JobStatus status)?  $default,) {final _that = this;
switch (_that) {
case _JobApplicationEntity() when $default != null:
return $default(_that.id,_that.userId,_that.companyName,_that.jobTitle,_that.jobLink,_that.platform,_that.workSetup,_that.employmentType,_that.dateApplied,_that.recruiterName,_that.location,_that.salaryRequested,_that.currency,_that.notes,_that.interviewDates,_that.deadlines,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _JobApplicationEntity implements JobApplicationEntity {
  const _JobApplicationEntity({required this.id, required this.userId, required this.companyName, required this.jobTitle, required this.jobLink, required this.platform, required this.workSetup, required this.employmentType, required this.dateApplied, this.recruiterName, this.location, this.salaryRequested, this.currency, this.notes, final  List<DateTime> interviewDates = const [], final  List<DateTime> deadlines = const [], this.status = JobStatus.applied}): _interviewDates = interviewDates,_deadlines = deadlines;
  

@override final  String id;
@override final  String userId;
@override final  String companyName;
@override final  String jobTitle;
@override final  String jobLink;
@override final  JobPlatform platform;
@override final  WorkSetup workSetup;
@override final  EmploymentType employmentType;
@override final  DateTime dateApplied;
@override final  String? recruiterName;
@override final  JobLocationEntity? location;
@override final  int? salaryRequested;
@override final  String? currency;
// e.g. "USD", "EUR"
@override final  String? notes;
 final  List<DateTime> _interviewDates;
@override@JsonKey() List<DateTime> get interviewDates {
  if (_interviewDates is EqualUnmodifiableListView) return _interviewDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interviewDates);
}

 final  List<DateTime> _deadlines;
@override@JsonKey() List<DateTime> get deadlines {
  if (_deadlines is EqualUnmodifiableListView) return _deadlines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_deadlines);
}

@override@JsonKey() final  JobStatus status;

/// Create a copy of JobApplicationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobApplicationEntityCopyWith<_JobApplicationEntity> get copyWith => __$JobApplicationEntityCopyWithImpl<_JobApplicationEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobApplicationEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.jobLink, jobLink) || other.jobLink == jobLink)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.workSetup, workSetup) || other.workSetup == workSetup)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.dateApplied, dateApplied) || other.dateApplied == dateApplied)&&(identical(other.recruiterName, recruiterName) || other.recruiterName == recruiterName)&&(identical(other.location, location) || other.location == location)&&(identical(other.salaryRequested, salaryRequested) || other.salaryRequested == salaryRequested)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._interviewDates, _interviewDates)&&const DeepCollectionEquality().equals(other._deadlines, _deadlines)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,companyName,jobTitle,jobLink,platform,workSetup,employmentType,dateApplied,recruiterName,location,salaryRequested,currency,notes,const DeepCollectionEquality().hash(_interviewDates),const DeepCollectionEquality().hash(_deadlines),status);

@override
String toString() {
  return 'JobApplicationEntity(id: $id, userId: $userId, companyName: $companyName, jobTitle: $jobTitle, jobLink: $jobLink, platform: $platform, workSetup: $workSetup, employmentType: $employmentType, dateApplied: $dateApplied, recruiterName: $recruiterName, location: $location, salaryRequested: $salaryRequested, currency: $currency, notes: $notes, interviewDates: $interviewDates, deadlines: $deadlines, status: $status)';
}


}

/// @nodoc
abstract mixin class _$JobApplicationEntityCopyWith<$Res> implements $JobApplicationEntityCopyWith<$Res> {
  factory _$JobApplicationEntityCopyWith(_JobApplicationEntity value, $Res Function(_JobApplicationEntity) _then) = __$JobApplicationEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String companyName, String jobTitle, String jobLink, JobPlatform platform, WorkSetup workSetup, EmploymentType employmentType, DateTime dateApplied, String? recruiterName, JobLocationEntity? location, int? salaryRequested, String? currency, String? notes, List<DateTime> interviewDates, List<DateTime> deadlines, JobStatus status
});


@override $JobLocationEntityCopyWith<$Res>? get location;

}
/// @nodoc
class __$JobApplicationEntityCopyWithImpl<$Res>
    implements _$JobApplicationEntityCopyWith<$Res> {
  __$JobApplicationEntityCopyWithImpl(this._self, this._then);

  final _JobApplicationEntity _self;
  final $Res Function(_JobApplicationEntity) _then;

/// Create a copy of JobApplicationEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? companyName = null,Object? jobTitle = null,Object? jobLink = null,Object? platform = null,Object? workSetup = null,Object? employmentType = null,Object? dateApplied = null,Object? recruiterName = freezed,Object? location = freezed,Object? salaryRequested = freezed,Object? currency = freezed,Object? notes = freezed,Object? interviewDates = null,Object? deadlines = null,Object? status = null,}) {
  return _then(_JobApplicationEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,jobLink: null == jobLink ? _self.jobLink : jobLink // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as JobPlatform,workSetup: null == workSetup ? _self.workSetup : workSetup // ignore: cast_nullable_to_non_nullable
as WorkSetup,employmentType: null == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as EmploymentType,dateApplied: null == dateApplied ? _self.dateApplied : dateApplied // ignore: cast_nullable_to_non_nullable
as DateTime,recruiterName: freezed == recruiterName ? _self.recruiterName : recruiterName // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as JobLocationEntity?,salaryRequested: freezed == salaryRequested ? _self.salaryRequested : salaryRequested // ignore: cast_nullable_to_non_nullable
as int?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,interviewDates: null == interviewDates ? _self._interviewDates : interviewDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,deadlines: null == deadlines ? _self._deadlines : deadlines // ignore: cast_nullable_to_non_nullable
as List<DateTime>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,
  ));
}

/// Create a copy of JobApplicationEntity
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobLocationEntityCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $JobLocationEntityCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

/// @nodoc
mixin _$JobLocationEntity {

 String get address; double? get latitude; double? get longitude; String? get placeId;
/// Create a copy of JobLocationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobLocationEntityCopyWith<JobLocationEntity> get copyWith => _$JobLocationEntityCopyWithImpl<JobLocationEntity>(this as JobLocationEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobLocationEntity&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.placeId, placeId) || other.placeId == placeId));
}


@override
int get hashCode => Object.hash(runtimeType,address,latitude,longitude,placeId);

@override
String toString() {
  return 'JobLocationEntity(address: $address, latitude: $latitude, longitude: $longitude, placeId: $placeId)';
}


}

/// @nodoc
abstract mixin class $JobLocationEntityCopyWith<$Res>  {
  factory $JobLocationEntityCopyWith(JobLocationEntity value, $Res Function(JobLocationEntity) _then) = _$JobLocationEntityCopyWithImpl;
@useResult
$Res call({
 String address, double? latitude, double? longitude, String? placeId
});




}
/// @nodoc
class _$JobLocationEntityCopyWithImpl<$Res>
    implements $JobLocationEntityCopyWith<$Res> {
  _$JobLocationEntityCopyWithImpl(this._self, this._then);

  final JobLocationEntity _self;
  final $Res Function(JobLocationEntity) _then;

/// Create a copy of JobLocationEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? latitude = freezed,Object? longitude = freezed,Object? placeId = freezed,}) {
  return _then(_self.copyWith(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobLocationEntity].
extension JobLocationEntityPatterns on JobLocationEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobLocationEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobLocationEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobLocationEntity value)  $default,){
final _that = this;
switch (_that) {
case _JobLocationEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobLocationEntity value)?  $default,){
final _that = this;
switch (_that) {
case _JobLocationEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String address,  double? latitude,  double? longitude,  String? placeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobLocationEntity() when $default != null:
return $default(_that.address,_that.latitude,_that.longitude,_that.placeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String address,  double? latitude,  double? longitude,  String? placeId)  $default,) {final _that = this;
switch (_that) {
case _JobLocationEntity():
return $default(_that.address,_that.latitude,_that.longitude,_that.placeId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String address,  double? latitude,  double? longitude,  String? placeId)?  $default,) {final _that = this;
switch (_that) {
case _JobLocationEntity() when $default != null:
return $default(_that.address,_that.latitude,_that.longitude,_that.placeId);case _:
  return null;

}
}

}

/// @nodoc


class _JobLocationEntity implements JobLocationEntity {
  const _JobLocationEntity({required this.address, this.latitude, this.longitude, this.placeId});
  

@override final  String address;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? placeId;

/// Create a copy of JobLocationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobLocationEntityCopyWith<_JobLocationEntity> get copyWith => __$JobLocationEntityCopyWithImpl<_JobLocationEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobLocationEntity&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.placeId, placeId) || other.placeId == placeId));
}


@override
int get hashCode => Object.hash(runtimeType,address,latitude,longitude,placeId);

@override
String toString() {
  return 'JobLocationEntity(address: $address, latitude: $latitude, longitude: $longitude, placeId: $placeId)';
}


}

/// @nodoc
abstract mixin class _$JobLocationEntityCopyWith<$Res> implements $JobLocationEntityCopyWith<$Res> {
  factory _$JobLocationEntityCopyWith(_JobLocationEntity value, $Res Function(_JobLocationEntity) _then) = __$JobLocationEntityCopyWithImpl;
@override @useResult
$Res call({
 String address, double? latitude, double? longitude, String? placeId
});




}
/// @nodoc
class __$JobLocationEntityCopyWithImpl<$Res>
    implements _$JobLocationEntityCopyWith<$Res> {
  __$JobLocationEntityCopyWithImpl(this._self, this._then);

  final _JobLocationEntity _self;
  final $Res Function(_JobLocationEntity) _then;

/// Create a copy of JobLocationEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? latitude = freezed,Object? longitude = freezed,Object? placeId = freezed,}) {
  return _then(_JobLocationEntity(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
