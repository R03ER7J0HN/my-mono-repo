import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_application/src/data/constants/firestore_constants.dart';
import 'package:job_application/src/data/models/job_interview_model.dart';
import 'package:job_application/src/data/repositories/firestore_job_interview_repository.dart';
import 'package:job_application/src/domain/entities/job_interview_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firestore_job_interview_repository_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  QuerySnapshot,
  QueryDocumentSnapshot,
  Query,
])
void main() {
  late FirestoreJobInterviewRepository repository;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockUsersCollection;
  late MockDocumentReference<Map<String, dynamic>> mockUserDoc;
  late MockCollectionReference<Map<String, dynamic>> mockJobsCollection;
  late MockDocumentReference<Map<String, dynamic>> mockJobDoc;
  late MockCollectionReference<Map<String, dynamic>> mockInterviewsCollection;
  late MockCollectionReference<JobInterviewModel> mockConvertedCollection;
  late MockDocumentReference<JobInterviewModel> mockInterviewDoc;
  late MockQuerySnapshot<JobInterviewModel> mockQuerySnapshot;
  late MockQueryDocumentSnapshot<JobInterviewModel> mockQueryDocumentSnapshot;
  late MockQuery<JobInterviewModel> mockQuery;

  const userId = 'user-123';
  const jobApplicationId = 'job-123';
  const interviewId = 'interview-123';

  final interviewEntity = JobInterviewEntity(
    id: interviewId,
    jobApplicationId: jobApplicationId,
    userId: userId,
    title: 'Technical Interview',
    startTime: DateTime(2024, 1, 15, 10),
    endTime: DateTime(2024, 1, 15, 11),
    meetingUrl: 'https://zoom.us/j/123',
    notes: 'Prepare for system design questions',
  );

  final interviewModel = JobInterviewModel.fromEntity(interviewEntity);

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockUsersCollection = MockCollectionReference<Map<String, dynamic>>();
    mockUserDoc = MockDocumentReference<Map<String, dynamic>>();
    mockJobsCollection = MockCollectionReference<Map<String, dynamic>>();
    mockJobDoc = MockDocumentReference<Map<String, dynamic>>();
    mockInterviewsCollection = MockCollectionReference<Map<String, dynamic>>();
    mockConvertedCollection = MockCollectionReference<JobInterviewModel>();
    mockInterviewDoc = MockDocumentReference<JobInterviewModel>();
    mockQuerySnapshot = MockQuerySnapshot<JobInterviewModel>();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot<JobInterviewModel>();
    mockQuery = MockQuery<JobInterviewModel>();

    provideDummy<JobInterviewModel>(interviewModel);

    repository = FirestoreJobInterviewRepository(mockFirestore);

    // Setup the chain of calls
    when(
      mockFirestore.collection(FirestoreCollections.users),
    ).thenReturn(mockUsersCollection);
    when(mockUsersCollection.doc(userId)).thenReturn(mockUserDoc);
    when(
      mockUserDoc.collection(FirestoreCollections.jobApplications),
    ).thenReturn(mockJobsCollection);
    when(mockJobsCollection.doc(jobApplicationId)).thenReturn(mockJobDoc);
    when(
      mockJobDoc.collection(FirestoreCollections.interviews),
    ).thenReturn(mockInterviewsCollection);
    when(
      mockInterviewsCollection.withConverter<JobInterviewModel>(
        fromFirestore: anyNamed('fromFirestore'),
        toFirestore: anyNamed('toFirestore'),
      ),
    ).thenReturn(mockConvertedCollection);
  });

  group('createInterview', () {
    test(
      'should call set on document reference and return interview ID',
      () async {
        when(mockConvertedCollection.doc(any)).thenReturn(mockInterviewDoc);
        when(mockInterviewDoc.id).thenReturn(interviewId);
        when(mockInterviewDoc.set(any)).thenAnswer((_) async {});

        final result = await repository.createInterview(interviewEntity);

        verify(mockConvertedCollection.doc()).called(1);
        verify(mockInterviewDoc.set(any)).called(1);
        expect(result.isSuccess, true);
        expect(result.getSuccess(), interviewId);
      },
    );

    test('should return Failure when set fails', () async {
      when(mockConvertedCollection.doc(any)).thenReturn(mockInterviewDoc);
      when(mockInterviewDoc.id).thenReturn(interviewId);
      when(
        mockInterviewDoc.set(any),
      ).thenAnswer((_) async => throw FirebaseException(plugin: 'firestore'));

      final result = await repository.createInterview(interviewEntity);

      verify(mockInterviewDoc.set(any)).called(1);
      expect(result.isFailure, true);
    });
  });

  group('updateInterview', () {
    test('should call update with correct data', () async {
      when(
        mockConvertedCollection.doc(interviewId),
      ).thenReturn(mockInterviewDoc);
      when(mockInterviewDoc.update(any)).thenAnswer((_) async {});

      final result = await repository.updateInterview(interviewEntity);

      verify(mockConvertedCollection.doc(interviewId)).called(1);
      verify(mockInterviewDoc.update(any)).called(1);
      expect(result.isSuccess, true);
    });
  });

  group('deleteInterview', () {
    test('should call delete on document reference', () async {
      when(
        mockConvertedCollection.doc(interviewId),
      ).thenReturn(mockInterviewDoc);
      when(mockInterviewDoc.delete()).thenAnswer((_) async {});

      final result = await repository.deleteInterview(
        userId: userId,
        jobApplicationId: jobApplicationId,
        interviewId: interviewId,
      );

      verify(mockConvertedCollection.doc(interviewId)).called(1);
      verify(mockInterviewDoc.delete()).called(1);
      expect(result.isSuccess, true);
    });
  });

  group('getInterviews', () {
    test('should call get and return list of interviews', () async {
      when(
        mockConvertedCollection.orderBy(InterviewFields.startTime),
      ).thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
      when(mockQueryDocumentSnapshot.data()).thenReturn(interviewModel);

      final result = await repository.getInterviews(
        userId: userId,
        jobApplicationId: jobApplicationId,
      );

      verify(mockQuery.get()).called(1);
      expect(result.isSuccess, true);
      expect(result.getSuccess(), hasLength(1));
      expect(result.getSuccess().first.title, 'Technical Interview');
    });
  });
}
