import 'package:authentication/src/data/datasources/local_data_source.dart';
import 'package:authentication/src/data/repositories/firebase_auth_repository_impl.dart';
import 'package:authentication/src/domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

export 'src/domain/domain.dart';

class FirebaseAuthentication {
  const FirebaseAuthentication._();

  static void initialize(GetIt di) {
    di
      ..registerLazySingleton<LocalDataSource>(
        () => const LocalDataSource(FlutterSecureStorage()),
      )
      ..registerLazySingleton<AuthenticationRepository>(
        () => FirebaseAuthRepositoryImpl(
          FirebaseAuth.instance,
          di<LocalDataSource>(),
        ),
      );
  }
}
