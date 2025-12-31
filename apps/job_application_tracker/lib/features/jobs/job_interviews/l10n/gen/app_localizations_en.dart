// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class JobInterviewsLocalizationsEn extends JobInterviewsLocalizations {
  JobInterviewsLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get interviewListTitle => 'Interviews';

  @override
  String get interviewEntryTitleNew => 'Schedule Interview';

  @override
  String get interviewEntryTitleEdit => 'Edit Interview';

  @override
  String get interviewFormTitle => 'Interview Title';

  @override
  String get interviewFormTitleHint => 'e.g., Phone Screening, Technical Round';

  @override
  String get interviewFormSchedule => 'Schedule';

  @override
  String get interviewFormStartDate => 'Start Date';

  @override
  String get interviewFormStartTime => 'Start Time';

  @override
  String get interviewFormEndDate => 'End Date (Optional)';

  @override
  String get interviewFormEndTime => 'End Time';

  @override
  String get interviewFormMeetingInfo => 'Meeting Info';

  @override
  String get interviewFormMeetingUrl => 'Meeting URL (Optional)';

  @override
  String get interviewFormMeetingUrlHint => 'Zoom, Google Meet, Teams link';

  @override
  String get interviewFormLocation => 'Location (Optional)';

  @override
  String get interviewFormLocationHint => 'For in-person interviews';

  @override
  String get interviewFormNotes => 'Notes (Optional)';

  @override
  String get interviewFormNotesHint => 'Interviewer name, preparation notes, etc.';

  @override
  String get interviewFormSubmitNew => 'Schedule Interview';

  @override
  String get interviewFormSubmitEdit => 'Update Interview';

  @override
  String get interviewCreatedSuccess => 'Interview scheduled successfully';

  @override
  String get interviewUpdatedSuccess => 'Interview updated successfully';

  @override
  String get interviewDeleteTitle => 'Delete Interview';

  @override
  String get interviewDeleteMessage => 'Are you sure you want to delete this interview?';

  @override
  String get interviewAddToCalendar => 'Add to Calendar';

  @override
  String get interviewInCalendar => 'In Calendar';

  @override
  String get interviewCalendarAddedSuccess => 'Interview added to calendar';

  @override
  String get interviewCalendarAddedError => 'Failed to add to calendar';

  @override
  String get interviewEmptyTitle => 'No Interviews Scheduled';

  @override
  String get interviewEmptyMessage => 'Tap the button below to schedule\nyour first interview';

  @override
  String get interviewStatusToday => 'Today';

  @override
  String get interviewStatusTomorrow => 'Tomorrow';

  @override
  String get interviewStatusUpcoming => 'Upcoming';

  @override
  String get interviewStatusPast => 'Past';

  @override
  String get interviewStatusNow => 'Now';
}
