class CancellationFailure extends Failure {
  const CancellationFailure(super.message);
}

class DioFailure extends Failure {
  const DioFailure(super.message);
}

abstract class Failure implements Exception {
  const Failure(this.message);

  final String message;
}

class FirebaseFailure extends Failure {
  const FirebaseFailure(super.message);

  factory FirebaseFailure.notLoggedIn() =>
      const FirebaseFailure('No user is currently signed in.');

  factory FirebaseFailure.userNotFound() =>
      const FirebaseFailure('User not found');

  factory FirebaseFailure.emailNotFound() =>
      const FirebaseFailure('Email not found');
}

class FormatFailure extends Failure {
  const FormatFailure(super.message);
}

class GenericFailure extends Failure {
  const GenericFailure(super.message);
}
