import 'package:flutter/material.dart';

import '../../../../../forms/auth/reset_password_form.dart';
import '../../../../../utilities/global.dart';
import '../../components/confirm_password_field.dart';
import '../../components/password_field.dart';

class ResetPasswordFormWidget extends StatefulWidget {
  final ResetPasswordForm form;

  const ResetPasswordFormWidget({super.key, required this.form});

  @override
  State<ResetPasswordFormWidget> createState() =>
      _ResetPasswordFormWidgetState();
}

class _ResetPasswordFormWidgetState extends State<ResetPasswordFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.form.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPasswordField(),
          const SizedBox(height: 16),
          _buildConfirmPasswordField(),
          const SizedBox(height: 24),
          _buildSubmitButton(),
        ],
      ),
    );
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
      child: const Text('Redefinir senha'),
    );
  }

  Future<void> _handleSubmitButtonPress() async {
    await executeFormAction(
      widget.form.key,
      () async => await widget.form.resetPassword(context),
      context,
    );
  }
}
