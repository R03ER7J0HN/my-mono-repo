import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AppCurrencyPicker extends StatelessWidget {
  const AppCurrencyPicker({
    required this.name,
    required this.label,
    this.onChanged,
    super.key,
  });

  final String name;
  final String label;
  final ValueChanged<Currency>? onChanged;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: name,
      builder: (field) {
        final currencyCode = field.value;
        final currency = currencyCode != null
            ? CurrencyService().findByCode(currencyCode)
            : null;

        return GestureDetector(
          onTap: () => showCurrencyPicker(
            context: context,
            onSelect: (Currency c) {
              field.didChange(c.code);
              onChanged?.call(c);
            },
            physics: const BouncingScrollPhysics(),
            theme: CurrencyPickerThemeData(
              bottomSheetHeight: MediaQuery.of(context).size.height * 2 / 3,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
            ),
          ),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              suffixIcon: const Icon(Icons.arrow_drop_down),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.5),
              errorText: field.errorText,
            ),
            child: Text(
              currency != null ? currency.code : 'Select Currency',

              style: currency == null
                  ? TextStyle(color: Theme.of(context).hintColor)
                  : null,
            ),
          ),
        );
      },
    );
  }
}
