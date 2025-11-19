import 'package:firebase_authentication/src/domain/entities/user_entity.dart';
import 'package:firebase_authentication/src/domain/repositories/firebase_auth_repository.dart';
import 'package:flutter_core/flutter_core.dart';

class SignInWithEmailAndPassword
    extends
        BaseUseCase<
          FutureResult<UserEntity>,
          SignInWithEmailAndPasswordParams
        > {
  final FirebaseAuthRepository _firebaseAuthRepository;

  const SignInWithEmailAndPassword(this._firebaseAuthRepository);

  @override
  FutureResult<UserEntity> call({
    required SignInWithEmailAndPasswordParams params,
  }) => _firebaseAuthRepository.signInWithEmailAndPassword(
    email: params.email,
    password: params.password,
  );
}

class SignInWithEmailAndPasswordParams {
  final String email;
  final String password;

  const SignInWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });
}
