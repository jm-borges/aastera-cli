import 'package:flutter/material.dart';
import '../../../../forms/auth/register_form.dart';

class NameField extends StatefulWidget {
  final RegisterForm form;

  const NameField({super.key, required this.form});

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.form.nameController,
      decoration: const InputDecoration(
        labelText: 'Nome completo',
        border: OutlineInputBorder(),
      ),
      validator: widget.form.validateName,
    );
  }
}
