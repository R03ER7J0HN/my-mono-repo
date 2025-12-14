import 'dart:async';

import 'package:authentication/firebase_authentication.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_list/cubit/job_list_state.dart';

class JobListCubit extends Cubit<JobListState>
    with SafeEmitMixin<JobListState> {
  JobListCubit(this._jobRepository, this._authRepository)
    : super(const JobListState.initial());

  final JobApplicationRepository _jobRepository;
  final AuthenticationRepository _authRepository;

  StreamSubscription<List<JobApplicationEntity>>? _jobsSubscription;

  Future<void> init() async {
    safeEmit(const JobListState.loading());

    // 1. Get User ID
    final userResult = await _authRepository.getSignedInUser();

    userResult.fold(
      onFailure: (failure) => safeEmit(JobListState.error(failure.message)),
      onSuccess: (user) async {
        if (user == null) {
          safeEmit(const JobListState.error('User not authenticated'));
          return;
        }

        // 2. Subscribe to Stream
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
            safeEmit(JobListState.loaded(jobs));
          },
          onError: (Object error) {
            safeEmit(JobListState.error(error.toString()));
          },
        );
  }

  @override
  Future<void> close() async {
    await _jobsSubscription?.cancel();
    return super.close();
  }
}
