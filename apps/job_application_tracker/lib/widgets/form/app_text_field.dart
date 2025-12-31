import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.name,
    required this.label,
    super.key,
    this.icon,
    this.prefixText,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
  });

  final String name;
  final String label;
  final IconData? icon;
  final String? prefixText;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixText != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prefixText!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            : (icon != null ? Icon(icon) : null),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
        hintText: hintText,
      ),
      onChanged: (value) {
        onChanged?.call(value);
      },
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      textCapitalization: textCapitalization,
    );
  }
}
