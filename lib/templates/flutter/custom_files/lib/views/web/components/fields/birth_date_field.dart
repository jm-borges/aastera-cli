import '../../../../forms/main/user_form.dart';
import '../../../../utilities/forms.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BirthDateField extends StatefulWidget {
  final UserForm form;

  const BirthDateField({super.key, required this.form});

  @override
  State<BirthDateField> createState() => _BirthDateFieldState();
}

class _BirthDateFieldState extends State<BirthDateField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.form.birthDateController,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DataInputFormatter(),
      ],
      decoration: InputDecoration(
        labelText: 'Data de nascimento',
        border: OutlineInputBorder(),
        suffixIcon: buildDatePicker(context, widget.form.birthDateController),
      ),
    );
  }
}
