import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:job_application/src/data/constants/firestore_constants.dart';
import 'package:job_application/src/data/models/job_interview_model.dart';
import 'package:job_application/src/domain/entities/job_interview_entity.dart';
import 'package:job_application/src/domain/repositories/job_interview_repository.dart';
import 'package:job_application/src/utils/firestore_exception_handler.dart';

/// Firestore implementation of [JobInterviewRepository].
///
/// Stores interviews as a subcollection under job applications:
/// `users/{userId}/job_applications/{jobApplicationId}/interviews/{interviewId}`
class FirestoreJobInterviewRepository
    with ExceptionHandler, FirestoreExceptionHandler
    implements JobInterviewRepository {
  const FirestoreJobInterviewRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<JobInterviewModel> _getCollection({
    required String userId,
    required String jobApplicationId,
  }) {
    return _firestore
        .collection(FirestoreCollections.users)
        .doc(userId)
        .collection(FirestoreCollections.jobApplications)
        .doc(jobApplicationId)
        .collection(FirestoreCollections.interviews)
        .withConverter(
          fromFirestore: (snapshot, _) =>
              JobInterviewModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  @override
  FutureResult<String> createInterview(JobInterviewEntity interview) {
    final docRef = _getCollection(
      userId: interview.userId,
      jobApplicationId: interview.jobApplicationId,
    ).doc();

    final interviewWithId = interview.copyWith(id: docRef.id);

    return handleException(
      docRef.set(JobInterviewModel.fromEntity(interviewWithId)),
      onSuccess: (_) => docRef.id,
    );
  }

  @override
  FutureResult<void> updateInterview(JobInterviewEntity interview) {
    return handleException(
      _getCollection(
            userId: interview.userId,
            jobApplicationId: interview.jobApplicationId,
          )
          .doc(interview.id)
          .update(JobInterviewModel.fromEntity(interview).toJson()),
      onSuccess: (_) {},
    );
  }

  @override
  FutureResult<void> deleteInterview({
    required String userId,
    required String jobApplicationId,
    required String interviewId,
  }) {
    return handleException(
      _getCollection(
        userId: userId,
        jobApplicationId: jobApplicationId,
      ).doc(interviewId).delete(),
      onSuccess: (_) {},
    );
  }

  @override
  Stream<List<JobInterviewEntity>> watchInterviews({
    required String userId,
    required String jobApplicationId,
  }) {
    return _getCollection(
      userId: userId,
      jobApplicationId: jobApplicationId,
    ).orderBy(InterviewFields.startTime).snapshots().map(_snapshotToEntityList);
  }

  @override
  FutureResult<List<JobInterviewEntity>> getInterviews({
    required String userId,
    required String jobApplicationId,
  }) {
    return handleException(
      _getCollection(
        userId: userId,
        jobApplicationId: jobApplicationId,
      ).orderBy(InterviewFields.startTime).get(),
      onSuccess: _snapshotToEntityList,
    );
  }

  @override
  Stream<List<JobInterviewEntity>> watchUpcomingInterviews({
    required String userId,
  }) {
    // Use collection group query to get all interviews across job applications.
    return _firestore
        .collectionGroup(FirestoreCollections.interviews)
        .where(InterviewFields.userId, isEqualTo: userId)
        .where(
          InterviewFields.startTime,
          isGreaterThanOrEqualTo: Timestamp.now(),
        )
        .orderBy(InterviewFields.startTime)
        .withConverter(
          fromFirestore: (snapshot, _) =>
              JobInterviewModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots()
        .map(_snapshotToEntityList);
  }

  List<JobInterviewEntity> _snapshotToEntityList(
    QuerySnapshot<JobInterviewModel> snapshot,
  ) {
    return snapshot.docs.map((doc) => doc.data().toEntity()).toList();
  }
}
