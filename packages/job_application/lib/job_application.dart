import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:job_application/src/data/repositories/firestore_job_repository.dart';
import 'package:job_application/src/domain/domain.dart';

export 'src/domain/domain.dart';

class JobApplication {
  const JobApplication._();

  static void initialize(GetIt instance) {
    instance.registerLazySingleton<JobApplicationRepository>(
      () => FirestoreJobApplicationRepository(FirebaseFirestore.instance),
    );
  }
}
