import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/src/domain/entities/user_entity.dart';
import 'package:firebase_authentication/src/domain/repositories/firebase_auth_repository.dart';
import 'package:firebase_authentication/src/common/firebase_exception_handler.dart';
import 'package:flutter_core/flutter_core.dart';

class FirebaseAuthRepositoryImpl
    with FirebaseExceptionHandler
    implements FirebaseAuthRepository {
  final FirebaseAuth _firebaseAuth;

  const FirebaseAuthRepositoryImpl(this._firebaseAuth);

  @override
  FutureResult<void> deleteAccount() async {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      return Result.failure(FirebaseFailure.notLoggedIn());
    }

    return handleFirebaseException(
      currentUser.delete(),
      onSuccess: (response) => null,
    );
  }

  @override
  FutureResult<UserEntity?> getSignedInUser() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user != null) {
        return Result.success(UserEntity(uid: user.uid, email: user.email));
      }

      return Result.success(null);
    } catch (e) {
      throw FirebaseFailure(e.toString());
    }
  }

  @override
  FutureResult<void> logOut() {
    return handleFirebaseException(
      _firebaseAuth.signOut(),
      onSuccess: (response) => response,
    );
  }

  @override
  FutureResult<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return handleFirebaseException(
      _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
      onSuccess: (userCredential) {
        final user = userCredential.user;
        if (user == null) {
          throw FirebaseFailure.userNotFound();
        }
        return UserEntity(uid: user.uid, email: user.email);
      },
    );
  }

  @override
  FutureResult<UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return handleFirebaseException(
      _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
      onSuccess: (userCredential) {
        final user = userCredential.user;
        if (user == null) {
          throw FirebaseFailure.userNotFound();
        }
        return UserEntity(uid: user.uid, email: user.email);
      },
    );
  }
}
