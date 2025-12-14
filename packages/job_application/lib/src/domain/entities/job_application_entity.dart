import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:job_application/src/domain/entities/job_enums.dart';

part 'job_application_entity.freezed.dart';

@freezed
sealed class JobApplicationEntity with _$JobApplicationEntity {
  const factory JobApplicationEntity({
    required String id,
    required String userId,
    required String companyName,
    required String jobTitle,
    required String jobLink,
    required JobPlatform platform,
    required WorkSetup workSetup,
    required EmploymentType employmentType,
    required DateTime dateApplied,
    String? recruiterName,
    JobLocationEntity? location,
    int? salaryRequested,
    String? currency, // e.g. "USD", "EUR"
    String? notes,
    @Default([]) List<DateTime> interviewDates,
    @Default([]) List<DateTime> deadlines,
    @Default(JobStatus.applied) JobStatus status,
  }) = _JobApplicationEntity;
}

@freezed
sealed class JobLocationEntity with _$JobLocationEntity {
  const factory JobLocationEntity({
    required String address,
    double? latitude,
    double? longitude,
    String? placeId, // Useful for Google Maps
  }) = _JobLocationEntity;
}
