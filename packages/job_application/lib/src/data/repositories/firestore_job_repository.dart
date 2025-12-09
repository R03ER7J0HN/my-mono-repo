import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:job_application/src/data/constants/firestore_constants.dart';
import 'package:job_application/src/data/models/job_application_model.dart';
import 'package:job_application/src/domain/entities/job_application_entity.dart';
import 'package:job_application/src/domain/repositories/job_application_repository.dart';
import 'package:job_application/src/utils/firestore_exception_handler.dart';

class FirestoreJobApplicationRepository
    with FirestoreExceptionHandler
    implements JobApplicationRepository {
  const FirestoreJobApplicationRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<JobApplicationModel> _getCollection(String userId) {
    return _firestore
        .collection(FirestoreCollections.users)
        .doc(userId)
        .collection(FirestoreCollections.jobApplications)
        .withConverter(
          fromFirestore: (snapshot, _) =>
              JobApplicationModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  @override
  FutureResult<String> createJob(JobApplicationEntity job) {
    final docRef = _getCollection(job.userId).doc();
    final jobWithId = job.copyWith(id: docRef.id);

    return handleFirebaseException(
      docRef.set(
        JobApplicationModel.fromEntity(jobWithId),
      ),
      onSuccess: (_) => docRef.id,
    );
  }

  @override
  FutureResult<void> updateJob(JobApplicationEntity job) {
    return handleFirebaseException(
      _getCollection(job.userId)
          .doc(job.id)
          .update(
            JobApplicationModel.fromEntity(job).toJson(),
          ),
      onSuccess: (_) {},
    );
  }

  @override
  FutureResult<void> deleteJob({
    required String userId,
    required String jobId,
  }) {
    return handleFirebaseException(
      _getCollection(userId).doc(jobId).delete(),
      onSuccess: (_) {},
    );
  }

  @override
  Stream<List<JobApplicationEntity>> watchJobs(String userId) {
    return _getCollection(userId)
        .orderBy(JobFields.dateApplied, descending: true)
        .snapshots()
        .map(
          _snapshotToEntity,
        );
  }

  @override
  FutureResult<List<JobApplicationEntity>> getJobs(String userId) {
    return handleFirebaseException(
      _getCollection(
        userId,
      ).orderBy(JobFields.dateApplied, descending: true).get(),
      onSuccess: _snapshotToEntity,
    );
  }

  List<JobApplicationEntity> _snapshotToEntity(
    QuerySnapshot<JobApplicationModel> snapshot,
  ) {
    return snapshot.docs.map((doc) => doc.data().toEntity()).toList();
  }
}
