import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_entry/cubit/interview_entry_cubit.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_entry/cubit/interview_entry_state.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_entry/widgets/interview_form.dart';
import 'package:job_application_tracker/widgets/background_decoration.dart';

class InterviewEntryScreen extends StatelessWidget {
  const InterviewEntryScreen({
    required this.job,
    super.key,
    this.interview,
  });

  final JobApplicationEntity job;
  final JobInterviewEntity? interview;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InterviewEntryCubit(
        GetIt.I<JobInterviewRepository>(),
      ),
      child: _InterviewEntryView(job: job, interview: interview),
    );
  }
}

class _InterviewEntryView extends StatelessWidget {
  const _InterviewEntryView({
    required this.job,
    this.interview,
  });

  final JobApplicationEntity job;
  final JobInterviewEntity? interview;

  bool get _isEditing => interview != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Interview' : 'Schedule Interview'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BackgroundDecoration(
        child: SafeArea(
          child: BlocConsumer<InterviewEntryCubit, InterviewEntryState>(
            listener: (context, state) {
              state.whenOrNull(
                success: () => context
                  ..showSnackBar(
                    _isEditing
                        ? 'Interview updated successfully'
                        : 'Interview scheduled successfully',
                    type: SnackBarType.success,
                  )
                  ..pop(),
                failure: (message) => context.showSnackBar(
                  message,
                  type: SnackBarType.error,
                ),
              );
            },
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );

              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: InterviewForm(
                  jobApplicationId: job.id,
                  userId: job.userId,
                  interview: interview,
                  isLoading: isLoading,
                  onSubmit: (interview) {
                    unawaited(
                      context.read<InterviewEntryCubit>().submitInterview(
                        interview,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
