import 'package:flutter/material.dart';
import '../../../forms/auth/auth_form.dart';

class EmailField extends StatefulWidget {
  final AuthForm form;

  const EmailField({super.key, required this.form});

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.form.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: widget.form.validateEmail,
    );
  }
}
