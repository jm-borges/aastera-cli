import 'package:flutter/material.dart';
import '../../../../forms/auth/forgot_password_form.dart';
import '../../components/web_auth_scaffold.dart';
import '../components/login_link.dart';
import '../components/register_link.dart';
import 'components/forgot_password_form_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordForm _form = ForgotPasswordForm();

  @override
  Widget build(BuildContext context) {
    return WebAuthScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildMainContent(),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildForm(),
        const SizedBox(height: 24),
        _buildLoginLink(),
        _buildRegisterLink(),
      ],
    );
  }

  Widget _buildForm() {
    return ForgotPasswordFormWidget(form: _form);
  }

  Widget _buildRegisterLink() {
    return RegisterLink();
  }

  Widget _buildLoginLink() {
    return LoginLink();
  }
}
