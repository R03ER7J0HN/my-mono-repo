import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_application_tracker/features/home/presentation/cubit/home_cubit.dart';
import 'package:job_application_tracker/features/home/presentation/cubit/home_state.dart';
import 'package:job_application_tracker/features/home/presentation/widgets/_interview_card.dart';
import 'package:job_application_tracker/features/home/presentation/widgets/_metric_card.dart';
import 'package:job_application_tracker/features/home/presentation/widgets/_stats_card.dart';
import 'package:job_application_tracker/widgets/background_decoration.dart';
import 'package:job_application_tracker/widgets/navigation/scaffold_with_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..loadDashboard(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: BackgroundDecoration(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final stats = state.stats;

            // Determine greeting based on time of day
            final hour = DateTime.now().hour;
            var greeting = 'Good Morning';
            if (hour >= 12 && hour < 17) greeting = 'Good Afternoon';
            if (hour >= 17) greeting = 'Good Evening';

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 180,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colorScheme.primary.withValues(alpha: 0.12),
                            colorScheme.secondary.withValues(alpha: 0.08),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            greeting,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Today is ${MaterialLocalizations.of(context).formatFullDate(DateTime.now())}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (stats != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest
                                    .withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.25,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    size: 18,
                                    color: colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${stats.advancementRate * 100 ~/ 1}% advancement • ${stats.activeApplications} active',
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (stats == null)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.analytics_outlined,
                            size: 64,
                            color: theme.colorScheme.secondary.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No data available yet.',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else ...[
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate.fixed([
                        const _SectionHeader(
                          title: "Today's Interviews",
                          subtitle: 'Stay prepared for what’s ahead',
                        ),
                        const SizedBox(height: 12),
                        if (state.todaysInterviews.isNotEmpty)
                          ...state.todaysInterviews.map(
                            (interview) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: InterviewCard(interview: interview),
                            ),
                          )
                        else
                          const NoInterviewCard(),
                        const SizedBox(height: 24),
                        StatsCard(stats: stats),
                        const SizedBox(height: 28),
                        const _SectionHeader(
                          title: 'All-Time Metrics',
                          subtitle: 'Track your momentum over time',
                        ),
                        const SizedBox(height: 16),
                      ]),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      0,
                      16,
                      context.navBarPadding + 16,
                    ),
                    sliver: SliverGrid.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.25,
                      children: [
                        MetricCard(
                          label: 'Total Applications',
                          value: stats.totalApplications.toString(),
                          icon: Icons.article,
                          accentColor: colorScheme.primary,
                        ),
                        MetricCard(
                          label: 'Active Processes',
                          value: stats.activeApplications.toString(),
                          icon: Icons.hourglass_bottom,
                          accentColor: colorScheme.tertiary,
                        ),
                        MetricCard(
                          label: 'Interviews',
                          value: stats.interviewsScheduled.toString(),
                          icon: Icons.video_call,
                          accentColor: Colors.green,
                        ),
                        MetricCard(
                          label: 'Offers Received',
                          value: stats.offersReceived.toString(),
                          icon: Icons.star,
                          accentColor: Colors.amber,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
