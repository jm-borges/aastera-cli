// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'auth_form_with_register.dart';
import '../../services/auth_service.dart';
import '../../utilities/snackbars.dart';

class ResetPasswordForm extends AuthFormWithRegister {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  String token;

  ResetPasswordForm({required this.token});

  Map<String, dynamic> toMap() {
    return {'token': token, 'password': passwordController.text.trim()};
  }

  Future<void> resetPassword(BuildContext context) async {
    await AuthService.resetPassword(toMap());
    showSuccessSnackBar(context, 'Senha redefinida com sucesso.');
    Navigator.pushReplacementNamed(context, '/login');
  }
}
