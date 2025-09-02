import 'package:flutter/material.dart';
import 'nav_item.dart';

class MyAccountButton extends StatefulWidget {
  final int index;
  final double widthFactor;

  const MyAccountButton({super.key, required this.index, this.widthFactor = 1});

  @override
  State<MyAccountButton> createState() => _MyAccountButtonState();
}

class _MyAccountButtonState extends State<MyAccountButton> {
  @override
  Widget build(BuildContext context) {
    return NavItem(
      icon: const Icon(Icons.person, size: 30, color: Colors.white),
      index: widget.index,
      onTap: _handleNavigate,
      widthFactor: widget.widthFactor,
    );
  }

  void _handleNavigate() {
    Navigator.pushNamed(context, '/account');
  }
}
