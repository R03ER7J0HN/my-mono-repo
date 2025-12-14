import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_details_state.freezed.dart';

@freezed
class JobDetailsState with _$JobDetailsState {
  const factory JobDetailsState.initial() = _Initial;
  const factory JobDetailsState.loading() = _Loading;
  const factory JobDetailsState.success() = _Success;
  const factory JobDetailsState.failure({required String message}) = _Failure;
}
