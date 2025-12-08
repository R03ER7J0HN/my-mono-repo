import 'dart:async';

import 'package:authentication/src/domain/failures/auth_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';

mixin FirebaseExceptionHandler {
  static const _genericErrorMessage =
      'An unexpected error occurred. Please try again.';

  FutureResult<TransformedResult>
  handleFirebaseException<RawResponse, TransformedResult>(
    Future<RawResponse> execute, {
    required FutureOr<TransformedResult> Function(RawResponse response)
    onSuccess,
  }) async {
    try {
      final result = await execute;

      return Result.success(await onSuccess(result));
    } on FirebaseAuthException catch (error) {
      return Result.failure(_mapFirebaseAuthException(error));
    } on FirebaseFailure catch (failure) {
      return Result.failure(failure);
    } on Exception catch (_) {
      return Result.failure(const GenericFailure(_genericErrorMessage));
    }
  }

  AuthFailure _mapFirebaseAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-credential':
        return const AuthFailure(
          'The credential you entered is invalid.',
          AuthErrorCode.invalidCredential,
        );
      case 'invalid-email':
        return const AuthFailure(
          'The email address is badly formatted.',
          AuthErrorCode.invalidEmail,
        );
      case 'requires-recent-login':
        return const AuthFailure(
          '''
This operation will require re-authentication. Please enter your credentials''',
          AuthErrorCode.recentLoginRequired,
        );
      case 'user-disabled':
        return const AuthFailure(
          'The user account has been disabled.',
          AuthErrorCode.userDisabled,
        );
      case 'user-not-found':
        return const AuthFailure(
          'No user found for the given email.',
          AuthErrorCode.userNotFound,
        );
      case 'wrong-password':
        return const AuthFailure(
          'The password is invalid for the given user.',
          AuthErrorCode.wrongPassword,
        );
      default:
        return AuthFailure(
          exception.message ?? _genericErrorMessage,
          AuthErrorCode.unknown,
        );
    }
  }
}
