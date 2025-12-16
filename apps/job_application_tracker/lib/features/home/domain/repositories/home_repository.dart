import 'package:job_application_tracker/features/home/domain/entities/application_stats.dart';
import 'package:job_application_tracker/features/home/domain/entities/interview.dart';

abstract class IHomeRepository {
  Future<List<Interview>> getTodaysInterviews();
  Future<ApplicationStats> getApplicationStats();
}
