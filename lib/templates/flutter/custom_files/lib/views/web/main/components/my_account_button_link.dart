import 'package:flutter/material.dart';

class MyAccountButtonLink extends StatefulWidget {
  const MyAccountButtonLink({super.key});

  @override
  State<MyAccountButtonLink> createState() => _MyAccountButtonLinkState();
}

class _MyAccountButtonLinkState extends State<MyAccountButtonLink> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleMyAccountButtonTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person, color: Colors.white),
              const SizedBox(width: 8),
              const Text('Minha conta', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMyAccountButtonTap() {
    Navigator.pushNamed(context, '/account');
  }
}
