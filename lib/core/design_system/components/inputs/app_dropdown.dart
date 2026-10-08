import 'package:flutter/material.dart';

class AppDropdownOption<T> {
  const AppDropdownOption({
    required this.value,
    required this.label,
  });

  final T value;
  final String label;
}

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.options,
    required this.onChanged,
    this.value,
    this.label,
    this.hint,
    this.errorText,
    this.validator,
    this.enabled = true,
  });

  final List<AppDropdownOption<T>> options;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final String? label;
  final String? hint;
  final String? errorText;
  final FormFieldValidator<T>? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: options
          .map(
            (option) => DropdownMenuItem<T>(
              value: option.value,
              child: Text(option.label),
            ),
          )
          .toList(growable: false),
      onChanged: enabled ? onChanged : null,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
      ),
    );
  }
}
