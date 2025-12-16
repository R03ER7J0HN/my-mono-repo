import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:get_it/get_it.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/application/di/injector.dart';
import 'package:job_application_tracker/features/jobs/job_list/cubit/cubit.dart';
import 'package:job_application_tracker/features/jobs/job_list/widgets/dismissible_job_item.dart';
import 'package:job_application_tracker/features/jobs/job_list/widgets/job_list_empty.dart';
import 'package:job_application_tracker/features/jobs/job_list/widgets/job_list_header.dart';
import 'package:job_application_tracker/router/app_navigator.dart';
import 'package:job_application_tracker/widgets/background_decoration.dart';
import 'package:job_application_tracker/widgets/navigation/scaffold_with_nav_bar.dart';

class JobListScreen extends StatelessWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = JobListCubit(
          GetIt.I<JobApplicationRepository>(),
          GetIt.I<AuthenticationRepository>(),
        );
        unawaited(cubit.init());

        return cubit;
      },
      child: const _JobListView(),
    );
  }
}

class _JobListView extends StatefulWidget {
  const _JobListView();

  @override
  State<_JobListView> createState() => _JobListViewState();
}

class _JobListViewState extends State<_JobListView> {
  final _swipeController = SwipeToDeleteController();

  @override
  void dispose() {
    _swipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundDecoration(
        child: BlocConsumer<JobListCubit, JobListState>(
          listener: (context, state) {
            final errorMessage = state.errorMessage;

            if (errorMessage != null) {
              context.showSnackBar(errorMessage, type: SnackBarType.error);
            }
          },
          builder: (context, state) {
            if (state.isLoading ?? false) {
              return const Center(child: CircularProgressIndicator());
            }

            final jobs = state.jobs;
            final isEmpty = state.jobs.isEmpty;

            return SafeArea(
              child: GestureDetector(
                onTap: _swipeController.closeAll,
                behavior: HitTestBehavior.translucent,
                child: Stack(
                  children: [
                    CustomScrollView(
                      physics: isEmpty
                          ? const NeverScrollableScrollPhysics()
                          : null,
                      slivers: [
                        const SliverToBoxAdapter(child: JobListHeader()),
                        if (!isEmpty) ...[
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            sliver: SliverList.separated(
                              itemCount: jobs.length,
                              itemBuilder: (_, index) {
                                final job = jobs[index];
                                return DismissibleJobItem(
                                  job: job,
                                  controller: _swipeController,
                                  onTap: () {
                                    unawaited(
                                      AppNavigator.pushJobEntry(
                                        context,
                                        job: job,
                                      ),
                                    );
                                  },
                                  onDismissed: (job) {
                                    unawaited(context.cubit.deleteJob(job));
                                  },
                                );
                              },
                              separatorBuilder: (_, _) {
                                return const SizedBox(height: 12);
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (isEmpty) const JobListEmpty(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.navBarPadding),
      child: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('New Application'),
        onPressed: () {
          unawaited(AppNavigator.pushJobEntry(context));
        },
      ),
    );
  }
}

extension _CubitX on BuildContext {
  JobListCubit get cubit => read<JobListCubit>();
}
