import 'dart:async';

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
      return Result.failure(GenericFailure(_genericErrorMessage));
    }
  }

  Failure _mapFirebaseAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return FirebaseFailure('The email address is badly formatted.');
      case 'user-disabled':
        return FirebaseFailure('The user account has been disabled.');
      case 'user-not-found':
        return FirebaseFailure('No user found for the given email.');
      case 'wrong-password':
        return FirebaseFailure('The password is invalid for the given user.');
      default:
        return FirebaseFailure(exception.message ?? _genericErrorMessage);
    }
  }
}
