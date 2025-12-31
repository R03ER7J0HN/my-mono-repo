import 'dart:async';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:get_it/get_it.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_list/cubit/interview_list_cubit.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_list/cubit/interview_list_state.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_list/widgets/interview_list_empty.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_list/widgets/interview_list_item.dart';
import 'package:job_application_tracker/router/app_navigator.dart';
import 'package:job_application_tracker/widgets/background_decoration.dart';
import 'package:job_application_tracker/widgets/confirmation_bottom_sheet.dart';

class InterviewListScreen extends StatelessWidget {
  const InterviewListScreen({
    required this.job,
    super.key,
  });

  final JobApplicationEntity job;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = InterviewListCubit(
          GetIt.I<JobInterviewRepository>(),
          userId: job.userId,
          jobApplicationId: job.id,
        );
        unawaited(cubit.init());
        return cubit;
      },
      child: _InterviewListView(job: job),
    );
  }
}

class _InterviewListView extends StatelessWidget {
  const _InterviewListView({required this.job});

  final JobApplicationEntity job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Interviews'),
            Text(
              job.companyName,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BackgroundDecoration(
        child: SafeArea(
          child: BlocConsumer<InterviewListCubit, InterviewListState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                context.showSnackBar(
                  state.errorMessage!,
                  type: SnackBarType.error,
                );
              }
            },
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final interviews = state.interviews;
              final isEmpty = interviews.isEmpty;

              if (isEmpty) {
                return const InterviewListEmpty();
              }

              return ListView.separated(
                padding: const EdgeInsets.all(24),
                itemCount: interviews.length,
                itemBuilder: (context, index) {
                  final interview = interviews[index];
                  return Dismissible(
                    key: ValueKey(interview.id),
                    direction: DismissDirection.endToStart,
                    background: _buildDismissBackground(context),
                    confirmDismiss: (_) => _confirmDelete(context, interview),
                    onDismissed: (_) {
                      unawaited(
                        context.read<InterviewListCubit>().deleteInterview(
                          interview,
                        ),
                      );
                    },
                    child: InterviewListItem(
                      interview: interview,
                      onTap: () => _onInterviewTap(context, interview),
                      onCalendarTap: () => _addToCalendar(context, interview),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Schedule Interview'),
        onPressed: () => _onAddInterview(context),
      ),
    );
  }

  Widget _buildDismissBackground(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Icon(
        Icons.delete,
        color: Theme.of(context).colorScheme.onError,
      ),
    );
  }

  Future<bool> _confirmDelete(
    BuildContext context,
    JobInterviewEntity interview,
  ) async {
    final result = await ConfirmationBottomSheet.show<bool>(
      context,
      title: 'Delete Interview',
      message: 'Are you sure you want to delete "${interview.title}"?',
      confirmLabel: 'Delete',
      isDestructive: true,
    );
    return result ?? false;
  }

  void _onInterviewTap(BuildContext context, JobInterviewEntity interview) {
    unawaited(
      AppNavigator.pushInterviewEntry(
        context,
        job: job,
        interview: interview,
      ),
    );
  }

  void _onAddInterview(BuildContext context) {
    unawaited(AppNavigator.pushInterviewEntry(context, job: job));
  }

  Future<void> _addToCalendar(
    BuildContext context,
    JobInterviewEntity interview,
  ) async {
    final event = Event(
      title: '${interview.title} - ${job.companyName}',
      description: _buildCalendarDescription(interview),
      location: interview.location ?? interview.meetingUrl,
      startDate: interview.startTime,
      endDate:
          interview.endTime ??
          interview.startTime.add(const Duration(hours: 1)),
    );

    final success = await Add2Calendar.addEvent2Cal(event);

    if (context.mounted) {
      if (success) {
        context.showSnackBar(
          'Interview added to calendar',
          type: SnackBarType.success,
        );
        // Update the interview to mark as added to calendar
        final updatedInterview = interview.copyWith(addedToCalendar: true);
        await GetIt.I<JobInterviewRepository>().updateInterview(
          updatedInterview,
        );
      } else {
        context.showSnackBar(
          'Failed to add to calendar',
          type: SnackBarType.error,
        );
      }
    }
  }

  String _buildCalendarDescription(JobInterviewEntity interview) {
    final buffer = StringBuffer();
    buffer.writeln('Company: ${job.companyName}');
    buffer.writeln('Position: ${job.jobTitle}');

    if (interview.meetingUrl != null) {
      buffer.writeln('Meeting Link: ${interview.meetingUrl}');
    }

    if (interview.notes != null && interview.notes!.isNotEmpty) {
      buffer.writeln('Notes: ${interview.notes}');
    }

    return buffer.toString();
  }
}
