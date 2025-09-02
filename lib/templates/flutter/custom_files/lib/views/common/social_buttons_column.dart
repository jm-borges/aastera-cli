import 'package:flutter/material.dart';
import 'package:oracle_app/views/common/apple_sign_in_button.dart';
import 'package:oracle_app/views/common/google_sign_in_button.dart';
import 'package:oracle_app/views/common/meta_sign_in_button.dart';
import 'package:oracle_app/views/common/microsoft_sign_in_button.dart';

class SocialButtonsColumn extends StatefulWidget {
  const SocialButtonsColumn({super.key});

  @override
  State<SocialButtonsColumn> createState() => _SocialButtonsColumnState();
}

class _SocialButtonsColumnState extends State<SocialButtonsColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildGoogleSignInButton(),
        const SizedBox(height: 10),
        _buildAppleSignInButton(),
        const SizedBox(height: 10),
        _buildMicrosoftSignInButton(),
        const SizedBox(height: 10),
        _buildMetaSignInButton(),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildGoogleSignInButton() {
    return GoogleSignInButton();
  }

  Widget _buildAppleSignInButton() {
    return AppleSignInButton();
  }

  Widget _buildMicrosoftSignInButton() {
    return MicrosoftSignInButton();
  }

  Widget _buildMetaSignInButton() {
    return MetaSignInButton();
  }
}
