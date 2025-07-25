// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'auth_form.dart';
import '../../services/auth_service.dart';
import '../../utilities/snackbars.dart';

class ForgotPasswordForm extends AuthForm {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  Map<String, dynamic> toMap() {
    return {'email': emailController.text.trim()};
  }

  Future<void> startPasswordRedefinition(BuildContext context) async {
    await AuthService.startPasswordReset(toMap());
    showSuccessSnackBar(
      context,
      'Sucesso! Um e-mail com informações para redefinir a senha foi enviado.',
    );
    Navigator.pushReplacementNamed(context, '/login');
  }
}
