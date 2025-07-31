import 'package:flutter/material.dart';

import '../../../../forms/auth/reset_password_form.dart';
import '../../components/web_auth_scaffold.dart';
import '../components/login_link.dart';
import '../components/register_link.dart';
import 'components/reset_password_form_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;

  const ResetPasswordScreen({super.key, required this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late final ResetPasswordForm _form;

  @override
  void initState() {
    _form = ResetPasswordForm(token: widget.token);
    super.initState();
  }

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
    return ResetPasswordFormWidget(form: _form);
  }

  Widget _buildLoginLink() {
    return LoginLink();
  }

  Widget _buildRegisterLink() {
    return RegisterLink();
  }
}
