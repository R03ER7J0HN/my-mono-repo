import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_stats.freezed.dart';
part 'application_stats.g.dart'; // Ensure this line is present

@freezed
sealed class ApplicationStats with _$ApplicationStats {
  const factory ApplicationStats({
    required int totalApplications,
    required int activeApplications,
    required int interviewsScheduled,
    required int offersReceived,
    required int advancedApplications,
  }) = _ApplicationStats;

  const ApplicationStats._();

  // Add fromJson factory for json_serializable
  factory ApplicationStats.fromJson(Map<String, dynamic> json) =>
      _$ApplicationStatsFromJson(json);

  double get advancementRate =>
      totalApplications > 0 ? advancedApplications / totalApplications : 0.0;
}
