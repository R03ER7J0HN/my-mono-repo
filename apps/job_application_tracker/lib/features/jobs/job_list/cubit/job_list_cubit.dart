import 'dart:async';

import 'package:authentication/firebase_authentication.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_list/cubit/job_list_state.dart';

class JobListCubit extends Cubit<JobListState>
    with SafeEmitMixin<JobListState> {
  JobListCubit(this._jobRepository, this._authRepository)
    : super(JobListState.initial());

  final JobApplicationRepository _jobRepository;
  final AuthenticationRepository _authRepository;

  StreamSubscription<List<JobApplicationEntity>>? _jobsSubscription;

  Future<void> init() async {
    safeEmit(state.copyWith(isLoading: true, errorMessage: null));

    final userResult = await _authRepository.getSignedInUser();

    await userResult.fold(
      onFailure: (failure) {
        safeEmit(
          state.copyWith(errorMessage: failure.message, isLoading: false),
        );
      },
      onSuccess: (user) async {
        if (user == null) {
          return safeEmit(
            state.copyWith(
              errorMessage: 'User not authenticated',
              isLoading: false,
            ),
          );
        }

        await _subscribeToJobs(user.uid);
      },
    );
  }

  Future<void> _subscribeToJobs(String userId) async {
    await _jobsSubscription?.cancel();
    _jobsSubscription ??= _jobRepository
        .watchJobs(userId)
        .listen(
          (jobs) {
            safeEmit(
              state.copyWith(jobs: jobs, isLoading: false, errorMessage: null),
            );
          },
          onError: (Object error) {
            safeEmit(
              state.copyWith(errorMessage: error.toString(), isLoading: false),
            );
          },
        );
  }

  Future<void> deleteJob(JobApplicationEntity job) async {
    safeEmit(state.copyWith(errorMessage: null, isLoading: true));

    final result = await _jobRepository.deleteJob(
      userId: job.userId,
      jobId: job.id,
    );

    result.fold(
      onFailure: (failure) {
        safeEmit(
          state.copyWith(errorMessage: failure.message, isLoading: false),
        );
      },
      onSuccess: (_) {},
    );
  }

  @override
  Future<void> close() async {
    await _jobsSubscription?.cancel();
    return super.close();
  }
}
