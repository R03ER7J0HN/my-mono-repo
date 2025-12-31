import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_interviews/interview_entry/constants/interview_form_keys.dart';
import 'package:job_application_tracker/widgets/form/app_date_picker.dart';
import 'package:job_application_tracker/widgets/form/app_text_field.dart';
import 'package:job_application_tracker/widgets/form/app_time_picker.dart';
import 'package:job_application_tracker/widgets/glass_card.dart';

class InterviewForm extends StatefulWidget {
  const InterviewForm({
    required this.jobApplicationId,
    required this.userId,
    required this.isLoading,
    required this.onSubmit,
    super.key,
    this.interview,
  });

  final String jobApplicationId;
  final String userId;
  final JobInterviewEntity? interview;
  final bool isLoading;
  final ValueChanged<JobInterviewEntity> onSubmit;

  @override
  State<InterviewForm> createState() => _InterviewFormState();
}

class _InterviewFormState extends State<InterviewForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool get _isEditing => widget.interview != null;

  Map<String, dynamic> get _initialValues {
    final interview = widget.interview;

    if (interview == null) {
      final now = DateTime.now();
      final defaultStart = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour + 1,
      );

      return {
        InterviewFormKeys.startDate: defaultStart,
        InterviewFormKeys.startTime: TimeOfDay.fromDateTime(defaultStart),
      };
    }

    return {
      InterviewFormKeys.title: interview.title,
      InterviewFormKeys.startDate: interview.startTime,
      InterviewFormKeys.startTime: TimeOfDay.fromDateTime(interview.startTime),
      if (interview.endTime != null) ...{
        InterviewFormKeys.endDate: interview.endTime,
        InterviewFormKeys.endTime: TimeOfDay.fromDateTime(interview.endTime!),
      },
      InterviewFormKeys.meetingUrl: interview.meetingUrl,
      InterviewFormKeys.location: interview.location,
      InterviewFormKeys.notes: interview.notes,
    };
  }

  void _onSubmit() {
    if (_formKey.currentState?.saveAndValidate(
          autoScrollWhenFocusOnInvalid: true,
        ) ??
        false) {
      final formData = _formKey.currentState!.value;

      final startDate = formData[InterviewFormKeys.startDate] as DateTime;
      final startTime = formData[InterviewFormKeys.startTime] as TimeOfDay;
      final endDate = formData[InterviewFormKeys.endDate] as DateTime?;
      final endTime = formData[InterviewFormKeys.endTime] as TimeOfDay?;

      final startDateTime = DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
        startTime.hour,
        startTime.minute,
      );

      DateTime? endDateTime;
      if (endDate != null && endTime != null) {
        endDateTime = DateTime(
          endDate.year,
          endDate.month,
          endDate.day,
          endTime.hour,
          endTime.minute,
        );
      }

      final interview = JobInterviewEntity(
        id: widget.interview?.id ?? '',
        jobApplicationId: widget.jobApplicationId,
        userId: widget.userId,
        title: formData[InterviewFormKeys.title] as String,
        startTime: startDateTime,
        endTime: endDateTime,
        meetingUrl: formData[InterviewFormKeys.meetingUrl] as String?,
        location: formData[InterviewFormKeys.location] as String?,
        notes: formData[InterviewFormKeys.notes] as String?,
        addedToCalendar: widget.interview?.addedToCalendar ?? false,
      );

      widget.onSubmit(interview);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: GlassCard(
                padding: const EdgeInsets.all(24),
                child: FormBuilder(
                  key: _formKey,
                  initialValue: _initialValues,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSectionTitle('Interview Details'),
                      const SizedBox(height: 16),
                      AppTextField(
                        name: InterviewFormKeys.title,
                        label: 'Interview Title',
                        icon: Icons.event,
                        hintText: 'e.g., Phone Screening, Technical Round',
                        validator: FormBuilderValidators.required(),
                      ),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Schedule'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: AppDatePicker(
                              name: InterviewFormKeys.startDate,
                              label: 'Start Date',
                              icon: Icons.calendar_today,
                              validator: FormBuilderValidators.required(),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: AppTimePicker(
                              name: InterviewFormKeys.startTime,
                              label: 'Start Time',
                              icon: Icons.access_time,
                              validator: FormBuilderValidators.required(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: AppDatePicker(
                              name: InterviewFormKeys.endDate,
                              label: 'End Date (Optional)',
                              icon: Icons.calendar_today,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: AppTimePicker(
                              name: InterviewFormKeys.endTime,
                              label: 'End Time',
                              icon: Icons.access_time,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Meeting Info'),
                      const SizedBox(height: 16),
                      AppTextField(
                        name: InterviewFormKeys.meetingUrl,
                        label: 'Meeting URL (Optional)',
                        icon: Icons.video_call,
                        hintText: 'Zoom, Google Meet, Teams link',
                        keyboardType: TextInputType.url,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.url(
                            requireTld: false,
                            errorText: 'Please enter a valid URL',
                          ),
                        ]),
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        name: InterviewFormKeys.location,
                        label: 'Location (Optional)',
                        icon: Icons.location_on,
                        hintText: 'For in-person interviews',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        name: InterviewFormKeys.notes,
                        label: 'Notes (Optional)',
                        icon: Icons.notes,
                        hintText: 'Interviewer name, preparation notes, etc.',
                        maxLines: 4,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: widget.isLoading ? null : _onSubmit,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: widget.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      _isEditing ? 'Update Interview' : 'Schedule Interview',
                    ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
