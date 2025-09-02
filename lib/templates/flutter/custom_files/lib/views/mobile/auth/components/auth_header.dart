import 'package:flutter/material.dart';
import '../../../common/app_logo.dart';

class AuthHeader extends StatefulWidget {
  const AuthHeader({super.key});

  @override
  State<AuthHeader> createState() => _AuthHeaderState();
}

class _AuthHeaderState extends State<AuthHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 60),
        _buildLogo(),
        const SizedBox(height: 36),
      ],
    );
  }

  Widget _buildLogo() {
    return AppLogo();
  }
}
