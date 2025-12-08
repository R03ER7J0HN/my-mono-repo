import 'package:flutter_core/flutter_core.dart';

enum AuthErrorCode {
  invalidCredential,
  invalidEmail,
  emailAlreadyInUse,
  operationNotAllowed,
  recentLoginRequired,
  weakPassword,
  wrongPassword,
  userDisabled,
  userNotFound,
  unknown,
}

class AuthFailure extends Failure {
  const AuthFailure(super.message, this.code);

  final AuthErrorCode code;
}
