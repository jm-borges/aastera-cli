// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';

import 'user_secure_storage.dart';

Future<void> logout(BuildContext context) async {
  await UserSecureStorage.unsetUserData();
  Navigator.pushNamedAndRemoveUntil(
    context,
    '/login',
    (Route<dynamic> route) => false,
  );
}
