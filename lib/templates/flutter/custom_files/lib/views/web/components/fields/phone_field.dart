import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../forms/main/user_form.dart';

class PhoneField extends StatefulWidget {
  final UserForm form;

  const PhoneField({super.key, required this.form});

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.form.phoneController,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TelefoneInputFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: 'Telefone',
        border: OutlineInputBorder(),
      ),
    );
  }
}
