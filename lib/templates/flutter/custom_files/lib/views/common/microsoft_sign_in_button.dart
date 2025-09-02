import 'package:flutter/material.dart';

class MicrosoftSignInButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const MicrosoftSignInButton({super.key, this.onPressed});

  @override
  State<MicrosoftSignInButton> createState() => _MicrosoftSignInButtonState();
}

class _MicrosoftSignInButtonState extends State<MicrosoftSignInButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        elevation: 2,
      ),
      icon: Image.asset(
        'assets/images/microsoft_logo.png',
        height: 20,
        width: 20,
      ),
      label: const Text(
        'Entrar com Microsoft',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
