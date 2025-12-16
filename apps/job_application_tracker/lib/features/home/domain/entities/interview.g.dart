// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Interview _$InterviewFromJson(Map<String, dynamic> json) => _Interview(
  companyName: json['companyName'] as String,
  role: json['role'] as String,
  dateTime: DateTime.parse(json['dateTime'] as String),
  meetingUrl: json['meetingUrl'] as String?,
);

Map<String, dynamic> _$InterviewToJson(_Interview instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'role': instance.role,
      'dateTime': instance.dateTime.toIso8601String(),
      'meetingUrl': instance.meetingUrl,
    };
