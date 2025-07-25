import 'package:flutter/material.dart';
import '../../../../forms/auth/auth_form.dart';

class PasswordField extends StatefulWidget {
  final AuthForm form;

  const PasswordField({super.key, required this.form});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.form.passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'Senha',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: _toggleVisibility,
        ),
      ),
      validator: widget.form.validatePassword,
    );
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
