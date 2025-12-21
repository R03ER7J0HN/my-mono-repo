// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_prediction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesPredictionResponseModel _$PlacesPredictionResponseModelFromJson(
  Map<String, dynamic> json,
) => PlacesPredictionResponseModel(
  predictions: (json['predictions'] as List<dynamic>)
      .map((e) => PlacePredictionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

PlacePredictionModel _$PlacePredictionModelFromJson(
  Map<String, dynamic> json,
) => PlacePredictionModel(
  placeId: json['place_id'] as String,
  description: json['description'] as String,
  structuredFormatting: json['structured_formatting'] == null
      ? null
      : StructuredFormattingModel.fromJson(
          json['structured_formatting'] as Map<String, dynamic>,
        ),
);

StructuredFormattingModel _$StructuredFormattingModelFromJson(
  Map<String, dynamic> json,
) => StructuredFormattingModel(
  mainText: json['main_text'] as String?,
  secondaryText: json['secondary_text'] as String?,
);
