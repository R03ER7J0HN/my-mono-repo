import 'package:budget_core/budget_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BudgetEntryDialog extends StatefulWidget {
  const BudgetEntryDialog({
    required this.onSave,
    this.currentBudget,
    super.key,
  });

  final MonthlyBudgetEntity? currentBudget;
  final Future<void> Function(
    double totalBudget,
    double? dailyBudget,
    String? notes,
  )
  onSave;

  @override
  State<BudgetEntryDialog> createState() => _BudgetEntryDialogState();
}

class _BudgetEntryDialogState extends State<BudgetEntryDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _totalBudgetController;
  late final TextEditingController _dailyBudgetController;
  late final TextEditingController _notesController;
  bool _useDailyBudget = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final budget = widget.currentBudget;
    _totalBudgetController = TextEditingController(
      text: budget?.totalBudget.toStringAsFixed(2) ?? '',
    );
    _dailyBudgetController = TextEditingController(
      text: budget?.dailyBudget?.toStringAsFixed(2) ?? '',
    );
    _notesController = TextEditingController(
      text: budget?.notes ?? '',
    );
    _useDailyBudget = budget?.dailyBudget != null;
  }

  @override
  void dispose() {
    _totalBudgetController.dispose();
    _dailyBudgetController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.currentBudget != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Budget' : 'Set Monthly Budget'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _totalBudgetController,
                decoration: const InputDecoration(
                  labelText: 'Total Budget',
                  prefixText: r'$ ',
                  hintText: '0.00',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}'),
                  ),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a budget amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Set fixed daily budget'),
                subtitle: const Text('Override calculated daily budget'),
                value: _useDailyBudget,
                onChanged: (value) {
                  setState(() {
                    _useDailyBudget = value;
                    if (!value) {
                      _dailyBudgetController.clear();
                    }
                  });
                },
              ),
              if (_useDailyBudget) ...[
                const SizedBox(height: 8),
                TextFormField(
                  controller: _dailyBudgetController,
                  decoration: const InputDecoration(
                    labelText: 'Daily Budget',
                    prefixText: r'$ ',
                    hintText: '0.00',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}'),
                    ),
                  ],
                  validator: (value) {
                    if (!_useDailyBudget) return null;
                    if (value == null || value.isEmpty) {
                      return 'Please enter a daily budget';
                    }
                    final amount = double.tryParse(value);
                    if (amount == null || amount <= 0) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  hintText: 'Any notes about this budget...',
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isSaving ? null : _handleSave,
          child: _isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    final totalBudget = double.parse(_totalBudgetController.text);
    final dailyBudget =
        _useDailyBudget && _dailyBudgetController.text.isNotEmpty
        ? double.parse(_dailyBudgetController.text)
        : null;
    final notes = _notesController.text.isNotEmpty
        ? _notesController.text
        : null;

    await widget.onSave(totalBudget, dailyBudget, notes);

    if (mounted) {
      setState(() {
        _isSaving = false;
      });
    }
  }
}
