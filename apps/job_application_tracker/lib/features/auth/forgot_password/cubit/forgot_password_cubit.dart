import 'package:authentication/firebase_authentication.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:job_application_tracker/features/auth/forgot_password/cubit/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState>
    with SafeEmitMixin<ForgotPasswordState> {
  ForgotPasswordCubit(this._authRepository)
    : super(const ForgotPasswordState.initial());

  final AuthenticationRepository _authRepository;

  Future<void> sendPasswordResetEmail(String email) async {
    safeEmit(const ForgotPasswordState.loading());

    final result = await _authRepository.sendPasswordResetEmail(email: email);

    result.fold(
      onFailure: (failure) {
        safeEmit(ForgotPasswordState.failure(failure.message));
        safeEmit(const ForgotPasswordState.initial());
      },
      onSuccess: (_) => safeEmit(const ForgotPasswordState.success()),
    );
  }
}
