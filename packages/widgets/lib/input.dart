import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input(
      {super.key,
      required this.label,
      this.validator,
      this.controller,
      this.decimal,
      this.variant,
      this.keyboardType,
      this.leading,
      this.onChanged});
  final String label;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final bool? decimal;
  final String? variant;
  final TextInputType? keyboardType;
  final Widget? leading;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: TextFormField(
        controller: controller,
        // The validator receives the text that the user has entered.
        validator: validator,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          prefixIcon: leading,
        ),
        keyboardType: keyboardType ?? TextInputType.number,
        onChanged: onChanged,
      ),
    );
  }
}
