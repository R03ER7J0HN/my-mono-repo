import 'package:freezed_annotation/freezed_annotation.dart';

part 'interview.freezed.dart';
part 'interview.g.dart'; // Ensure this line is present

@freezed
sealed class Interview with _$Interview {
  const factory Interview({
    required String companyName,
    required String role,
    required DateTime dateTime,
    String? meetingUrl,
  }) = _Interview;

  // Add fromJson factory for json_serializable
  factory Interview.fromJson(Map<String, dynamic> json) =>
      _$InterviewFromJson(json);
}
