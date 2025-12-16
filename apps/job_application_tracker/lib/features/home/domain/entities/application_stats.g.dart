// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApplicationStats _$ApplicationStatsFromJson(Map<String, dynamic> json) =>
    _ApplicationStats(
      totalApplications: (json['totalApplications'] as num).toInt(),
      activeApplications: (json['activeApplications'] as num).toInt(),
      interviewsScheduled: (json['interviewsScheduled'] as num).toInt(),
      offersReceived: (json['offersReceived'] as num).toInt(),
      advancedApplications: (json['advancedApplications'] as num).toInt(),
    );

Map<String, dynamic> _$ApplicationStatsToJson(_ApplicationStats instance) =>
    <String, dynamic>{
      'totalApplications': instance.totalApplications,
      'activeApplications': instance.activeApplications,
      'interviewsScheduled': instance.interviewsScheduled,
      'offersReceived': instance.offersReceived,
      'advancedApplications': instance.advancedApplications,
    };
