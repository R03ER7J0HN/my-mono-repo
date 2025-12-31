import 'package:freezed_annotation/freezed_annotation.dart';

part 'icon_data_model.freezed.dart';
part 'icon_data_model.g.dart';

/// Model representing an icon option for category selection
@freezed
sealed class IconDataModel with _$IconDataModel {
  const factory IconDataModel({
    required String name,
    required int codePoint,
    required String fontFamily,
    @Default('MaterialIcons') String fontPackage,
  }) = _IconDataModel;

  factory IconDataModel.fromJson(Map<String, dynamic> json) =>
      _$IconDataModelFromJson(json);
}
