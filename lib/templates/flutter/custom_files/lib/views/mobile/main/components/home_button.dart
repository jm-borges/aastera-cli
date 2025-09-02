import 'package:flutter/material.dart';
import 'nav_item.dart';
import '../home/home_screen.dart';

class HomeButton extends StatefulWidget {
  final int index;
  final double widthFactor;

  const HomeButton({super.key, required this.index, this.widthFactor = 1});

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  Widget build(BuildContext context) {
    return NavItem(
      icon: const Icon(Icons.home, size: 30, color: Colors.white),
      index: widget.index,
      onTap: _handleNavigate,
      widthFactor: widget.widthFactor,
    );
  }

  void _handleNavigate() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}
