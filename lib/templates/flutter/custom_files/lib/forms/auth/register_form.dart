// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'auth_form_with_register.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../utilities/navigation.dart';
import '../../utilities/snackbars.dart';

class RegisterForm extends AuthFormWithRegister {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe seu nome';
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
    };
  }

  Future<void> register(BuildContext context) async {
    Map<String, dynamic> result = await AuthService.register(toMap());
    User user = result['user'];
    String token = result['token'];
    showSuccessSnackBar(context, 'Cadastro realizado com sucesso.');
    await updateAuthenticatedUser(context, user, token);
    Navigator.pushReplacementNamed(context, '/home');
  }
}
