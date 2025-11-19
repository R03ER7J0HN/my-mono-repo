import 'package:firebase_authentication/src/domain/entities/user_entity.dart';
import 'package:flutter_core/flutter_core.dart';

abstract class FirebaseAuthRepository {
  FutureResult<void> deleteAccount();

  FutureResult<UserEntity?> getSignedInUser();

  FutureResult<void> logOut();

  FutureResult<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  FutureResult<UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });
}
