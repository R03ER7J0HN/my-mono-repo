import 'package:flutter_core/flutter_core.dart';
import 'package:job_application_tracker/features/home/domain/entities/application_stats.dart';
import 'package:job_application_tracker/features/home/domain/entities/interview.dart';
import 'package:job_application_tracker/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> with SafeEmitMixin<HomeState> {
  HomeCubit() : super(const HomeState());

  void loadDashboard() {
    // This is where you would call the repository in a real app.
    // For now, we'll just emit a hardcoded state for UI development.
    final fakeInterviews = [
      Interview(
        companyName: 'Tech Innovations Inc.',
        role: 'Senior Flutter Developer',
        dateTime: DateTime.now().add(const Duration(hours: 2)),
        meetingUrl: 'https://meet.google.com/xyz-abc-pqr',
      ),
    ];

    const fakeStats = ApplicationStats(
      totalApplications: 60,
      activeApplications: 25,
      interviewsScheduled: 12,
      offersReceived: 1,
      advancedApplications: 15,
    );

    safeEmit(
      state.copyWith(
        todaysInterviews: fakeInterviews,
        stats: fakeStats,
        isLoading: false,
      ),
    );
  }
}
