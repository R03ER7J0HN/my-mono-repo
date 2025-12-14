import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    required this.name,
    required this.label,
    required this.icon,
    required this.items,
    required this.itemBuilder,
    super.key,
  });

  final String name;
  final String label;
  final IconData icon;
  final List<T> items;
  final String Function(T) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<T>(
      name: name,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(itemBuilder(item)),
            ),
          )
          .toList(),
      validator: FormBuilderValidators.required(),
    );
  }
}
