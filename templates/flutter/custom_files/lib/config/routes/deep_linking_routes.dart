import 'package:flutter/material.dart';
import '../../main.dart';
import '../../views/mobile/auth/reset_password/reset_password_screen.dart';

final Map<String, void Function(Uri uri)> deepLinkingRoutes = {
  'reset-password': _handleResetPasswordDeepLink,
};

void _handleResetPasswordDeepLink(Uri uri) {
  final token = uri.queryParameters['token'];
  if (token != null) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => ResetPasswordScreen(token: token),
      ),
    );
  }
}
