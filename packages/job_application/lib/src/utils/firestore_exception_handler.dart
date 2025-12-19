import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_core/flutter_core.dart';

/// Exception handler that extends [ExceptionHandler] with Firestore-specific
/// exception mapping. Maps [FirebaseException] to [FirebaseFailure].
mixin FirestoreExceptionHandler on ExceptionHandler {
  @override
  Failure? mapException(Object error) {
    if (error is FirebaseException) {
      return FirebaseFailure(error.message ?? kGenericErrorMessage);
    }
    return super.mapException(error);
  }
}
