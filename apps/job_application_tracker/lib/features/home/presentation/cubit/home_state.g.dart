// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeState _$HomeStateFromJson(Map<String, dynamic> json) => _HomeState(
  todaysInterviews:
      (json['todaysInterviews'] as List<dynamic>?)
          ?.map((e) => Interview.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  stats: json['stats'] == null
      ? null
      : ApplicationStats.fromJson(json['stats'] as Map<String, dynamic>),
  isLoading: json['isLoading'] as bool? ?? true,
  error: json['error'] as String?,
);

Map<String, dynamic> _$HomeStateToJson(_HomeState instance) =>
    <String, dynamic>{
      'todaysInterviews': instance.todaysInterviews,
      'stats': instance.stats,
      'isLoading': instance.isLoading,
      'error': instance.error,
    };
