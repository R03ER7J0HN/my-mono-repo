import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppTimePicker extends StatelessWidget {
  const AppTimePicker({
    required this.name,
    required this.label,
    this.icon = Icons.access_time,
    this.validator,
    super.key,
  });

  final String name;
  final String label;
  final IconData icon;
  final String? Function(TimeOfDay?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<TimeOfDay>(
      name: name,
      validator: validator,
      builder: (field) {
        final value = field.value;
        final hasError = field.hasError;

        return GestureDetector(
          onTap: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: value ?? TimeOfDay.now(),
            );

            if (picked != null) {
              field.didChange(picked);
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: Icon(icon),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.5),
              errorText: hasError ? field.errorText : null,
            ),
            child: Text(
              value != null ? value.format(context) : '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        );
      },
    );
  }
}
