import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/installments/installment_entry/cubit/installment_entry_cubit.dart';
import 'package:budget_tracker/features/installments/installment_entry/cubit/installment_entry_state.dart';
import 'package:budget_tracker/widgets/background_decoration.dart';
import 'package:budget_tracker/widgets/budget_widgets.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class InstallmentEntryScreen extends StatelessWidget {
  const InstallmentEntryScreen({
    this.installment,
    super.key,
  });

  final InstallmentEntity? installment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InstallmentEntryCubit(
        installmentRepository: GetIt.I<InstallmentRepository>(),
        accountRepository: GetIt.I<AccountRepository>(),
        existingInstallment: installment,
      ),
      child: const _InstallmentEntryView(),
    );
  }
}

class _InstallmentEntryView extends StatefulWidget {
  const _InstallmentEntryView();

  @override
  State<_InstallmentEntryView> createState() => _InstallmentEntryViewState();
}

class _InstallmentEntryViewState extends State<_InstallmentEntryView> {
  late final TextEditingController _descriptionController;
  late final TextEditingController _amountController;
  late final TextEditingController _installmentsController;
  late final TextEditingController _paidController;

  @override
  void initState() {
    super.initState();
    final state = context.read<InstallmentEntryCubit>().state;
    _descriptionController = TextEditingController(text: state.description);
    _amountController = TextEditingController(
      text: state.totalAmount != 0 ? state.totalAmount.toString() : '',
    );
    _installmentsController = TextEditingController(
      text: state.totalInstallments.toString(),
    );
    _paidController = TextEditingController(
      text: state.paidInstallments.toString(),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _installmentsController.dispose();
    _paidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<InstallmentEntryCubit, InstallmentEntryState>(
      listenWhen: (prev, curr) =>
          prev.error != curr.error && curr.error != null,
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<InstallmentEntryCubit>();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.isEditing ? 'Edit Installment' : 'New Installment',
            ),
            actions: [
              TextButton(
                onPressed: state.isValid && !state.isSaving
                    ? () async {
                        final success = await cubit.save();
                        if (success && context.mounted) {
                          context.pop();
                        }
                      }
                    : null,
                child: state.isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ],
          ),
          body: BackgroundDecoration(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Installment Details',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: 'e.g., iPhone 15 Pro',
                            prefixIcon: Icon(Icons.description_outlined),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: cubit.setDescription,
                        ),
                        const SizedBox(height: 16),
                        if (state.creditCardAccounts.isEmpty)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.errorContainer
                                  .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber,
                                  color: theme.colorScheme.error,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Add a credit card account first',
                                    style: TextStyle(
                                      color: theme.colorScheme.error,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          DropdownButtonFormField<String>(
                            // Using value instead of initialValue since we're
                            // using controlled form field with external state.
                            // ignore: deprecated_member_use
                            value: state.accountId,
                            decoration: const InputDecoration(
                              labelText: 'Credit Card',
                              prefixIcon: Icon(Icons.credit_card),
                            ),
                            items: state.creditCardAccounts.map((account) {
                              return DropdownMenuItem(
                                value: account.id,
                                child: Row(
                                  children: [
                                    AccountTypeIcon(
                                      type: account.type,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(account.name),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: cubit.setAccountId,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Plan',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            labelText: 'Total Amount',
                            hintText: '0.00',
                            prefixIcon: Icon(Icons.monetization_on_outlined),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'),
                            ),
                          ],
                          onChanged: (value) {
                            final amount = double.tryParse(value) ?? 0;
                            cubit.setTotalAmount(amount);
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _installmentsController,
                                decoration: const InputDecoration(
                                  labelText: 'Total Installments',
                                  hintText: '12',
                                  prefixIcon: Icon(Icons.calendar_month),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  final count = int.tryParse(value) ?? 0;
                                  cubit.setTotalInstallments(count);
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: _paidController,
                                decoration: const InputDecoration(
                                  labelText: 'Already Paid',
                                  hintText: '0',
                                  prefixIcon: Icon(Icons.check_circle_outline),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  final count = int.tryParse(value) ?? 0;
                                  cubit.setPaidInstallments(count);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Payment Frequency',
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 12),
                        SegmentedButton<InstallmentFrequency>(
                          segments: InstallmentFrequency.values.map((freq) {
                            return ButtonSegment(
                              value: freq,
                              label: Text(freq.displayName),
                            );
                          }).toList(),
                          selected: {state.frequency},
                          onSelectionChanged: (selection) {
                            cubit.setFrequency(selection.first);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Date',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.calendar_today),
                          title: Text(
                            DateFormat.yMMMd().format(
                              state.installmentStartDate,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: state.installmentStartDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (date != null) {
                              cubit.setStartDate(date);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (state.totalAmount > 0 && state.totalInstallments > 0)
                    GlassCard(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Summary',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _SummaryRow(
                            label:
                                'Payment per '
                                '${state.frequency.displayName.toLowerCase()}',
                            value: state.monthlyAmount.toStringAsFixed(2),
                            isHighlighted: true,
                          ),
                          const SizedBox(height: 8),
                          _SummaryRow(
                            label: 'Remaining amount',
                            value: state.remainingAmount.toStringAsFixed(2),
                          ),
                          const SizedBox(height: 8),
                          _SummaryRow(
                            label: 'End date',
                            value: DateFormat.yMMMd().format(state.endDate),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isHighlighted = false,
  });

  final String label;
  final String value;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            color: isHighlighted ? theme.colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
}
