import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:job_application/job_application.dart';

part 'job_list_state.freezed.dart';

@freezed
sealed class JobListState with _$JobListState {
  const factory JobListState.initial() = _Initial;
  const factory JobListState.loading() = _Loading;
  const factory JobListState.loaded(List<JobApplicationEntity> jobs) = _Loaded;
  const factory JobListState.error(String message) = _Error;
}
