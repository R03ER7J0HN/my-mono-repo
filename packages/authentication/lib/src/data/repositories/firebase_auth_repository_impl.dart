import 'package:authentication/src/data/datasources/local_data_source.dart';
import 'package:authentication/src/data/models/user_model.dart';
import 'package:authentication/src/domain/entities/user_entity.dart';
import 'package:authentication/src/domain/repositories/authentication_repository.dart';
import 'package:authentication/src/utils/firebase_exception_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_core/flutter_core.dart';

class FirebaseAuthRepositoryImpl
    with FirebaseExceptionHandler
    implements AuthenticationRepository {
  const FirebaseAuthRepositoryImpl(
    this._firebaseAuth,
    this._localDataSource,
  );

  final FirebaseAuth _firebaseAuth;
  final LocalDataSource _localDataSource;

  @override
  FutureResult<void> deleteAccount() async {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      return Result.failure(FirebaseFailure.notLoggedIn());
    }

    return handleFirebaseException(
      currentUser.delete(),
      onSuccess: (response) => _localDataSource.clearCache(),
    );
  }

  @override
  FutureResult<UserEntity?> getSignedInUser() async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user != null) {
        final userEntity = _mapFirebaseUserToUserEntity(user);
        await _localDataSource.cacheUser(UserModel.fromEntity(userEntity));
        return Result.success(userEntity);
      }

      await _localDataSource.clearCache();
      return Result.success(null);
    } on Exception catch (e) {
      final cachedUser = await _localDataSource.getLastSignedInUser();
      if (cachedUser != null) {
        return Result.success(cachedUser);
      }
      return Result.failure(FirebaseFailure(e.toString()));
    }
  }

  @override
  FutureResult<void> logOut() {
    return handleFirebaseException(
      _firebaseAuth.signOut(),
      onSuccess: (response) async {
        await _localDataSource.clearCache();
        return response;
      },
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
      onSuccess: (userCredential) async {
        final user = userCredential.user;
        if (user == null) {
          throw FirebaseFailure.userNotFound();
        }
        final userEntity = _mapFirebaseUserToUserEntity(user);
        await _localDataSource.cacheUser(UserModel.fromEntity(userEntity));
        return userEntity;
      },
    );
  }

  @override
  FutureResult<void> reauthenticate(String password) async {
    final currentUser = _firebaseAuth.currentUser;
    final email = currentUser?.email;

    if (currentUser == null) {
      return Result.failure(FirebaseFailure.notLoggedIn());
    }

    if (email == null) throw FirebaseFailure.emailNotFound();

    final credential = EmailAuthProvider.credential(
      email: currentUser.email!,
      password: password,
    );

    return handleFirebaseException(
      currentUser.reauthenticateWithCredential(credential),
      onSuccess: (_) {},
    );
  }

  UserEntity _mapFirebaseUserToUserEntity(User user) => UserEntity(
    uid: user.uid,
    email: user.email,
  );

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
      onSuccess: (userCredential) async {
        final user = userCredential.user;
        if (user == null) {
          throw FirebaseFailure.userNotFound();
        }
        final userEntity = _mapFirebaseUserToUserEntity(user);
        await _localDataSource.cacheUser(UserModel.fromEntity(userEntity));
        return userEntity;
      },
    );
  }

  @override
  FutureResult<void> sendPasswordResetEmail({required String email}) {
    return handleFirebaseException(
      _firebaseAuth.sendPasswordResetEmail(email: email),
      onSuccess: (response) => response,
    );
  }
}
