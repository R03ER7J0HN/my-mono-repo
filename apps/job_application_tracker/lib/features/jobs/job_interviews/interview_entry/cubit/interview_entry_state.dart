import 'package:freezed_annotation/freezed_annotation.dart';

part 'interview_entry_state.freezed.dart';

@freezed
class InterviewEntryState with _$InterviewEntryState {
  const factory InterviewEntryState.initial() = _Initial;
  const factory InterviewEntryState.loading() = _Loading;
  const factory InterviewEntryState.success() = _Success;
  const factory InterviewEntryState.failure({required String message}) =
      _Failure;
}
