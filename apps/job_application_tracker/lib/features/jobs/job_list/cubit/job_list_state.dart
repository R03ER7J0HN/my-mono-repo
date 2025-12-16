import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:job_application/job_application.dart';

part 'job_list_state.freezed.dart';

@freezed
sealed class JobListState with _$JobListState {
  const factory JobListState(
    List<JobApplicationEntity> jobs, {
    @Default(false) bool? isLoading,
    String? errorMessage,
  }) = _JobListState;

  factory JobListState.initial() => const JobListState([], isLoading: true);
}
