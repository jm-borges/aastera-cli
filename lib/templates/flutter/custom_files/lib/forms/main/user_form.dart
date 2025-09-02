// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../forms/auth/auth_form_with_name.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';
import '../../services/user_service.dart';
import '../../utilities/snackbars.dart';
import '../../utilities/strings.dart';
import '../../utilities/time.dart';
import 'package:provider/provider.dart';

class UserForm extends AuthFormWithName {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  User? user;

  TextEditingController birthDateController = TextEditingController();
  TextEditingController documentNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  PlatformFile? profileImage;

  UserForm({this.user}) {
    nameController.text = user?.name ?? '';
    emailController.text = user?.email ?? '';
    documentNumberController.text = user?.documentNumber ?? '';
    phoneController.text = user?.phone ?? '';
    profileImage = user?.profileImage;
    birthDateController.text = user?.birthDate != null
        ? DateFormat('dd/MM/yyyy').format(user!.birthDate!)
        : '';
  }

  Map<String, dynamic> toMap() {
    final map = {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'document_number': cleanSpecialCharacters(
        documentNumberController.text.trim(),
      ),
      'phone': cleanSpecialCharacters(phoneController.text.trim()),
      'birth_date': formatBirthDateForApi(birthDateController.text.trim()),
    };

    final password = passwordController.text.trim();
    if (password.isNotEmpty) {
      map['password'] = password;
    }

    return map;
  }

  DateTime? get birthDate {
    final text = birthDateController.text.trim();
    if (text.isEmpty) return null;

    try {
      return DateFormat('dd/MM/yyyy').parseStrict(text);
    } catch (e) {
      return null;
    }
  }

  Future<void> update(BuildContext context) async {
    user = await UserService.update(toMap(), user!.id);
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    userProvider.user = user;
    userProvider.notify();
    showSuccessSnackBar(context, 'Atualizado com sucesso');
  }
}
