import 'package:firebase_authentication/src/domain/entities/user_entity.dart';
import 'package:firebase_authentication/src/domain/repositories/firebase_auth_repository.dart';
import 'package:flutter_core/flutter_core.dart';

class SignUpWithEmailAndPassword
    extends
        BaseUseCase<
          FutureResult<UserEntity>,
          SignUpWithEmailAndPasswordParams
        > {
  final FirebaseAuthRepository _firebaseAuthRepository;

  const SignUpWithEmailAndPassword(this._firebaseAuthRepository);

  @override
  FutureResult<UserEntity> call({
    required SignUpWithEmailAndPasswordParams params,
  }) => _firebaseAuthRepository.signUpWithEmailAndPassword(
    email: params.email,
    password: params.password,
  );
}

class SignUpWithEmailAndPasswordParams {
  final String email;
  final String password;

  const SignUpWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });
}
