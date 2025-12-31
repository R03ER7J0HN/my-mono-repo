// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'icon_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IconDataModel {

 String get name; int get codePoint; String get fontFamily; String get fontPackage;
/// Create a copy of IconDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IconDataModelCopyWith<IconDataModel> get copyWith => _$IconDataModelCopyWithImpl<IconDataModel>(this as IconDataModel, _$identity);

  /// Serializes this IconDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IconDataModel&&(identical(other.name, name) || other.name == name)&&(identical(other.codePoint, codePoint) || other.codePoint == codePoint)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.fontPackage, fontPackage) || other.fontPackage == fontPackage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,codePoint,fontFamily,fontPackage);

@override
String toString() {
  return 'IconDataModel(name: $name, codePoint: $codePoint, fontFamily: $fontFamily, fontPackage: $fontPackage)';
}


}

/// @nodoc
abstract mixin class $IconDataModelCopyWith<$Res>  {
  factory $IconDataModelCopyWith(IconDataModel value, $Res Function(IconDataModel) _then) = _$IconDataModelCopyWithImpl;
@useResult
$Res call({
 String name, int codePoint, String fontFamily, String fontPackage
});




}
/// @nodoc
class _$IconDataModelCopyWithImpl<$Res>
    implements $IconDataModelCopyWith<$Res> {
  _$IconDataModelCopyWithImpl(this._self, this._then);

  final IconDataModel _self;
  final $Res Function(IconDataModel) _then;

/// Create a copy of IconDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? codePoint = null,Object? fontFamily = null,Object? fontPackage = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,codePoint: null == codePoint ? _self.codePoint : codePoint // ignore: cast_nullable_to_non_nullable
as int,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,fontPackage: null == fontPackage ? _self.fontPackage : fontPackage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [IconDataModel].
extension IconDataModelPatterns on IconDataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IconDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IconDataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IconDataModel value)  $default,){
final _that = this;
switch (_that) {
case _IconDataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IconDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _IconDataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int codePoint,  String fontFamily,  String fontPackage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IconDataModel() when $default != null:
return $default(_that.name,_that.codePoint,_that.fontFamily,_that.fontPackage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int codePoint,  String fontFamily,  String fontPackage)  $default,) {final _that = this;
switch (_that) {
case _IconDataModel():
return $default(_that.name,_that.codePoint,_that.fontFamily,_that.fontPackage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int codePoint,  String fontFamily,  String fontPackage)?  $default,) {final _that = this;
switch (_that) {
case _IconDataModel() when $default != null:
return $default(_that.name,_that.codePoint,_that.fontFamily,_that.fontPackage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IconDataModel implements IconDataModel {
  const _IconDataModel({required this.name, required this.codePoint, required this.fontFamily, this.fontPackage = 'MaterialIcons'});
  factory _IconDataModel.fromJson(Map<String, dynamic> json) => _$IconDataModelFromJson(json);

@override final  String name;
@override final  int codePoint;
@override final  String fontFamily;
@override@JsonKey() final  String fontPackage;

/// Create a copy of IconDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IconDataModelCopyWith<_IconDataModel> get copyWith => __$IconDataModelCopyWithImpl<_IconDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IconDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IconDataModel&&(identical(other.name, name) || other.name == name)&&(identical(other.codePoint, codePoint) || other.codePoint == codePoint)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.fontPackage, fontPackage) || other.fontPackage == fontPackage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,codePoint,fontFamily,fontPackage);

@override
String toString() {
  return 'IconDataModel(name: $name, codePoint: $codePoint, fontFamily: $fontFamily, fontPackage: $fontPackage)';
}


}

/// @nodoc
abstract mixin class _$IconDataModelCopyWith<$Res> implements $IconDataModelCopyWith<$Res> {
  factory _$IconDataModelCopyWith(_IconDataModel value, $Res Function(_IconDataModel) _then) = __$IconDataModelCopyWithImpl;
@override @useResult
$Res call({
 String name, int codePoint, String fontFamily, String fontPackage
});




}
/// @nodoc
class __$IconDataModelCopyWithImpl<$Res>
    implements _$IconDataModelCopyWith<$Res> {
  __$IconDataModelCopyWithImpl(this._self, this._then);

  final _IconDataModel _self;
  final $Res Function(_IconDataModel) _then;

/// Create a copy of IconDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? codePoint = null,Object? fontFamily = null,Object? fontPackage = null,}) {
  return _then(_IconDataModel(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,codePoint: null == codePoint ? _self.codePoint : codePoint // ignore: cast_nullable_to_non_nullable
as int,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,fontPackage: null == fontPackage ? _self.fontPackage : fontPackage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
