import 'package:flutter/material.dart';
import 'nav_item.dart';

class ChatButton extends StatefulWidget {
  final int index;
  final double widthFactor;

  const ChatButton({super.key, required this.index, this.widthFactor = 1});

  @override
  State<ChatButton> createState() => _ChatButtonState();
}

class _ChatButtonState extends State<ChatButton> {
  @override
  Widget build(BuildContext context) {
    return NavItem(
      icon: const Icon(Icons.chat, size: 30, color: Colors.white),
      index: widget.index,
      onTap: _handleNavigate,
      widthFactor: widget.widthFactor,
    );
  }

  void _handleNavigate() {
    Navigator.pushNamed(context, '/chat');
  }
}
