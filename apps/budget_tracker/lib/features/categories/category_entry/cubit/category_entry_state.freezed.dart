// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_entry_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryEntryState {

 String get name; int get iconCodePoint;// Icons.category default
 String get colorHex;// Blue
 bool get isSaving; bool get isValid; String? get error; CategoryEntity? get existingCategory;
/// Create a copy of CategoryEntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryEntryStateCopyWith<CategoryEntryState> get copyWith => _$CategoryEntryStateCopyWithImpl<CategoryEntryState>(this as CategoryEntryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryEntryState&&(identical(other.name, name) || other.name == name)&&(identical(other.iconCodePoint, iconCodePoint) || other.iconCodePoint == iconCodePoint)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.error, error) || other.error == error)&&(identical(other.existingCategory, existingCategory) || other.existingCategory == existingCategory));
}


@override
int get hashCode => Object.hash(runtimeType,name,iconCodePoint,colorHex,isSaving,isValid,error,existingCategory);

@override
String toString() {
  return 'CategoryEntryState(name: $name, iconCodePoint: $iconCodePoint, colorHex: $colorHex, isSaving: $isSaving, isValid: $isValid, error: $error, existingCategory: $existingCategory)';
}


}

/// @nodoc
abstract mixin class $CategoryEntryStateCopyWith<$Res>  {
  factory $CategoryEntryStateCopyWith(CategoryEntryState value, $Res Function(CategoryEntryState) _then) = _$CategoryEntryStateCopyWithImpl;
@useResult
$Res call({
 String name, int iconCodePoint, String colorHex, bool isSaving, bool isValid, String? error, CategoryEntity? existingCategory
});


$CategoryEntityCopyWith<$Res>? get existingCategory;

}
/// @nodoc
class _$CategoryEntryStateCopyWithImpl<$Res>
    implements $CategoryEntryStateCopyWith<$Res> {
  _$CategoryEntryStateCopyWithImpl(this._self, this._then);

  final CategoryEntryState _self;
  final $Res Function(CategoryEntryState) _then;

/// Create a copy of CategoryEntryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? iconCodePoint = null,Object? colorHex = null,Object? isSaving = null,Object? isValid = null,Object? error = freezed,Object? existingCategory = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconCodePoint: null == iconCodePoint ? _self.iconCodePoint : iconCodePoint // ignore: cast_nullable_to_non_nullable
as int,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,existingCategory: freezed == existingCategory ? _self.existingCategory : existingCategory // ignore: cast_nullable_to_non_nullable
as CategoryEntity?,
  ));
}
/// Create a copy of CategoryEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryEntityCopyWith<$Res>? get existingCategory {
    if (_self.existingCategory == null) {
    return null;
  }

  return $CategoryEntityCopyWith<$Res>(_self.existingCategory!, (value) {
    return _then(_self.copyWith(existingCategory: value));
  });
}
}


/// Adds pattern-matching-related methods to [CategoryEntryState].
extension CategoryEntryStatePatterns on CategoryEntryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryEntryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryEntryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryEntryState value)  $default,){
final _that = this;
switch (_that) {
case _CategoryEntryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryEntryState value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryEntryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int iconCodePoint,  String colorHex,  bool isSaving,  bool isValid,  String? error,  CategoryEntity? existingCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryEntryState() when $default != null:
return $default(_that.name,_that.iconCodePoint,_that.colorHex,_that.isSaving,_that.isValid,_that.error,_that.existingCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int iconCodePoint,  String colorHex,  bool isSaving,  bool isValid,  String? error,  CategoryEntity? existingCategory)  $default,) {final _that = this;
switch (_that) {
case _CategoryEntryState():
return $default(_that.name,_that.iconCodePoint,_that.colorHex,_that.isSaving,_that.isValid,_that.error,_that.existingCategory);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int iconCodePoint,  String colorHex,  bool isSaving,  bool isValid,  String? error,  CategoryEntity? existingCategory)?  $default,) {final _that = this;
switch (_that) {
case _CategoryEntryState() when $default != null:
return $default(_that.name,_that.iconCodePoint,_that.colorHex,_that.isSaving,_that.isValid,_that.error,_that.existingCategory);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryEntryState extends CategoryEntryState {
  const _CategoryEntryState({this.name = '', this.iconCodePoint = 0xe08f, this.colorHex = '#2196F3', this.isSaving = false, this.isValid = false, this.error, this.existingCategory}): super._();
  

@override@JsonKey() final  String name;
@override@JsonKey() final  int iconCodePoint;
// Icons.category default
@override@JsonKey() final  String colorHex;
// Blue
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  bool isValid;
@override final  String? error;
@override final  CategoryEntity? existingCategory;

/// Create a copy of CategoryEntryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryEntryStateCopyWith<_CategoryEntryState> get copyWith => __$CategoryEntryStateCopyWithImpl<_CategoryEntryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryEntryState&&(identical(other.name, name) || other.name == name)&&(identical(other.iconCodePoint, iconCodePoint) || other.iconCodePoint == iconCodePoint)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&(identical(other.isValid, isValid) || other.isValid == isValid)&&(identical(other.error, error) || other.error == error)&&(identical(other.existingCategory, existingCategory) || other.existingCategory == existingCategory));
}


@override
int get hashCode => Object.hash(runtimeType,name,iconCodePoint,colorHex,isSaving,isValid,error,existingCategory);

@override
String toString() {
  return 'CategoryEntryState(name: $name, iconCodePoint: $iconCodePoint, colorHex: $colorHex, isSaving: $isSaving, isValid: $isValid, error: $error, existingCategory: $existingCategory)';
}


}

/// @nodoc
abstract mixin class _$CategoryEntryStateCopyWith<$Res> implements $CategoryEntryStateCopyWith<$Res> {
  factory _$CategoryEntryStateCopyWith(_CategoryEntryState value, $Res Function(_CategoryEntryState) _then) = __$CategoryEntryStateCopyWithImpl;
@override @useResult
$Res call({
 String name, int iconCodePoint, String colorHex, bool isSaving, bool isValid, String? error, CategoryEntity? existingCategory
});


@override $CategoryEntityCopyWith<$Res>? get existingCategory;

}
/// @nodoc
class __$CategoryEntryStateCopyWithImpl<$Res>
    implements _$CategoryEntryStateCopyWith<$Res> {
  __$CategoryEntryStateCopyWithImpl(this._self, this._then);

  final _CategoryEntryState _self;
  final $Res Function(_CategoryEntryState) _then;

/// Create a copy of CategoryEntryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? iconCodePoint = null,Object? colorHex = null,Object? isSaving = null,Object? isValid = null,Object? error = freezed,Object? existingCategory = freezed,}) {
  return _then(_CategoryEntryState(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconCodePoint: null == iconCodePoint ? _self.iconCodePoint : iconCodePoint // ignore: cast_nullable_to_non_nullable
as int,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,existingCategory: freezed == existingCategory ? _self.existingCategory : existingCategory // ignore: cast_nullable_to_non_nullable
as CategoryEntity?,
  ));
}

/// Create a copy of CategoryEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CategoryEntityCopyWith<$Res>? get existingCategory {
    if (_self.existingCategory == null) {
    return null;
  }

  return $CategoryEntityCopyWith<$Res>(_self.existingCategory!, (value) {
    return _then(_self.copyWith(existingCategory: value));
  });
}
}

// dart format on
