// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'storage/cookie/user_cookie_service.dart';
import 'storage/secure_storage/user_secure_storage_service.dart';
import 'package:flutter/widgets.dart';

Future<void> logout(BuildContext context) async {
  if (kIsWeb) {
    await UserCookieService.unsetUserData();
  } else {
    await UserSecureStorageService.clearUserData();
  }

  Navigator.pushNamedAndRemoveUntil(
    context,
    '/login',
    (Route<dynamic> route) => false,
  );
}
