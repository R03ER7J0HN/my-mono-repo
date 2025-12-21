import 'package:json_annotation/json_annotation.dart';
import 'package:location_tracking/src/domain/entities/place_prediction_entity.dart';

part 'place_prediction_model.g.dart';

@JsonSerializable(createToJson: false)
class PlacesPredictionResponseModel {
  const PlacesPredictionResponseModel({
    required this.predictions,
  });

  factory PlacesPredictionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PlacesPredictionResponseModelFromJson(json);

  final List<PlacePredictionModel> predictions;
}

/// Model for Google Places API autocomplete prediction response.
/// Uses composition pattern - converts to [PlacePredictionEntity] entity via
/// [toEntity].
@JsonSerializable(createToJson: false)
class PlacePredictionModel {
  const PlacePredictionModel({
    required this.placeId,
    required this.description,
    this.structuredFormatting,
  });

  factory PlacePredictionModel.fromJson(Map<String, dynamic> json) =>
      _$PlacePredictionModelFromJson(json);

  @JsonKey(name: 'place_id')
  final String placeId;

  final String description;

  @JsonKey(name: 'structured_formatting')
  final StructuredFormattingModel? structuredFormatting;

  /// Converts this model to a [PlacePredictionEntity] entity.
  PlacePredictionEntity toEntity() => PlacePredictionEntity(
    placeId: placeId,
    description: description,
    mainText: structuredFormatting?.mainText,
    secondaryText: structuredFormatting?.secondaryText,
  );
}

/// Model for structured formatting in Places API response.
@JsonSerializable(createToJson: false)
class StructuredFormattingModel {
  const StructuredFormattingModel({
    this.mainText,
    this.secondaryText,
  });

  factory StructuredFormattingModel.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingModelFromJson(json);

  @JsonKey(name: 'main_text')
  final String? mainText;

  @JsonKey(name: 'secondary_text')
  final String? secondaryText;
}

extension ListExt on List<PlacePredictionModel> {
  List<PlacePredictionEntity> toEntityList() =>
      map((model) => model.toEntity()).toList();
}
