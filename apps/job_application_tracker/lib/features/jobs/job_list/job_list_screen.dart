import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/application/di/injector.dart';
import 'package:job_application_tracker/features/jobs/job_list/cubit/cubit.dart';
import 'package:job_application_tracker/features/jobs/job_list/widgets/job_list_empty.dart';
import 'package:job_application_tracker/features/jobs/job_list/widgets/job_list_header.dart';
import 'package:job_application_tracker/features/jobs/job_list/widgets/job_list_item.dart';
import 'package:job_application_tracker/router/app_navigator.dart';
import 'package:job_application_tracker/widgets/background_decoration.dart';

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
      child: Scaffold(
        body: BackgroundDecoration(
          child: SafeArea(
            child: BlocBuilder<JobListCubit, JobListState>(
              builder: (context, state) {
                return state.when(
                  initial: SizedBox.shrink,
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (jobs) {
                    final isEmpty = jobs.isEmpty;

                    return Stack(
                      children: [
                        CustomScrollView(
                          physics: isEmpty
                              ? const NeverScrollableScrollPhysics()
                              : null,
                          slivers: [
                            const SliverToBoxAdapter(child: JobListHeader()),
                            if (!isEmpty) ...[
                              SliverPadding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                sliver: SliverList.separated(
                                  itemCount: jobs.length,
                                  itemBuilder: (_, index) {
                                    return JobListItem(job: jobs[index]);
                                  },
                                  separatorBuilder: (_, _) {
                                    return const SizedBox(height: 12);
                                  },
                                ),
                              ),
                              const SliverPadding(
                                padding: EdgeInsets.only(
                                  bottom: kBottomNavigationBarHeight,
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (isEmpty) const JobListEmpty(),
                      ],
                    );
                  },
                  error: (message) => Center(
                    child: Text(
                      'Error: $message',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(
            bottom: kBottomNavigationBarHeight + 30,
            right: 10,
          ),
          child: FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: const Text('New Application'),
            onPressed: () {
              unawaited(AppNavigator.pushJobEntry<void>(context));
            },
          ),
        ),
      ),
    );
  }
}
