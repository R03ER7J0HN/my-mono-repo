import 'dart:async';

import 'package:authentication/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_details/cubit/job_details_cubit.dart';
import 'package:job_application_tracker/features/jobs/job_details/cubit/job_details_state.dart';
import 'package:job_application_tracker/features/jobs/job_details/widgets/job_form.dart';
import 'package:job_application_tracker/widgets/background_decoration.dart';

class JobEntryScreen extends StatelessWidget {
  const JobEntryScreen({super.key, this.job});

  final JobApplicationEntity? job;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JobDetailsCubit(
        GetIt.I<JobApplicationRepository>(),
        GetIt.I<AuthenticationRepository>(),
      ),
      child: _JobEntryView(job: job),
    );
  }
}

class _JobEntryView extends StatelessWidget {
  const _JobEntryView({this.job});

  final JobApplicationEntity? job;

  bool get _isEditing => job != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Application' : 'New Application'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: BackgroundDecoration(
        child: SafeArea(
          child: BlocConsumer<JobDetailsCubit, JobDetailsState>(
            listener: (context, state) {
              state.whenOrNull(
                success: () => context
                  ..showSnackBar(
                    _isEditing
                        ? 'Application updated successfully'
                        : 'Application created successfully',
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
                child: JobForm(
                  job: job,
                  isLoading: isLoading,
                  onSubmit: (job) {
                    unawaited(context.read<JobDetailsCubit>().submitJob(job));
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
