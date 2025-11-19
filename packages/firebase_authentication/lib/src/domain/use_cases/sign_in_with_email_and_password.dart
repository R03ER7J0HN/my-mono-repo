import 'package:firebase_authentication/src/domain/entities/user_entity.dart';
import 'package:firebase_authentication/src/domain/repositories/firebase_auth_repository.dart';
import 'package:flutter_core/flutter_core.dart';

class SignInWithEmailAndPassword
    extends
        BaseUseCase<
          FutureResult<UserEntity>,
          SignInWithEmailAndPasswordParams
        > {
  const SignInWithEmailAndPassword(this._firebaseAuthRepository);

  final FirebaseAuthRepository _firebaseAuthRepository;

  @override
  FutureResult<UserEntity> call({
    required SignInWithEmailAndPasswordParams params,
  }) => _firebaseAuthRepository.signInWithEmailAndPassword(
    email: params.email,
    password: params.password,
  );
}

class SignInWithEmailAndPasswordParams {
  const SignInWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}
