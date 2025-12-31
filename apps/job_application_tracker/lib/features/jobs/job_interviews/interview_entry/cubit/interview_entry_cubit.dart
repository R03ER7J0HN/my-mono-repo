import 'package:flutter_core/flutter_core.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_entry/cubit/interview_entry_state.dart';

class InterviewEntryCubit extends Cubit<InterviewEntryState>
    with SafeEmitMixin<InterviewEntryState> {
  InterviewEntryCubit(this._interviewRepository)
    : super(const InterviewEntryState.initial());

  final JobInterviewRepository _interviewRepository;

  Future<void> submitInterview(JobInterviewEntity interview) async {
    safeEmit(const InterviewEntryState.loading());

    final isNew = interview.id.isEmpty;

    final result = isNew
        ? await _interviewRepository.createInterview(interview)
        : await _interviewRepository.updateInterview(interview);

    result.fold(
      onFailure: (failure) {
        safeEmit(InterviewEntryState.failure(message: failure.message));
      },
      onSuccess: (_) {
        safeEmit(const InterviewEntryState.success());
      },
    );
  }
}
