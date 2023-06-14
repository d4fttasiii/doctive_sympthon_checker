import 'package:flutter/material.dart';

class BorderedTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final TextInputType keyboardType;

  const BorderedTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.maxLength,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        ),
        validator: validator,
        maxLength: maxLength,
        keyboardType: keyboardType,
      ),
    );
  }
}
