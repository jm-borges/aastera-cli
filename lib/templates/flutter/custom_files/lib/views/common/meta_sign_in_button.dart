import 'package:flutter/material.dart';

class MetaSignInButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const MetaSignInButton({super.key, this.onPressed});

  @override
  State<MetaSignInButton> createState() => _MetaSignInButtonState();
}

class _MetaSignInButtonState extends State<MetaSignInButton> {
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
      icon: Image.asset('assets/images/meta_logo.png', height: 20, width: 20),
      label: const Text(
        'Entrar com Meta',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
