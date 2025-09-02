import 'package:flutter/material.dart';

import '../../../../forms/auth/login_form.dart';
import '../components/web_auth_scaffold.dart';
import '../components/forgot_password_link.dart';
import '../components/register_link.dart';
import 'components/login_form_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginForm _form = LoginForm();

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
        _buildRegisterLink(),
        _buildForgotPasswordLink(),
      ],
    );
  }

  Widget _buildForm() {
    return LoginFormWidget(form: _form);
  }

  Widget _buildRegisterLink() {
    return RegisterLink();
  }

  Widget _buildForgotPasswordLink() {
    return ForgotPasswordLink();
  }
}
