import 'dart:async';

import 'package:flutter_core/flutter_core.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_list/cubit/interview_list_state.dart';

class InterviewListCubit extends Cubit<InterviewListState>
    with SafeEmitMixin<InterviewListState> {
  InterviewListCubit(
    this._interviewRepository, {
    required this.userId,
    required this.jobApplicationId,
  }) : super(const InterviewListState());

  final JobInterviewRepository _interviewRepository;
  final String userId;
  final String jobApplicationId;

  StreamSubscription<List<JobInterviewEntity>>? _subscription;

  Future<void> init() async {
    safeEmit(state.copyWith(isLoading: true, errorMessage: null));

    _subscription = _interviewRepository
        .watchInterviews(
          userId: userId,
          jobApplicationId: jobApplicationId,
        )
        .listen(
          (interviews) {
            safeEmit(
              state.copyWith(
                interviews: interviews,
                isLoading: false,
              ),
            );
          },
          onError: (Object error) {
            safeEmit(
              state.copyWith(
                isLoading: false,
                errorMessage: error.toString(),
              ),
            );
          },
        );
  }

  Future<void> deleteInterview(JobInterviewEntity interview) async {
    final result = await _interviewRepository.deleteInterview(
      userId: userId,
      jobApplicationId: jobApplicationId,
      interviewId: interview.id,
    );

    result.fold(
      onFailure: (failure) {
        safeEmit(state.copyWith(errorMessage: failure.message));
      },
      onSuccess: (_) {
        // The stream will automatically update the list
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
