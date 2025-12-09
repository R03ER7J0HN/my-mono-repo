import 'dart:async';

import 'package:flutter_core/flutter_core.dart';

mixin FirestoreExceptionHandler {
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
    } on FirebaseFailure catch (failure) {
      return Result.failure(failure);
    } on Exception catch (_) {
      return Result.failure(const GenericFailure(_genericErrorMessage));
    }
  }
}
