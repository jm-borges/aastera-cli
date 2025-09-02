// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'chat_button.dart';
import 'home_button.dart';
import 'my_account_button.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AppBottomNavigationBar({super.key, required this.scaffoldKey});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        border: Border(top: BorderSide(color: Color(0xFF9BA5D0))),
      ),
      height: kBottomNavigationBarHeight * 1.2,
      child: Row(children: _buildNavItems()),
    );
  }

  List<Widget> _buildNavItems() {
    return [
      HomeButton(index: 1, widthFactor: 1 / 3),
      ChatButton(index: 2, widthFactor: 1 / 3),
      MyAccountButton(index: 3, widthFactor: 1 / 3),
    ];
  }
}
