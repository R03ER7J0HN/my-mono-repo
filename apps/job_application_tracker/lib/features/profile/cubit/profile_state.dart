import 'package:authentication/firebase_authentication.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded(UserEntity user) = _Loaded;
  const factory ProfileState.failure(String message) = _Failure;
  const factory ProfileState.loggedOut() = _LoggedOut;
  const factory ProfileState.accountDeleted() = _AccountDeleted;
  const factory ProfileState.requiresReauth() = _Reauth;
}
