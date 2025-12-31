import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of JobInterviewsLocalizations
/// returned by `JobInterviewsLocalizations.of(context)`.
///
/// Applications need to include `JobInterviewsLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: JobInterviewsLocalizations.localizationsDelegates,
///   supportedLocales: JobInterviewsLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the JobInterviewsLocalizations.supportedLocales
/// property.
abstract class JobInterviewsLocalizations {
  JobInterviewsLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static JobInterviewsLocalizations of(BuildContext context) {
    return Localizations.of<JobInterviewsLocalizations>(context, JobInterviewsLocalizations)!;
  }

  static const LocalizationsDelegate<JobInterviewsLocalizations> delegate = _JobInterviewsLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @interviewListTitle.
  ///
  /// In en, this message translates to:
  /// **'Interviews'**
  String get interviewListTitle;

  /// No description provided for @interviewEntryTitleNew.
  ///
  /// In en, this message translates to:
  /// **'Schedule Interview'**
  String get interviewEntryTitleNew;

  /// No description provided for @interviewEntryTitleEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Interview'**
  String get interviewEntryTitleEdit;

  /// No description provided for @interviewFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Interview Title'**
  String get interviewFormTitle;

  /// No description provided for @interviewFormTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Phone Screening, Technical Round'**
  String get interviewFormTitleHint;

  /// No description provided for @interviewFormSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get interviewFormSchedule;

  /// No description provided for @interviewFormStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get interviewFormStartDate;

  /// No description provided for @interviewFormStartTime.
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get interviewFormStartTime;

  /// No description provided for @interviewFormEndDate.
  ///
  /// In en, this message translates to:
  /// **'End Date (Optional)'**
  String get interviewFormEndDate;

  /// No description provided for @interviewFormEndTime.
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get interviewFormEndTime;

  /// No description provided for @interviewFormMeetingInfo.
  ///
  /// In en, this message translates to:
  /// **'Meeting Info'**
  String get interviewFormMeetingInfo;

  /// No description provided for @interviewFormMeetingUrl.
  ///
  /// In en, this message translates to:
  /// **'Meeting URL (Optional)'**
  String get interviewFormMeetingUrl;

  /// No description provided for @interviewFormMeetingUrlHint.
  ///
  /// In en, this message translates to:
  /// **'Zoom, Google Meet, Teams link'**
  String get interviewFormMeetingUrlHint;

  /// No description provided for @interviewFormLocation.
  ///
  /// In en, this message translates to:
  /// **'Location (Optional)'**
  String get interviewFormLocation;

  /// No description provided for @interviewFormLocationHint.
  ///
  /// In en, this message translates to:
  /// **'For in-person interviews'**
  String get interviewFormLocationHint;

  /// No description provided for @interviewFormNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes (Optional)'**
  String get interviewFormNotes;

  /// No description provided for @interviewFormNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Interviewer name, preparation notes, etc.'**
  String get interviewFormNotesHint;

  /// No description provided for @interviewFormSubmitNew.
  ///
  /// In en, this message translates to:
  /// **'Schedule Interview'**
  String get interviewFormSubmitNew;

  /// No description provided for @interviewFormSubmitEdit.
  ///
  /// In en, this message translates to:
  /// **'Update Interview'**
  String get interviewFormSubmitEdit;

  /// No description provided for @interviewCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Interview scheduled successfully'**
  String get interviewCreatedSuccess;

  /// No description provided for @interviewUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Interview updated successfully'**
  String get interviewUpdatedSuccess;

  /// No description provided for @interviewDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Interview'**
  String get interviewDeleteTitle;

  /// No description provided for @interviewDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this interview?'**
  String get interviewDeleteMessage;

  /// No description provided for @interviewAddToCalendar.
  ///
  /// In en, this message translates to:
  /// **'Add to Calendar'**
  String get interviewAddToCalendar;

  /// No description provided for @interviewInCalendar.
  ///
  /// In en, this message translates to:
  /// **'In Calendar'**
  String get interviewInCalendar;

  /// No description provided for @interviewCalendarAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Interview added to calendar'**
  String get interviewCalendarAddedSuccess;

  /// No description provided for @interviewCalendarAddedError.
  ///
  /// In en, this message translates to:
  /// **'Failed to add to calendar'**
  String get interviewCalendarAddedError;

  /// No description provided for @interviewEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Interviews Scheduled'**
  String get interviewEmptyTitle;

  /// No description provided for @interviewEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Tap the button below to schedule\nyour first interview'**
  String get interviewEmptyMessage;

  /// No description provided for @interviewStatusToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get interviewStatusToday;

  /// No description provided for @interviewStatusTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get interviewStatusTomorrow;

  /// No description provided for @interviewStatusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get interviewStatusUpcoming;

  /// No description provided for @interviewStatusPast.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get interviewStatusPast;

  /// No description provided for @interviewStatusNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get interviewStatusNow;
}

class _JobInterviewsLocalizationsDelegate extends LocalizationsDelegate<JobInterviewsLocalizations> {
  const _JobInterviewsLocalizationsDelegate();

  @override
  Future<JobInterviewsLocalizations> load(Locale locale) {
    return SynchronousFuture<JobInterviewsLocalizations>(lookupJobInterviewsLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_JobInterviewsLocalizationsDelegate old) => false;
}

JobInterviewsLocalizations lookupJobInterviewsLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return JobInterviewsLocalizationsEn();
  }

  throw FlutterError(
    'JobInterviewsLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
