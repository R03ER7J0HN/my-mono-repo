import 'package:firebase_authentication/src/domain/entities/user_entity.dart';
import 'package:firebase_authentication/src/domain/repositories/firebase_auth_repository.dart';
import 'package:flutter_core/flutter_core.dart';

class GetSignedInUser extends BaseUseCaseNoParams<FutureResult<UserEntity?>> {
  final FirebaseAuthRepository _firebaseAuthRepository;

  const GetSignedInUser(this._firebaseAuthRepository);

  @override
  FutureResult<UserEntity?> call() => _firebaseAuthRepository.getSignedInUser();
}
