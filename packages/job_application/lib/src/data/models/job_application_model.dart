import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_application/src/domain/entities/job_application_entity.dart';
import 'package:job_application/src/domain/entities/job_enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_application_model.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@JsonSerializable(explicitToJson: true)
class JobLocationModel {
  const JobLocationModel({
    required this.address,
    this.latitude,
    this.longitude,
    this.placeId,
  });

  factory JobLocationModel.fromJson(Map<String, dynamic> json) =>
      _$JobLocationModelFromJson(json);

  factory JobLocationModel.fromEntity(JobLocationEntity entity) =>
      JobLocationModel(
        address: entity.address,
        latitude: entity.latitude,
        longitude: entity.longitude,
        placeId: entity.placeId,
      );
  final String address;
  final double? latitude;
  final double? longitude;
  final String? placeId;
  Map<String, dynamic> toJson() => _$JobLocationModelToJson(this);

  JobLocationEntity toEntity() => JobLocationEntity(
    address: address,
    latitude: latitude,
    longitude: longitude,
    placeId: placeId,
  );
}

@JsonSerializable(explicitToJson: true)
class JobApplicationModel {
  const JobApplicationModel({
    required this.id,
    required this.userId,
    required this.companyName,
    required this.jobTitle,
    required this.jobLink,
    required this.platform,
    required this.workSetup,
    required this.employmentType,
    required this.dateApplied,
    this.recruiterName,
    this.location,
    this.salaryRequested,
    this.currency,
    this.notes,
    this.interviewDates = const [],
    this.deadlines = const [],
    this.status = JobStatus.applied,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) =>
      _$JobApplicationModelFromJson(json);

  factory JobApplicationModel.fromEntity(JobApplicationEntity entity) {
    return JobApplicationModel(
      id: entity.id,
      userId: entity.userId,
      companyName: entity.companyName,
      jobTitle: entity.jobTitle,
      jobLink: entity.jobLink,
      platform: entity.platform,
      recruiterName: entity.recruiterName,
      workSetup: entity.workSetup,
      location: entity.location != null
          ? JobLocationModel.fromEntity(entity.location!)
          : null,
      salaryRequested: entity.salaryRequested,
      currency: entity.currency,
      employmentType: entity.employmentType,
      notes: entity.notes,
      dateApplied: entity.dateApplied,
      interviewDates: entity.interviewDates,
      deadlines: entity.deadlines,
      status: entity.status,
    );
  }

  final String id;
  final String userId;
  final String companyName;
  final String jobTitle;
  final String jobLink;
  final JobPlatform platform;
  final String? recruiterName;
  final WorkSetup workSetup;
  final JobLocationModel? location;
  final double? salaryRequested;
  final String? currency;
  final EmploymentType employmentType;
  final String? notes;

  @TimestampConverter()
  final DateTime dateApplied;

  @TimestampConverter()
  final List<DateTime> interviewDates;

  @TimestampConverter()
  final List<DateTime> deadlines;

  final JobStatus status;

  Map<String, dynamic> toJson() => _$JobApplicationModelToJson(this);

  JobApplicationEntity toEntity() {
    return JobApplicationEntity(
      id: id,
      userId: userId,
      companyName: companyName,
      jobTitle: jobTitle,
      jobLink: jobLink,
      platform: platform,
      recruiterName: recruiterName,
      workSetup: workSetup,
      location: location?.toEntity(),
      salaryRequested: salaryRequested,
      currency: currency,
      employmentType: employmentType,
      notes: notes,
      dateApplied: dateApplied,
      interviewDates: interviewDates,
      deadlines: deadlines,
      status: status,
    );
  }
}
