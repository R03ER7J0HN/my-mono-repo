import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:job_application/job_application.dart';

part 'interview_list_state.freezed.dart';

@freezed
sealed class InterviewListState with _$InterviewListState {
  const factory InterviewListState({
    @Default([]) List<JobInterviewEntity> interviews,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _InterviewListState;
}
