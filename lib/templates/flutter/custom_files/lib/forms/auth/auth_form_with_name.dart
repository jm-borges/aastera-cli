import 'package:flutter/material.dart';
import 'auth_form_with_register.dart';

class AuthFormWithName extends AuthFormWithRegister {
  TextEditingController nameController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe seu nome';
    }
    return null;
  }
}
