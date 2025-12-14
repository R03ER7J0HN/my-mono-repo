import 'package:authentication/firebase_authentication.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_details/cubit/job_details_state.dart';

class JobDetailsCubit extends Cubit<JobDetailsState>
    with SafeEmitMixin<JobDetailsState> {
  JobDetailsCubit(
    this._jobRepository,
    this._authRepository,
  ) : super(const JobDetailsState.initial());

  final JobApplicationRepository _jobRepository;
  final AuthenticationRepository _authRepository;

  Future<void> submitJob(JobApplicationEntity job) async {
    safeEmit(const JobDetailsState.loading());

    final userResult = await _authRepository.getSignedInUser();

    final userId = userResult.fold(
      onFailure: (_) => null,
      onSuccess: (user) => user?.uid,
    );

    if (userId == null) {
      safeEmit(
        const JobDetailsState.failure(message: 'User not authenticated'),
      );
      return;
    }

    final jobWithUserId = job.copyWith(userId: userId);
    final isNew = jobWithUserId.id.isEmpty;

    final _ =
        isNew
              ? await _jobRepository.createJob(jobWithUserId)
              : await _jobRepository.updateJob(jobWithUserId)
          ..fold(
            onFailure: (failure) {
              safeEmit(
                JobDetailsState.failure(message: failure.message),
              );
            },
            onSuccess: (jobId) {
              safeEmit(
                const JobDetailsState.success(),
              );
            },
          );
  }
}
