import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:job_application_tracker/features/home/domain/entities/application_stats.dart';
import 'package:job_application_tracker/features/home/domain/entities/interview.dart';

part 'home_state.freezed.dart';
part 'home_state.g.dart'; // Ensure this line is present

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<Interview> todaysInterviews,
    ApplicationStats? stats,
    @Default(true) bool isLoading,
    String? error,
  }) = _HomeState;

  // Add fromJson factory for json_serializable
  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
}