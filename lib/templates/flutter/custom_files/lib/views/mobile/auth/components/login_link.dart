import 'package:flutter/material.dart';

class LoginLink extends StatefulWidget {
  const LoginLink({super.key});

  @override
  State<LoginLink> createState() => _LoginLinkState();
}

class _LoginLinkState extends State<LoginLink> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/login'),
      child: const Text('Já tem uma conta?'),
    );
  }
}
