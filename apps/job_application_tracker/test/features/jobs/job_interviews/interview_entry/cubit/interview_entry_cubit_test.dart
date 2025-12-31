import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_entry/cubit/interview_entry_cubit.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_entry/cubit/interview_entry_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'interview_entry_cubit_test.mocks.dart';

@GenerateMocks([JobInterviewRepository])
void main() {
  late MockJobInterviewRepository mockRepository;

  final interview = JobInterviewEntity(
    id: '',
    jobApplicationId: 'job-123',
    userId: 'user-123',
    title: 'Technical Interview',
    startTime: DateTime(2024, 1, 15, 10),
    endTime: DateTime(2024, 1, 15, 11),
    meetingUrl: 'https://zoom.us/j/123',
  );

  final existingInterview = interview.copyWith(id: 'interview-123');

  setUp(() {
    mockRepository = MockJobInterviewRepository();
  });

  group('InterviewEntryCubit', () {
    blocTest<InterviewEntryCubit, InterviewEntryState>(
      'emits [loading, success] when creating interview succeeds',
      build: () {
        when(
          mockRepository.createInterview(any),
        ).thenAnswer((_) async => Result.success('interview-123'));
        return InterviewEntryCubit(mockRepository);
      },
      act: (cubit) => cubit.submitInterview(interview),
      expect: () => [
        const InterviewEntryState.loading(),
        const InterviewEntryState.success(),
      ],
      verify: (_) {
        verify(mockRepository.createInterview(any)).called(1);
        verifyNever(mockRepository.updateInterview(any));
      },
    );

    blocTest<InterviewEntryCubit, InterviewEntryState>(
      'emits [loading, failure] when creating interview fails',
      build: () {
        when(mockRepository.createInterview(any)).thenAnswer(
          (_) async => Result.failure(GenericFailure('Network error')),
        );
        return InterviewEntryCubit(mockRepository);
      },
      act: (cubit) => cubit.submitInterview(interview),
      expect: () => [
        const InterviewEntryState.loading(),
        const InterviewEntryState.failure(message: 'Network error'),
      ],
    );

    blocTest<InterviewEntryCubit, InterviewEntryState>(
      'emits [loading, success] when updating interview succeeds',
      build: () {
        when(
          mockRepository.updateInterview(any),
        ).thenAnswer((_) async => Result.success(null));
        return InterviewEntryCubit(mockRepository);
      },
      act: (cubit) => cubit.submitInterview(existingInterview),
      expect: () => [
        const InterviewEntryState.loading(),
        const InterviewEntryState.success(),
      ],
      verify: (_) {
        verifyNever(mockRepository.createInterview(any));
        verify(mockRepository.updateInterview(any)).called(1);
      },
    );

    blocTest<InterviewEntryCubit, InterviewEntryState>(
      'emits [loading, failure] when updating interview fails',
      build: () {
        when(mockRepository.updateInterview(any)).thenAnswer(
          (_) async => Result.failure(GenericFailure('Update failed')),
        );
        return InterviewEntryCubit(mockRepository);
      },
      act: (cubit) => cubit.submitInterview(existingInterview),
      expect: () => [
        const InterviewEntryState.loading(),
        const InterviewEntryState.failure(message: 'Update failed'),
      ],
    );
  });
}
