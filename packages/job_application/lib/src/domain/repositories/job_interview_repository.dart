import 'package:flutter_core/flutter_core.dart';
import 'package:job_application/src/domain/entities/job_interview_entity.dart';

/// Repository contract for managing job interview data.
///
/// Interviews are stored as a subcollection under each job application:
/// `users/{userId}/job_applications/{jobApplicationId}/interviews/{interviewId}`
abstract class JobInterviewRepository {
  /// Creates a new interview for a job application.
  ///
  /// Returns the ID of the created interview document.
  FutureResult<String> createInterview(JobInterviewEntity interview);

  /// Updates an existing interview.
  FutureResult<void> updateInterview(JobInterviewEntity interview);

  /// Deletes an interview.
  FutureResult<void> deleteInterview({
    required String userId,
    required String jobApplicationId,
    required String interviewId,
  });

  /// Watches all interviews for a specific job application (real-time).
  Stream<List<JobInterviewEntity>> watchInterviews({
    required String userId,
    required String jobApplicationId,
  });

  /// Fetches all interviews for a specific job application once.
  FutureResult<List<JobInterviewEntity>> getInterviews({
    required String userId,
    required String jobApplicationId,
  });

  /// Watches all upcoming interviews for a user across all job applications.
  ///
  /// Returns interviews with [startTime] >= now, sorted by start time.
  Stream<List<JobInterviewEntity>> watchUpcomingInterviews({
    required String userId,
  });
}
