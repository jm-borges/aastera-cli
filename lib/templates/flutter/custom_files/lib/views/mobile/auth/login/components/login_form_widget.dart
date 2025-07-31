import 'package:flutter/material.dart';

import '../../../../../forms/auth/login_form.dart';
import '../../../../../utilities/global.dart';
import '../../components/email_field.dart';
import '../../components/password_field.dart';

class LoginFormWidget extends StatefulWidget {
  final LoginForm form;

  const LoginFormWidget({super.key, required this.form});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.form.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildPasswordField(),
          const SizedBox(height: 24),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return EmailField(form: widget.form);
  }

  Widget _buildPasswordField() {
    return PasswordField(form: widget.form);
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _handleSubmitButtonPress,
      child: const Text('Entrar'),
    );
  }

  Future<void> _handleSubmitButtonPress() async {
    await executeFormAction(
      widget.form.key,
      () async => await widget.form.login(context),
      context,
    );
  }
}
