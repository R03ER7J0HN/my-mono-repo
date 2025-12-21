// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'places_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlacesSearchState {

/// List of place predictions from the search.
 List<PlacePredictionEntity> get predictions;/// Whether a search is in progress.
 bool get isSearching;/// Whether place details are being fetched.
 bool get isFetchingDetails;/// The selected place details (after user selects a prediction).
 PlaceDetailsEntity? get selectedPlace;/// Error message if an operation failed.
 String? get errorMessage;
/// Create a copy of PlacesSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacesSearchStateCopyWith<PlacesSearchState> get copyWith => _$PlacesSearchStateCopyWithImpl<PlacesSearchState>(this as PlacesSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacesSearchState&&const DeepCollectionEquality().equals(other.predictions, predictions)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.isFetchingDetails, isFetchingDetails) || other.isFetchingDetails == isFetchingDetails)&&(identical(other.selectedPlace, selectedPlace) || other.selectedPlace == selectedPlace)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(predictions),isSearching,isFetchingDetails,selectedPlace,errorMessage);

@override
String toString() {
  return 'PlacesSearchState(predictions: $predictions, isSearching: $isSearching, isFetchingDetails: $isFetchingDetails, selectedPlace: $selectedPlace, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PlacesSearchStateCopyWith<$Res>  {
  factory $PlacesSearchStateCopyWith(PlacesSearchState value, $Res Function(PlacesSearchState) _then) = _$PlacesSearchStateCopyWithImpl;
@useResult
$Res call({
 List<PlacePredictionEntity> predictions, bool isSearching, bool isFetchingDetails, PlaceDetailsEntity? selectedPlace, String? errorMessage
});




}
/// @nodoc
class _$PlacesSearchStateCopyWithImpl<$Res>
    implements $PlacesSearchStateCopyWith<$Res> {
  _$PlacesSearchStateCopyWithImpl(this._self, this._then);

  final PlacesSearchState _self;
  final $Res Function(PlacesSearchState) _then;

/// Create a copy of PlacesSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? predictions = null,Object? isSearching = null,Object? isFetchingDetails = null,Object? selectedPlace = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
predictions: null == predictions ? _self.predictions : predictions // ignore: cast_nullable_to_non_nullable
as List<PlacePredictionEntity>,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,isFetchingDetails: null == isFetchingDetails ? _self.isFetchingDetails : isFetchingDetails // ignore: cast_nullable_to_non_nullable
as bool,selectedPlace: freezed == selectedPlace ? _self.selectedPlace : selectedPlace // ignore: cast_nullable_to_non_nullable
as PlaceDetailsEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlacesSearchState].
extension PlacesSearchStatePatterns on PlacesSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacesSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacesSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacesSearchState value)  $default,){
final _that = this;
switch (_that) {
case _PlacesSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacesSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _PlacesSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PlacePredictionEntity> predictions,  bool isSearching,  bool isFetchingDetails,  PlaceDetailsEntity? selectedPlace,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacesSearchState() when $default != null:
return $default(_that.predictions,_that.isSearching,_that.isFetchingDetails,_that.selectedPlace,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PlacePredictionEntity> predictions,  bool isSearching,  bool isFetchingDetails,  PlaceDetailsEntity? selectedPlace,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PlacesSearchState():
return $default(_that.predictions,_that.isSearching,_that.isFetchingDetails,_that.selectedPlace,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PlacePredictionEntity> predictions,  bool isSearching,  bool isFetchingDetails,  PlaceDetailsEntity? selectedPlace,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PlacesSearchState() when $default != null:
return $default(_that.predictions,_that.isSearching,_that.isFetchingDetails,_that.selectedPlace,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PlacesSearchState implements PlacesSearchState {
  const _PlacesSearchState({final  List<PlacePredictionEntity> predictions = const [], this.isSearching = false, this.isFetchingDetails = false, this.selectedPlace, this.errorMessage}): _predictions = predictions;
  

/// List of place predictions from the search.
 final  List<PlacePredictionEntity> _predictions;
/// List of place predictions from the search.
@override@JsonKey() List<PlacePredictionEntity> get predictions {
  if (_predictions is EqualUnmodifiableListView) return _predictions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_predictions);
}

/// Whether a search is in progress.
@override@JsonKey() final  bool isSearching;
/// Whether place details are being fetched.
@override@JsonKey() final  bool isFetchingDetails;
/// The selected place details (after user selects a prediction).
@override final  PlaceDetailsEntity? selectedPlace;
/// Error message if an operation failed.
@override final  String? errorMessage;

/// Create a copy of PlacesSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacesSearchStateCopyWith<_PlacesSearchState> get copyWith => __$PlacesSearchStateCopyWithImpl<_PlacesSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacesSearchState&&const DeepCollectionEquality().equals(other._predictions, _predictions)&&(identical(other.isSearching, isSearching) || other.isSearching == isSearching)&&(identical(other.isFetchingDetails, isFetchingDetails) || other.isFetchingDetails == isFetchingDetails)&&(identical(other.selectedPlace, selectedPlace) || other.selectedPlace == selectedPlace)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_predictions),isSearching,isFetchingDetails,selectedPlace,errorMessage);

@override
String toString() {
  return 'PlacesSearchState(predictions: $predictions, isSearching: $isSearching, isFetchingDetails: $isFetchingDetails, selectedPlace: $selectedPlace, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PlacesSearchStateCopyWith<$Res> implements $PlacesSearchStateCopyWith<$Res> {
  factory _$PlacesSearchStateCopyWith(_PlacesSearchState value, $Res Function(_PlacesSearchState) _then) = __$PlacesSearchStateCopyWithImpl;
@override @useResult
$Res call({
 List<PlacePredictionEntity> predictions, bool isSearching, bool isFetchingDetails, PlaceDetailsEntity? selectedPlace, String? errorMessage
});




}
/// @nodoc
class __$PlacesSearchStateCopyWithImpl<$Res>
    implements _$PlacesSearchStateCopyWith<$Res> {
  __$PlacesSearchStateCopyWithImpl(this._self, this._then);

  final _PlacesSearchState _self;
  final $Res Function(_PlacesSearchState) _then;

/// Create a copy of PlacesSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? predictions = null,Object? isSearching = null,Object? isFetchingDetails = null,Object? selectedPlace = freezed,Object? errorMessage = freezed,}) {
  return _then(_PlacesSearchState(
predictions: null == predictions ? _self._predictions : predictions // ignore: cast_nullable_to_non_nullable
as List<PlacePredictionEntity>,isSearching: null == isSearching ? _self.isSearching : isSearching // ignore: cast_nullable_to_non_nullable
as bool,isFetchingDetails: null == isFetchingDetails ? _self.isFetchingDetails : isFetchingDetails // ignore: cast_nullable_to_non_nullable
as bool,selectedPlace: freezed == selectedPlace ? _self.selectedPlace : selectedPlace // ignore: cast_nullable_to_non_nullable
as PlaceDetailsEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
