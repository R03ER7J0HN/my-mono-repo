// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JobListState {

 List<JobApplicationEntity> get jobs; bool? get isLoading; String? get errorMessage;
/// Create a copy of JobListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobListStateCopyWith<JobListState> get copyWith => _$JobListStateCopyWithImpl<JobListState>(this as JobListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobListState&&const DeepCollectionEquality().equals(other.jobs, jobs)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(jobs),isLoading,errorMessage);

@override
String toString() {
  return 'JobListState(jobs: $jobs, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $JobListStateCopyWith<$Res>  {
  factory $JobListStateCopyWith(JobListState value, $Res Function(JobListState) _then) = _$JobListStateCopyWithImpl;
@useResult
$Res call({
 List<JobApplicationEntity> jobs, bool? isLoading, String? errorMessage
});




}
/// @nodoc
class _$JobListStateCopyWithImpl<$Res>
    implements $JobListStateCopyWith<$Res> {
  _$JobListStateCopyWithImpl(this._self, this._then);

  final JobListState _self;
  final $Res Function(JobListState) _then;

/// Create a copy of JobListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jobs = null,Object? isLoading = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
jobs: null == jobs ? _self.jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<JobApplicationEntity>,isLoading: freezed == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobListState].
extension JobListStatePatterns on JobListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobListState value)  $default,){
final _that = this;
switch (_that) {
case _JobListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobListState value)?  $default,){
final _that = this;
switch (_that) {
case _JobListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<JobApplicationEntity> jobs,  bool? isLoading,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobListState() when $default != null:
return $default(_that.jobs,_that.isLoading,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<JobApplicationEntity> jobs,  bool? isLoading,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _JobListState():
return $default(_that.jobs,_that.isLoading,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<JobApplicationEntity> jobs,  bool? isLoading,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _JobListState() when $default != null:
return $default(_that.jobs,_that.isLoading,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _JobListState implements JobListState {
  const _JobListState(final  List<JobApplicationEntity> jobs, {this.isLoading = false, this.errorMessage}): _jobs = jobs;
  

 final  List<JobApplicationEntity> _jobs;
@override List<JobApplicationEntity> get jobs {
  if (_jobs is EqualUnmodifiableListView) return _jobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobs);
}

@override@JsonKey() final  bool? isLoading;
@override final  String? errorMessage;

/// Create a copy of JobListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobListStateCopyWith<_JobListState> get copyWith => __$JobListStateCopyWithImpl<_JobListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobListState&&const DeepCollectionEquality().equals(other._jobs, _jobs)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_jobs),isLoading,errorMessage);

@override
String toString() {
  return 'JobListState(jobs: $jobs, isLoading: $isLoading, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$JobListStateCopyWith<$Res> implements $JobListStateCopyWith<$Res> {
  factory _$JobListStateCopyWith(_JobListState value, $Res Function(_JobListState) _then) = __$JobListStateCopyWithImpl;
@override @useResult
$Res call({
 List<JobApplicationEntity> jobs, bool? isLoading, String? errorMessage
});




}
/// @nodoc
class __$JobListStateCopyWithImpl<$Res>
    implements _$JobListStateCopyWith<$Res> {
  __$JobListStateCopyWithImpl(this._self, this._then);

  final _JobListState _self;
  final $Res Function(_JobListState) _then;

/// Create a copy of JobListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobs = null,Object? isLoading = freezed,Object? errorMessage = freezed,}) {
  return _then(_JobListState(
null == jobs ? _self._jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<JobApplicationEntity>,isLoading: freezed == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
