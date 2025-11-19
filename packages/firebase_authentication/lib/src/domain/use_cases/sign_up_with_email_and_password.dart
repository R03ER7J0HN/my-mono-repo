import 'package:firebase_authentication/src/domain/entities/user_entity.dart';
import 'package:firebase_authentication/src/domain/repositories/firebase_auth_repository.dart';
import 'package:flutter_core/flutter_core.dart';

class SignUpWithEmailAndPassword
    extends
        BaseUseCase<
          FutureResult<UserEntity>,
          SignUpWithEmailAndPasswordParams
        > {
  const SignUpWithEmailAndPassword(this._firebaseAuthRepository);

  final FirebaseAuthRepository _firebaseAuthRepository;

  @override
  FutureResult<UserEntity> call({
    required SignUpWithEmailAndPasswordParams params,
  }) => _firebaseAuthRepository.signUpWithEmailAndPassword(
    email: params.email,
    password: params.password,
  );
}

class SignUpWithEmailAndPasswordParams {
  const SignUpWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}
