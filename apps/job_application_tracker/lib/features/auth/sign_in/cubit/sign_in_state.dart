import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
sealed class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;
  const factory SignInState.success() = _Success;
  const factory SignInState.failure(String message) = _Failure;
}
