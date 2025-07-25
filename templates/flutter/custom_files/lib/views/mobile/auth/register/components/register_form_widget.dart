import 'package:flutter/material.dart';

import '../../../../../forms/auth/register_form.dart';
import '../../../../../utilities/global.dart';
import '../../../../mobile/auth/components/confirm_password_field.dart';
import '../../../../mobile/auth/components/email_field.dart';
import '../../../../mobile/auth/components/name_field.dart';
import '../../../../mobile/auth/components/password_field.dart';

class RegisterFormWidget extends StatefulWidget {
  final RegisterForm form;

  const RegisterFormWidget({super.key, required this.form});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.form.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildNameField(),
          const SizedBox(height: 16),
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildPasswordField(),
          const SizedBox(height: 16),
          _buildConfirmPasswordField(),
          const SizedBox(height: 24),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return NameField(form: widget.form);
  }

  Widget _buildEmailField() {
    return EmailField(form: widget.form);
  }

  Widget _buildPasswordField() {
    return PasswordField(form: widget.form);
  }

  Widget _buildConfirmPasswordField() {
    return ConfirmPasswordField(form: widget.form);
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _handleSubmitButtonPress,
      child: const Text('Registrar'),
    );
  }

  Future<void> _handleSubmitButtonPress() async {
    await executeFormAction(
      widget.form.key,
      () async => await widget.form.register(context),
      context,
    );
  }
}
