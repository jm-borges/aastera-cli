import 'package:flutter/material.dart';

import '../../../../forms/auth/register_form.dart';
import '../../components/mobile_auth_scaffold.dart';
import '../components/login_link.dart';
import 'components/register_form_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterForm _form = RegisterForm();

  @override
  Widget build(BuildContext context) {
    return MobileAuthScaffold(
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
      children: [_buildForm(), const SizedBox(height: 24), _buildLoginLink()],
    );
  }

  Widget _buildForm() {
    return RegisterFormWidget(form: _form);
  }

  Widget _buildLoginLink() {
    return LoginLink();
  }
}
