// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobLocationModel _$JobLocationModelFromJson(Map<String, dynamic> json) =>
    JobLocationModel(
      address: json['address'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      placeId: json['placeId'] as String?,
    );

Map<String, dynamic> _$JobLocationModelToJson(JobLocationModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'placeId': instance.placeId,
    };

JobApplicationModel _$JobApplicationModelFromJson(Map<String, dynamic> json) =>
    JobApplicationModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      companyName: json['companyName'] as String,
      jobTitle: json['jobTitle'] as String,
      jobLink: json['jobLink'] as String,
      platform: $enumDecode(_$JobPlatformEnumMap, json['platform']),
      workSetup: $enumDecode(_$WorkSetupEnumMap, json['workSetup']),
      employmentType: $enumDecode(
        _$EmploymentTypeEnumMap,
        json['employmentType'],
      ),
      dateApplied: const TimestampConverter().fromJson(
        json['dateApplied'] as Timestamp,
      ),
      recruiterName: json['recruiterName'] as String?,
      location: json['location'] == null
          ? null
          : JobLocationModel.fromJson(json['location'] as Map<String, dynamic>),
      salaryRequested: (json['salaryRequested'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      notes: json['notes'] as String?,
      interviewDates:
          (json['interviewDates'] as List<dynamic>?)
              ?.map((e) => const TimestampConverter().fromJson(e as Timestamp))
              .toList() ??
          const [],
      deadlines:
          (json['deadlines'] as List<dynamic>?)
              ?.map((e) => const TimestampConverter().fromJson(e as Timestamp))
              .toList() ??
          const [],
      status:
          $enumDecodeNullable(_$JobStatusEnumMap, json['status']) ??
          JobStatus.applied,
    );

Map<String, dynamic> _$JobApplicationModelToJson(
  JobApplicationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'companyName': instance.companyName,
  'jobTitle': instance.jobTitle,
  'jobLink': instance.jobLink,
  'platform': _$JobPlatformEnumMap[instance.platform]!,
  'recruiterName': instance.recruiterName,
  'workSetup': _$WorkSetupEnumMap[instance.workSetup]!,
  'location': instance.location?.toJson(),
  'salaryRequested': instance.salaryRequested,
  'currency': instance.currency,
  'employmentType': _$EmploymentTypeEnumMap[instance.employmentType]!,
  'notes': instance.notes,
  'dateApplied': const TimestampConverter().toJson(instance.dateApplied),
  'interviewDates': instance.interviewDates
      .map(const TimestampConverter().toJson)
      .toList(),
  'deadlines': instance.deadlines
      .map(const TimestampConverter().toJson)
      .toList(),
  'status': _$JobStatusEnumMap[instance.status]!,
};

const _$JobPlatformEnumMap = {
  JobPlatform.linkedIn: 'linkedIn',
  JobPlatform.indeed: 'indeed',
  JobPlatform.glassdoor: 'glassdoor',
  JobPlatform.weworkremotely: 'weworkremotely',
  JobPlatform.upwork: 'upwork',
  JobPlatform.other: 'other',
};

const _$WorkSetupEnumMap = {
  WorkSetup.remote: 'remote',
  WorkSetup.onsite: 'onsite',
  WorkSetup.hybrid: 'hybrid',
};

const _$EmploymentTypeEnumMap = {
  EmploymentType.fullTime: 'fullTime',
  EmploymentType.partTime: 'partTime',
  EmploymentType.contract: 'contract',
  EmploymentType.internship: 'internship',
  EmploymentType.freelance: 'freelance',
};

const _$JobStatusEnumMap = {
  JobStatus.applied: 'applied',
  JobStatus.interviewing: 'interviewing',
  JobStatus.offer: 'offer',
  JobStatus.rejected: 'rejected',
  JobStatus.ghosted: 'ghosted',
};
