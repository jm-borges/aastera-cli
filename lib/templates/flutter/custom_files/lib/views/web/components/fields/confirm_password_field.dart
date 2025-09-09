import 'package:flutter/material.dart';
import '../../../../forms/auth/auth_form_with_register.dart';

class ConfirmPasswordField extends StatefulWidget {
  final AuthFormWithRegister form;

  const ConfirmPasswordField({super.key, required this.form});

  @override
  State<ConfirmPasswordField> createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.form.confirmPasswordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'Confirmar senha',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: _toggleVisibility,
        ),
      ),
      validator: widget.form.validateConfirmPassword,
    );
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
