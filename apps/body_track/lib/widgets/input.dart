import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input(
      {super.key,
      required this.label,
      this.validator,
      this.controller,
      this.decimal,
      this.variant});
  final String label;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final bool? decimal;
  final String? variant;

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
        ),
        keyboardType: TextInputType.numberWithOptions(
            decimal: decimal ?? true),
      ),
    );
  }
}
