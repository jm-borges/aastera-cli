import 'package:flutter/material.dart';

class ForgotPasswordLink extends StatefulWidget {
  const ForgotPasswordLink({super.key});

  @override
  State<ForgotPasswordLink> createState() => _ForgotPasswordLinkState();
}

class _ForgotPasswordLinkState extends State<ForgotPasswordLink> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
      child: const Text('Esqueceu a senha?'),
    );
  }
}
