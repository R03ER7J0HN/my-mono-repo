import 'package:firebase_authentication/firebase_authentication.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:job_application_tracker/features/auth/sign_in/cubit/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> with SafeEmitMixin<SignInState> {
  SignInCubit({required SignInWithEmailAndPassword signInWithEmailAndPassword})
    : _signInWithEmailAndPassword = signInWithEmailAndPassword,
      super(const SignInState.initial());

  final SignInWithEmailAndPassword _signInWithEmailAndPassword;

  void signInSuccess() => safeEmit(const SignInState.success());

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final result = await _signInWithEmailAndPassword(
      params: SignInWithEmailAndPasswordParams(
        email: email,
        password: password,
      ),
    );

    result.fold(
      onFailure: (failure) {
        safeEmit(
          SignInState.failure(failure.message),
        );
        safeEmit(const SignInState.initial());
      },
      onSuccess: (data) => signInSuccess(),
    );
  }
}
