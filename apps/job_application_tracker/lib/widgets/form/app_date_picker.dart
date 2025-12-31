import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppDatePicker extends StatelessWidget {
  const AppDatePicker({
    required this.name,
    required this.label,
    this.icon = Icons.calendar_today,
    this.lastDate,
    this.firstDate,
    this.validator,
    super.key,
  });

  final String name;
  final String label;
  final IconData icon;
  final DateTime? lastDate;
  final DateTime? firstDate;
  final String? Function(DateTime?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: name,
      inputType: InputType.date,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
      ),
      firstDate: firstDate,
      lastDate: lastDate,
      validator: validator,
    );
  }
}
