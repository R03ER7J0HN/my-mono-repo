import 'package:authentication/firebase_authentication.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:job_application_tracker/features/profile/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState>
    with SafeEmitMixin<ProfileState> {
  ProfileCubit(this._authRepository) : super(const ProfileState.initial());

  final AuthenticationRepository _authRepository;

  Future<void> loadProfile() async {
    safeEmit(const ProfileState.loading());

    final result = await _authRepository.getSignedInUser();

    result.fold(
      onFailure: (failure) => safeEmit(ProfileState.failure(failure.message)),
      onSuccess: (user) {
        if (user != null) {
          safeEmit(ProfileState.loaded(user));
        } else {
          safeEmit(const ProfileState.loggedOut());
        }
      },
    );
  }

  Future<void> logOut() async {
    await state.whenOrNull(
      loaded: (currentUser) async {
        safeEmit(const ProfileState.loading());

        final result = await _authRepository.logOut();

        result.fold(
          onFailure: (failure) {
            safeEmit(ProfileState.failure(failure.message));
            safeEmit(ProfileState.loaded(currentUser));
          },
          onSuccess: (_) => safeEmit(const ProfileState.loggedOut()),
        );
      },
    );
  }

  Future<void> deleteAccount() async {
    await state.whenOrNull(
      loaded: (currentUser) async => _performAccountDeletion(currentUser),
    );
  }

  Future<void> _performAccountDeletion(UserEntity currentUser) async {
    safeEmit(const ProfileState.loading());

    final result = await _authRepository.deleteAccount();

    result.fold(
      onFailure: (failure) {
        if (failure is AuthFailure &&
            failure.code == AuthErrorCode.recentLoginRequired) {
          safeEmit(const ProfileState.requiresReauth());
        } else {
          safeEmit(ProfileState.failure(failure.message));
        }
        safeEmit(ProfileState.loaded(currentUser));
      },
      onSuccess: (_) => safeEmit(const ProfileState.accountDeleted()),
    );
  }

  Future<void> reauthenticateAndDelete(String password) async {
    await state.whenOrNull(
      loaded: (user) async {
        safeEmit(const ProfileState.loading());

        final result = await _authRepository.reauthenticate(password);

        await result.fold(
          onFailure: (failure) {
            safeEmit(ProfileState.failure(failure.message));
            safeEmit(ProfileState.loaded(user));
            return;
          },
          onSuccess: (_) => _performAccountDeletion(user),
        );
      },
    );
  }
}
