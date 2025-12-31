import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_interview_entity.freezed.dart';

/// Represents an interview scheduled for a specific job application.
///
/// This entity is immutable and uses `freezed` for code generation.
/// It supports calendar linking via [startTime] and optional [endTime].
@freezed
sealed class JobInterviewEntity with _$JobInterviewEntity {
  const factory JobInterviewEntity({
    /// Unique identifier for the interview document.
    required String id,

    /// The ID of the job application this interview belongs to.
    required String jobApplicationId,

    /// The ID of the user who owns this interview.
    required String userId,

    /// Title/type of the interview (e.g., "Phone Screening", "Technical Round").
    required String title,

    /// The scheduled start date and time of the interview.
    required DateTime startTime,

    /// Optional end time of the interview.
    DateTime? endTime,

    /// Optional meeting URL (e.g., Zoom, Google Meet, Teams link).
    String? meetingUrl,

    /// Optional physical location for in-person interviews.
    String? location,

    /// Optional additional notes about the interview.
    String? notes,

    /// Whether this interview has been added to the device calendar.
    @Default(false) bool addedToCalendar,
  }) = _JobInterviewEntity;
}
