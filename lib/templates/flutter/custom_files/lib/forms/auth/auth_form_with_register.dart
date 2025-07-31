// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'auth_form.dart';

class AuthFormWithRegister extends AuthForm {
  TextEditingController confirmPasswordController = TextEditingController();

  String? validateConfirmPassword(String? value) {
    final confirmPassword = value?.trim() ?? '';
    final password = passwordController.text.trim();

    if (confirmPassword.isEmpty) {
      return 'Confirme sua senha';
    }

    if (confirmPassword != password) {
      return 'As senhas não coincidem';
    }

    return null;
  }
}
