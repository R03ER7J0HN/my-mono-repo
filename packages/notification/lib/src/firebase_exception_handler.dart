import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_core/flutter_core.dart';

/// Exception handler that extends [ExceptionHandler] with Firebase-specific
/// exception mapping. Maps [FirebaseException] to [FirebaseFailure].
mixin FirebaseExceptionHandler on ExceptionHandler {
  @override
  Failure? mapException(Object error) {
    if (error is FirebaseException) {
      return FirebaseFailure(error.message ?? kGenericErrorMessage);
    }
    return super.mapException(error);
  }
}
