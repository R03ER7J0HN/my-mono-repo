import 'package:authentication/firebase_authentication.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:job_application_tracker/features/auth/sign_in/cubit/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> with SafeEmitMixin<SignInState> {
  SignInCubit(this._authRepository) : super(const SignInState.initial());

  final AuthenticationRepository _authRepository;

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    safeEmit(const SignInState.loading());

    final result = await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.fold(
      onFailure: (failure) {
        safeEmit(
          SignInState.failure(failure.message),
        );
        safeEmit(const SignInState.initial());
      },
      onSuccess: (data) => safeEmit(const SignInState.success()),
    );
  }
}
