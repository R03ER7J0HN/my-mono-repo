import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_details/constants/job_form_keys.dart';
import 'package:job_application_tracker/widgets/form/app_currency_picker.dart';
import 'package:job_application_tracker/widgets/form/app_date_picker.dart';
import 'package:job_application_tracker/widgets/form/app_dropdown.dart';
import 'package:job_application_tracker/widgets/form/app_text_field.dart';
import 'package:job_application_tracker/widgets/glass_card.dart';
import 'package:job_application_tracker/widgets/shimmer_box.dart';

class JobForm extends StatefulWidget {
  const JobForm({
    required this.isLoading,
    required this.onSubmit,
    super.key,
    this.job,
  });

  final JobApplicationEntity? job;
  final bool isLoading;
  final ValueChanged<JobApplicationEntity> onSubmit;

  Map<String, dynamic> get initialValues {
    const defaultCurrency = 'PHP';

    final job = this.job;

    if (job == null) {
      return {
        JobFormKeys.status: JobStatus.applied,
        JobFormKeys.platform: JobPlatform.other,
        JobFormKeys.workSetup: WorkSetup.remote,
        JobFormKeys.employmentType: EmploymentType.fullTime,
        JobFormKeys.dateApplied: DateTime.now(),
        JobFormKeys.currency: defaultCurrency,
      };
    }

    return {
      JobFormKeys.companyName: job.companyName,
      JobFormKeys.jobTitle: job.jobTitle,
      JobFormKeys.jobLink: job.jobLink,
      JobFormKeys.platform: job.platform,
      JobFormKeys.workSetup: job.workSetup,
      JobFormKeys.employmentType: job.employmentType,
      JobFormKeys.dateApplied: job.dateApplied,
      JobFormKeys.recruiterName: job.recruiterName,
      JobFormKeys.salaryRequested: job.salaryRequested?.toString(),
      JobFormKeys.currency: job.currency ?? defaultCurrency,
      JobFormKeys.notes: job.notes,
      JobFormKeys.status: job.status,
    };
  }

  @override
  State<JobForm> createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _currencySymbol = ValueNotifier<String>(r'$');

  bool get _isEditing => widget.job != null;
  Map<String, dynamic> get _initialValues => widget.initialValues;

  @override
  void initState() {
    super.initState();

    final currencyCode = _initialValues[JobFormKeys.currency] as String;
    final currency = CurrencyService().findByCode(currencyCode);
    if (currency != null) {
      _currencySymbol.value = currency.symbol;
    }
  }

  @override
  void dispose() {
    _currencySymbol.dispose();
    super.dispose();
  }

  void _onJobLinkChanged(String? value) {
    final platform = value == null
        ? JobPlatform.other
        : JobPlatform.fromUrl(value);

    _formKey.currentState?.fields[JobFormKeys.platform]?.didChange(platform);
  }

  void _onSubmit() {
    if (_formKey.currentState?.saveAndValidate(
          autoScrollWhenFocusOnInvalid: true,
        ) ??
        false) {
      final formData = _formKey.currentState!.value;

      final job = JobApplicationEntity(
        id: widget.job?.id ?? '',
        userId: widget.job?.userId ?? '',
        companyName: formData[JobFormKeys.companyName] as String,
        jobTitle: formData[JobFormKeys.jobTitle] as String,
        jobLink: formData[JobFormKeys.jobLink] as String,
        platform: formData[JobFormKeys.platform] as JobPlatform,
        workSetup: formData[JobFormKeys.workSetup] as WorkSetup,
        employmentType: formData[JobFormKeys.employmentType] as EmploymentType,
        dateApplied: formData[JobFormKeys.dateApplied] as DateTime,
        recruiterName: formData[JobFormKeys.recruiterName] as String?,
        salaryRequested: formData[JobFormKeys.salaryRequested] != null
            ? int.tryParse(
                formData[JobFormKeys.salaryRequested] as String,
              )
            : null,
        currency: formData[JobFormKeys.currency] as String?,
        notes: formData[JobFormKeys.notes] as String?,
        status: formData[JobFormKeys.status] as JobStatus,
      );

      widget.onSubmit(job);
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
                      _buildSectionTitle('Basic Information'),
                      const SizedBox(height: 16),
                      AppTextField(
                        name: JobFormKeys.companyName,
                        label: 'Company Name',
                        icon: Icons.business,
                        maxLines: 2,
                        validator: FormBuilderValidators.required(),
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        name: JobFormKeys.jobTitle,
                        label: 'Job Title',
                        icon: Icons.work,
                        validator: FormBuilderValidators.required(),
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        name: JobFormKeys.jobLink,
                        label: 'Job Link',
                        icon: Icons.link,
                        onChanged: _onJobLinkChanged,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.url(),
                        ]),
                      ),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Job Details'),
                      const SizedBox(height: 16),
                      AppDropdown<JobPlatform>(
                        name: JobFormKeys.platform,
                        label: 'Platform',
                        icon: Icons.public,
                        items: JobPlatform.values,
                        itemBuilder: (platform) => platform.displayName,
                      ),
                      const SizedBox(height: 16),
                      AppDropdown<WorkSetup>(
                        name: JobFormKeys.workSetup,
                        label: 'Work Setup',
                        icon: Icons.laptop,
                        items: WorkSetup.values,
                        itemBuilder: (setup) => setup.name.capitalize,
                      ),
                      const SizedBox(height: 16),
                      AppDropdown<EmploymentType>(
                        name: JobFormKeys.employmentType,
                        label: 'Employment Type',
                        icon: Icons.badge,
                        items: EmploymentType.values,
                        itemBuilder: (type) => type.name.toTitleCase,
                      ),
                      const SizedBox(height: 16),
                      AppDropdown<JobStatus>(
                        name: JobFormKeys.status,
                        label: 'Status',
                        icon: Icons.flag,
                        items: JobStatus.values,
                        itemBuilder: (status) => status.name.capitalize,
                      ),
                      const SizedBox(height: 16),
                      const AppDatePicker(
                        name: JobFormKeys.dateApplied,
                        label: 'Date Applied',
                      ),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Additional Information'),
                      const SizedBox(height: 16),
                      const AppTextField(
                        name: JobFormKeys.recruiterName,
                        label: 'Recruiter Name (Optional)',
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 16),
                      _buildCurrencyField(),
                      const SizedBox(height: 16),
                      const AppTextField(
                        name: JobFormKeys.notes,
                        label: 'Notes (Optional)',
                        icon: Icons.note,
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildCurrencyField() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ValueListenableBuilder(
            valueListenable: _currencySymbol,
            builder: (context, value, child) {
              return AppTextField(
                name: JobFormKeys.salaryRequested,
                label: 'Salary (Optional)',
                prefixText: value,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AppCurrencyPicker(
            name: JobFormKeys.currency,
            label: 'Currency',
            onChanged: (currency) {
              _currencySymbol.value = currency.symbol;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    final buttonWidget = ElevatedButton(
      onPressed: widget.isLoading ? null : _onSubmit,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        _isEditing ? 'Update Application' : 'Create Application',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );

    return widget.isLoading
        ? ShimmerBox(
            child: buttonWidget,
          )
        : buttonWidget;
  }
}
