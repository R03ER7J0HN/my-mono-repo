import 'package:firebase_authentication/src/domain/repositories/firebase_auth_repository.dart';
import 'package:flutter_core/flutter_core.dart';

class LogOut with BaseUseCaseNoParams<FutureResult<void>> {
  const LogOut(this._firebaseAuthRepository);

  final FirebaseAuthRepository _firebaseAuthRepository;

  @override
  FutureResult<void> call() => _firebaseAuthRepository.logOut();
}
