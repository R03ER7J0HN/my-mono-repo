import 'package:flutter_core/flutter_core.dart';
import 'package:job_application/src/domain/entities/job_application_entity.dart';

abstract class JobApplicationRepository {
  /// Creates a new job application. Returns the ID of the created job.
  FutureResult<String> createJob(JobApplicationEntity job);

  /// Updates an existing job application.
  FutureResult<void> updateJob(JobApplicationEntity job);

  /// Deletes a job application.
  FutureResult<void> deleteJob({required String userId, required String jobId});

  /// Watches the list of jobs for a specific user (Real-time).
  Stream<List<JobApplicationEntity>> watchJobs(String userId);

  /// Fetches the list of jobs once.
  FutureResult<List<JobApplicationEntity>> getJobs(String userId);
}
