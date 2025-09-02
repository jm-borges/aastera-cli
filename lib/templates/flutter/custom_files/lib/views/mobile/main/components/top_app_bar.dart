import 'package:flutter/material.dart';
import 'my_account_button_link.dart';

class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  State<TopAppBar> createState() => _TopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopAppBarState extends State<TopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      backgroundColor: Theme.of(context).focusColor,
      actions: [MyAccountButtonLink()],
    );
  }
}
