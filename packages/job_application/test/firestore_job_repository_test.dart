import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_application/src/data/constants/firestore_constants.dart';
import 'package:job_application/src/data/models/job_application_model.dart';
import 'package:job_application/src/data/repositories/firestore_job_repository.dart';
import 'package:job_application/src/domain/entities/job_application_entity.dart';
import 'package:job_application/src/domain/entities/job_enums.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firestore_job_repository_test.mocks.dart';

@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  QuerySnapshot,
  QueryDocumentSnapshot,
])
void main() {
  late FirestoreJobApplicationRepository repository;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockUsersCollection;
  late MockDocumentReference<Map<String, dynamic>> mockUserDoc;
  late MockCollectionReference<Map<String, dynamic>> mockJobCollection;
  late MockCollectionReference<JobApplicationModel> mockConvertedCollection;
  late MockDocumentReference<JobApplicationModel> mockJobDoc;
  late MockQuerySnapshot<JobApplicationModel> mockQuerySnapshot;
  late MockQueryDocumentSnapshot<JobApplicationModel> mockQueryDocumentSnapshot;

  const userId = 'user-123';
  const jobId = 'job-123';

  final jobEntity = JobApplicationEntity(
    id: jobId,
    userId: userId,
    companyName: 'Tech Corp',
    jobTitle: 'Flutter Developer',
    jobLink: 'https://example.com/job',
    platform: JobPlatform.linkedIn,
    workSetup: WorkSetup.remote,
    employmentType: EmploymentType.fullTime,
    dateApplied: DateTime(2023, 10),
  );

  final jobModel = JobApplicationModel.fromEntity(jobEntity);

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockUsersCollection = MockCollectionReference<Map<String, dynamic>>();
    mockUserDoc = MockDocumentReference<Map<String, dynamic>>();
    mockJobCollection = MockCollectionReference<Map<String, dynamic>>();
    mockConvertedCollection = MockCollectionReference<JobApplicationModel>();
    mockJobDoc = MockDocumentReference<JobApplicationModel>();
    mockQuerySnapshot = MockQuerySnapshot<JobApplicationModel>();
    mockQueryDocumentSnapshot =
        MockQueryDocumentSnapshot<JobApplicationModel>();

    provideDummy<JobApplicationModel>(jobModel);

    repository = FirestoreJobApplicationRepository(mockFirestore);

    // Setup the chain of calls
    when(
      mockFirestore.collection(FirestoreCollections.users),
    ).thenReturn(mockUsersCollection);
    when(mockUsersCollection.doc(userId)).thenReturn(mockUserDoc);
    when(
      mockUserDoc.collection(FirestoreCollections.jobApplications),
    ).thenReturn(mockJobCollection);
    when(
      mockJobCollection.withConverter<JobApplicationModel>(
        fromFirestore: anyNamed('fromFirestore'),
        toFirestore: anyNamed('toFirestore'),
      ),
    ).thenReturn(mockConvertedCollection);
  });

  group('createJob', () {
    test('should call set on document reference and return job ID', () async {
      when(mockConvertedCollection.doc(any)).thenReturn(mockJobDoc);
      when(mockJobDoc.id).thenReturn(jobId);
      when(mockJobDoc.set(any)).thenAnswer((_) async {});

      final result = await repository.createJob(jobEntity);

      verify(mockConvertedCollection.doc()).called(1);
      verify(mockJobDoc.set(any)).called(1);
      expect(result.isSuccess, true);
      expect(result.getSuccess(), jobId);
    });

    test('should return Failure when set fails', () async {
      when(mockConvertedCollection.doc(any)).thenReturn(mockJobDoc);
      when(mockJobDoc.id).thenReturn(jobId);
      when(
        mockJobDoc.set(any),
      ).thenAnswer((_) async => throw FirebaseException(plugin: 'firestore'));

      final result = await repository.createJob(jobEntity);

      verify(mockJobDoc.set(any)).called(1);
      expect(result.isFailure, true);
    });
  });

  group('updateJob', () {
    test('should call update with correct data', () async {
      when(mockConvertedCollection.doc(jobId)).thenReturn(mockJobDoc);
      when(mockJobDoc.update(any)).thenAnswer((_) async {});

      final result = await repository.updateJob(jobEntity);

      verify(mockConvertedCollection.doc(jobId)).called(1);
      verify(mockJobDoc.update(any)).called(1);
      expect(result.isSuccess, true);
    });
  });

  group('deleteJob', () {
    test('should call delete on document reference', () async {
      when(mockConvertedCollection.doc(jobId)).thenReturn(mockJobDoc);
      when(mockJobDoc.delete()).thenAnswer((_) async {});

      final result = await repository.deleteJob(userId: userId, jobId: jobId);

      verify(mockConvertedCollection.doc(jobId)).called(1);
      verify(mockJobDoc.delete()).called(1);
      expect(result.isSuccess, true);
    });
  });

  group('getJobs', () {
    test('should call get and return list of jobs', () async {
      when(
        mockConvertedCollection.orderBy(
          JobFields.dateApplied,
          descending: true,
        ),
      ).thenReturn(mockConvertedCollection);
      when(
        mockConvertedCollection.get(),
      ).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
      when(mockQueryDocumentSnapshot.data()).thenReturn(jobModel);

      final result = await repository.getJobs(userId);

      verify(mockConvertedCollection.get()).called(1);
      expect(result.isSuccess, true);
      expect(result.getSuccess().length, 1);
      expect(result.getSuccess().first.id, jobEntity.id);
    });
  });

  group('watchJobs', () {
    test('should return stream of jobs', () {
      when(
        mockConvertedCollection.orderBy(
          JobFields.dateApplied,
          descending: true,
        ),
      ).thenReturn(mockConvertedCollection);
      when(
        mockConvertedCollection.snapshots(),
      ).thenAnswer((_) => Stream.value(mockQuerySnapshot));
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);
      when(mockQueryDocumentSnapshot.data()).thenReturn(jobModel);

      final stream = repository.watchJobs(userId);

      expect(stream, emits(isA<List<JobApplicationEntity>>()));
    });
  });
}
