import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../forms/main/user_form.dart';

class DocumentNumberField extends StatefulWidget {
  final UserForm form;

  const DocumentNumberField({super.key, required this.form});

  @override
  State<DocumentNumberField> createState() => _DocumentNumberFieldState();
}

class _DocumentNumberFieldState extends State<DocumentNumberField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.form.documentNumberController,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CpfOuCnpjFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: 'Documento (CPF/CNPJ)',
        border: OutlineInputBorder(),
      ),
    );
  }
}
