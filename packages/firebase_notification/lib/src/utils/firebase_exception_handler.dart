import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
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
    } on FirebaseException catch (error) {
      return Result.failure(
        FirebaseFailure(error.message ?? _genericErrorMessage),
      );
    } on Exception catch (_) {
      return Result.failure(const GenericFailure(_genericErrorMessage));
    }
  }
}
