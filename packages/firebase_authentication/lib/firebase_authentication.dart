import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/src/data/repositories/firebase_auth_repository_impl.dart';
import 'package:firebase_authentication/src/domain/domain.dart';
import 'package:get_it/get_it.dart';

export 'src/domain/domain.dart';

class FirebaseAuthentication {
  const FirebaseAuthentication._();

  static void initialize(GetIt di) {
    di.registerLazySingleton<FirebaseAuthRepository>(
      () => FirebaseAuthRepositoryImpl(FirebaseAuth.instance),
    );
  }
}
