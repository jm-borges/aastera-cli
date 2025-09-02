import 'package:flutter/material.dart';
import '../../../../../forms/auth/forgot_password_form.dart';
import '../../../../../utilities/global.dart';
import '../../../components/fields/email_field.dart';

class ForgotPasswordFormWidget extends StatefulWidget {
  final ForgotPasswordForm form;

  const ForgotPasswordFormWidget({super.key, required this.form});

  @override
  State<ForgotPasswordFormWidget> createState() =>
      _ForgotPasswordFormWidgetState();
}

class _ForgotPasswordFormWidgetState extends State<ForgotPasswordFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.form.key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildEmailField(),
          const SizedBox(height: 24),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return EmailField(form: widget.form);
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _handleSubmitButtonPress,
      child: const Text('Solicitar redefinição'),
    );
  }

  Future<void> _handleSubmitButtonPress() async {
    await executeFormAction(
      widget.form.key,
      () async => await widget.form.startPasswordRedefinition(context),
      context,
    );
  }
}
