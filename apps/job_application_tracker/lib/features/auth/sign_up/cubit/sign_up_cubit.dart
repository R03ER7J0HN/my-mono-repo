import 'package:authentication/firebase_authentication.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:job_application_tracker/features/auth/sign_up/cubit/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> with SafeEmitMixin<SignUpState> {
  SignUpCubit(this._authRepository) : super(const SignUpState.initial());

  final AuthenticationRepository _authRepository;

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    safeEmit(const SignUpState.loading());

    final result = await _authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.fold(
      onFailure: (failure) {
        safeEmit(
          SignUpState.failure(failure.message),
        );
        safeEmit(const SignUpState.initial());
      },
      onSuccess: (data) => safeEmit(const SignUpState.success()),
    );
  }
}
