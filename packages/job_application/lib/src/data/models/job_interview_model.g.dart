// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_interview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobInterviewModel _$JobInterviewModelFromJson(Map<String, dynamic> json) =>
    JobInterviewModel(
      id: json['id'] as String,
      jobApplicationId: json['jobApplicationId'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      startTime: const TimestampConverter().fromJson(
        json['startTime'] as Timestamp,
      ),
      endTime: _$JsonConverterFromJson<Timestamp, DateTime>(
        json['endTime'],
        const TimestampConverter().fromJson,
      ),
      meetingUrl: json['meetingUrl'] as String?,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      addedToCalendar: json['addedToCalendar'] as bool? ?? false,
    );

Map<String, dynamic> _$JobInterviewModelToJson(JobInterviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobApplicationId': instance.jobApplicationId,
      'userId': instance.userId,
      'title': instance.title,
      'startTime': const TimestampConverter().toJson(instance.startTime),
      'endTime': _$JsonConverterToJson<Timestamp, DateTime>(
        instance.endTime,
        const TimestampConverter().toJson,
      ),
      'meetingUrl': instance.meetingUrl,
      'location': instance.location,
      'notes': instance.notes,
      'addedToCalendar': instance.addedToCalendar,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
