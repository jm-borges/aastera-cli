import 'package:flutter/material.dart';
import '../../views/mobile/auth/forgot_password/forgot_password_screen.dart';
import '../../views/mobile/auth/login/login_screen.dart';
import '../../views/mobile/auth/register/register_screen.dart';
import '../../views/mobile/main/home/home_screen.dart';

final Map<String, WidgetBuilder> mobileRoutes = {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/forgot-password': (context) => const ForgotPasswordScreen(),
  '/home': (context) => HomeScreen(),
};
