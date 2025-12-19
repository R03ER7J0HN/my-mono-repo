import 'package:authentication/src/domain/failures/auth_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';

/// Exception handler that extends [ExceptionHandler] with FirebaseAuth-specific
/// exception mapping. Maps [FirebaseAuthException] to [AuthFailure] with
/// appropriate error codes.
mixin FirebaseAuthExceptionHandler on ExceptionHandler {
  @override
  Failure? mapException(Object error) {
    if (error is FirebaseAuthException) {
      return _mapFirebaseAuthException(error);
    }
    return super.mapException(error);
  }

  AuthFailure _mapFirebaseAuthException(FirebaseAuthException exception) {
    return switch (exception.code) {
      'invalid-credential' => const AuthFailure(
        'The credential you entered is invalid.',
        AuthErrorCode.invalidCredential,
      ),
      'invalid-email' => const AuthFailure(
        'The email address is badly formatted.',
        AuthErrorCode.invalidEmail,
      ),
      'requires-recent-login' => const AuthFailure(
        '''This operation will require re-authentication. Please enter your credentials''',
        AuthErrorCode.recentLoginRequired,
      ),
      'user-disabled' => const AuthFailure(
        'The user account has been disabled.',
        AuthErrorCode.userDisabled,
      ),
      'user-not-found' => const AuthFailure(
        'No user found for the given email.',
        AuthErrorCode.userNotFound,
      ),
      'wrong-password' => const AuthFailure(
        'The password is invalid for the given user.',
        AuthErrorCode.wrongPassword,
      ),
      _ => AuthFailure(
        exception.message ?? kGenericErrorMessage,
        AuthErrorCode.unknown,
      ),
    };
  }
}
