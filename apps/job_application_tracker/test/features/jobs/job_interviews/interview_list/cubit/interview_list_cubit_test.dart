import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_list/cubit/interview_list_cubit.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_list/cubit/interview_list_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'interview_list_cubit_test.mocks.dart';

@GenerateMocks([JobInterviewRepository])
void main() {
  late MockJobInterviewRepository mockRepository;

  const userId = 'user-123';
  const jobApplicationId = 'job-123';

  final interview1 = JobInterviewEntity(
    id: 'interview-1',
    jobApplicationId: jobApplicationId,
    userId: userId,
    title: 'Phone Screening',
    startTime: DateTime(2024, 1, 15, 10),
  );

  final interview2 = JobInterviewEntity(
    id: 'interview-2',
    jobApplicationId: jobApplicationId,
    userId: userId,
    title: 'Technical Interview',
    startTime: DateTime(2024, 1, 16, 14),
  );

  setUp(() {
    mockRepository = MockJobInterviewRepository();
  });

  group('InterviewListCubit', () {
    blocTest<InterviewListCubit, InterviewListState>(
      'emits [loading, loaded] when init succeeds',
      build: () {
        when(
          mockRepository.watchInterviews(
            userId: userId,
            jobApplicationId: jobApplicationId,
          ),
        ).thenAnswer((_) => Stream.value([interview1, interview2]));
        return InterviewListCubit(
          mockRepository,
          userId: userId,
          jobApplicationId: jobApplicationId,
        );
      },
      act: (cubit) => cubit.init(),
      expect: () => [
        const InterviewListState(isLoading: true),
        InterviewListState(interviews: [interview1, interview2]),
      ],
    );

    blocTest<InterviewListCubit, InterviewListState>(
      'emits [loading, error] when init fails',
      build: () {
        when(
          mockRepository.watchInterviews(
            userId: userId,
            jobApplicationId: jobApplicationId,
          ),
        ).thenAnswer((_) => Stream.error(Exception('Stream error')));
        return InterviewListCubit(
          mockRepository,
          userId: userId,
          jobApplicationId: jobApplicationId,
        );
      },
      act: (cubit) => cubit.init(),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        const InterviewListState(isLoading: true),
        predicate<InterviewListState>(
          (state) => state.errorMessage != null,
        ),
      ],
    );

    blocTest<InterviewListCubit, InterviewListState>(
      'emits state with error when deleteInterview fails',
      build: () {
        when(
          mockRepository.watchInterviews(
            userId: userId,
            jobApplicationId: jobApplicationId,
          ),
        ).thenAnswer((_) => Stream.value([interview1]));
        when(
          mockRepository.deleteInterview(
            userId: userId,
            jobApplicationId: jobApplicationId,
            interviewId: interview1.id,
          ),
        ).thenAnswer(
          (_) async => Result.failure(GenericFailure('Delete failed')),
        );
        return InterviewListCubit(
          mockRepository,
          userId: userId,
          jobApplicationId: jobApplicationId,
        );
      },
      act: (cubit) async {
        await cubit.init();
        await cubit.deleteInterview(interview1);
      },
      expect: () => [
        const InterviewListState(isLoading: true),
        InterviewListState(interviews: [interview1]),
        InterviewListState(
          interviews: [interview1],
          errorMessage: 'Delete failed',
        ),
      ],
    );
  });
}
