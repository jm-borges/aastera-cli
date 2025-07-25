import 'package:flutter/material.dart';

class RegisterLink extends StatefulWidget {
  const RegisterLink({super.key});

  @override
  State<RegisterLink> createState() => _RegisterLinkState();
}

class _RegisterLinkState extends State<RegisterLink> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/register'),
      child: const Text('Criar conta'),
    );
  }
}
