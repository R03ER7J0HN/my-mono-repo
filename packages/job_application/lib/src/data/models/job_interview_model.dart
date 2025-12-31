import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:job_application/src/data/models/job_application_model.dart';
import 'package:job_application/src/domain/entities/job_interview_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_interview_model.g.dart';

/// Data model for serializing [JobInterviewEntity] to/from Firestore.
///
/// Uses composition pattern - does NOT extend the entity.
@JsonSerializable(explicitToJson: true)
class JobInterviewModel extends Equatable {
  const JobInterviewModel({
    required this.id,
    required this.jobApplicationId,
    required this.userId,
    required this.title,
    required this.startTime,
    this.endTime,
    this.meetingUrl,
    this.location,
    this.notes,
    this.addedToCalendar = false,
  });

  factory JobInterviewModel.fromJson(Map<String, dynamic> json) =>
      _$JobInterviewModelFromJson(json);

  factory JobInterviewModel.fromEntity(JobInterviewEntity entity) =>
      JobInterviewModel(
        id: entity.id,
        jobApplicationId: entity.jobApplicationId,
        userId: entity.userId,
        title: entity.title,
        startTime: entity.startTime,
        endTime: entity.endTime,
        meetingUrl: entity.meetingUrl,
        location: entity.location,
        notes: entity.notes,
        addedToCalendar: entity.addedToCalendar,
      );

  final String id;
  final String jobApplicationId;
  final String userId;
  final String title;

  @TimestampConverter()
  final DateTime startTime;

  @TimestampConverter()
  final DateTime? endTime;

  final String? meetingUrl;
  final String? location;
  final String? notes;
  final bool addedToCalendar;

  Map<String, dynamic> toJson() => _$JobInterviewModelToJson(this);

  JobInterviewEntity toEntity() => JobInterviewEntity(
    id: id,
    jobApplicationId: jobApplicationId,
    userId: userId,
    title: title,
    startTime: startTime,
    endTime: endTime,
    meetingUrl: meetingUrl,
    location: location,
    notes: notes,
    addedToCalendar: addedToCalendar,
  );

  @override
  List<Object?> get props => [
    id,
    jobApplicationId,
    userId,
    title,
    startTime,
    endTime,
    meetingUrl,
    location,
    notes,
    addedToCalendar,
  ];
}

/// Extension for converting a list of models to entities.
extension JobInterviewModelListExt on List<JobInterviewModel> {
  List<JobInterviewEntity> toEntityList() => map((m) => m.toEntity()).toList();
}
