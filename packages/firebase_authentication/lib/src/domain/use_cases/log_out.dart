import 'package:firebase_authentication/src/domain/repositories/firebase_auth_repository.dart';
import 'package:flutter_core/flutter_core.dart';

class LogOut extends BaseUseCaseNoParams<FutureResult<void>> {
  final FirebaseAuthRepository _firebaseAuthRepository;

  const LogOut(this._firebaseAuthRepository);

  @override
  FutureResult<void> call() => _firebaseAuthRepository.logOut();
}
